module Api
  module V1
    class ItemsController < ApplicationController
      before_action :set_item, only: %i[ show update destroy ]

      
      def index
        @items = Item.all

        render json: @items
      end

      
      def show
        render json: @item
      end

      
      def create
        @item = Item.new(item_params)

        if @item.save
          render json: @item, status: :created #, location: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def update_status
        @item = Item.find(params[:id])
        if @item.update(status: 'finished')
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      def update
        if @item.update(item_params)
          render json: @item
        else
          render json: @item.errors, status: :unprocessable_entity
        end
      end

      
      def destroy
        @item.destroy!
      end

      private
        
        def set_item
          @item = Item.find(params[:id])
        end

        
        def item_params
          params.require(:item).permit(:quantity, :unit_price,  :product_id, :order_id)
        end
    end
  end
end
