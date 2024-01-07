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
                id: item.id,
                quantity: item.quantity,
                 status: item.status, #//pending, finished Descomentar y eliminar esto si se quiere traer en orders el status de los items
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
              id: item.id,
              quantity: item.quantity,
              status: item.status, # //pending, finished Descomentar y eliminar esto si se quiere traer en orders el status de los items
              product: item.product.as_json(only: %i[id name description]) 
            }
          end
        }
      end

     

      
      def create
        @order = Order.new(order_params.merge(status: "in_process"))
        @order.items.each do |item|
          item.status = 'pending'
        end

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

     
      def add_item
        @order = Order.find(params[:id])
    
        items_params = params.require(:items_attributes).map do |item|
        item.permit(:quantity, :product_id).merge(status: 'pending')
        end
    
        @order.items.create(items_params)
        @order.calculate_total
    
        if @order.save
          render json: @order, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      end


      def remove_item
        @order = Order.find(params[:id])
        @item = @order.items.find(params[:item_id])
        
        if @item.destroy
          @order.calculate_total
          @order.save
      
          render json: @order
        else
          render json: { error: 'No se pudo eliminar el ítem de la orden' }, status: :unprocessable_entity
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
