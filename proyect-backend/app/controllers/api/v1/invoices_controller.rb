module Api
  module V1
    class InvoicesController < ApplicationController
      before_action :set_invoice, only: %i[ show update destroy ]

      
      def index
        @invoices = Invoice.all

        render json: @invoices
      end

      
      def show
        render json: {
          invoice: @invoice.as_json,
          order: {
            subtotal: @invoice.order.total,
            items: @invoice.order.items.map do |item|
              {
                quantity: item.quantity,
                subtotal_item: item.subtotal,
                product: {
                  name: item.product.name,
                  price: item.product.price
                }
              }
            end
          }
        }
      end
      

      
      def create
        @invoice = Invoice.new(invoice_params)

        if @invoice.save
          render json: @invoice, status: :created #, location: @invoice
        else
          render json: @invoice.errors, status: :unprocessable_entity
        end
      end

      
      def update
        if @invoice.update(invoice_params)
          render json: @invoice
        else
          render json: @invoice.errors, status: :unprocessable_entity
        end
      end

      
      def destroy
        @invoice.destroy!
      end

      private
        
        def set_invoice
          @invoice = Invoice.find(params[:id])
        end

        def invoice_params
          params.require(:invoice).permit( :payment_method, :order_id, :client_id)
        end
    end
  end 
end