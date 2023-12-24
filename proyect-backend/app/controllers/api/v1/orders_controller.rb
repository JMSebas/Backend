module Api
  module V1
    class OrdersController < ApplicationController
      before_action :set_order, only: %i[ show update destroy ]

      
      def index
        @orders = Order.all

        render json: @orders
      end

      
      def show
        render json: @order
      end

      
      def create
        @order = Order.new(order_params)
        
        if @order.save
          render json: @order, status: :created, location: @order
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

      def destroy
        @order.destroy!
      end

      private
      def set_order
         @order = Order.find(params[:id])
      end

      def order_params
        params.require(:order).permit( :date, :status, :total, :table_id, :employee_id, items: [:quantity, :unit_price,  :product_id])
       end
    end
  end
end
