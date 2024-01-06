module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_order, only: %i[ show update destroy ]

      
      def index
        @orders = Order.all.map do |order|
          {
            order: order.as_json,
            items: order.items.map do |item|
              {
                quantity: item.quantity,
                product: item.product.as_json(only: %i[id name description])
              }
            end
          }
        end
      
        render json: @orders
      end

      
      def show
        render json: {
          order: @order.as_json,
          items: @order.items.map do |item|
            {
              quantity: item.quantity,
              # subtotal: item.subtotal,
              product: item.product.as_json(only: %i[id name description]) 
            }
          end
        }
      end

     

      
      def create
        @order = Order.new(order_params.merge(status: "in_process"))
        
        if @order.save
          render json: @order, status: :created#, location: api_v1_order_url(@order)
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def update
        if @order.update(order_params)
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def set_ready
        @order = Order.find(params[:id])
        if @order.update(status: 'ready')
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def set_finished
        @order = Order.find(params[:id])
        if @order.update(status: 'finish')
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def destroy
        render json: @order.destroy!
      end

      private
      def set_order
         @order = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit( :date, :table_id, :employee_id, items_attributes: [:quantity, :product_id])
       end
    end
  end
end
