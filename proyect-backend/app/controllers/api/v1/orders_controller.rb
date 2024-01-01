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
              product: item.product.as_json(only: %i[id name description]) # Ajusta según los atributos que desees mostrar
            }
          end
        }
      end

     

      
      def create
        @order = Order.new(order_params.merge(status: "in_process"))
        
        if @order.save
          OrderChannel.broadcast_to("orders", { action: "created", order: @order })
          render json: @order, status: :created#, location: api_v1_order_url(@order)
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def update
        if @order.update(order_params)
          OrderChannel.broadcast_to("orders", { action: "updated", order: @order })

          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def set_ready
        if @order.update(status: 'ready')
          OrderChannel.broadcast_to("orders", { action: "updated", order: @order })
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def set_finished
        if @order.update(status: 'finished')
          OrderChannel.broadcast_to("orders", { action: "updated", order: @order })
          render json: @order
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @order.destroy!
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
