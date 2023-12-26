module Api
  module V1
    class TablesController < ApplicationController
      before_action :set_table, only: %i[ show update destroy ]

      
      def index
        @tables = Table.all

        render json: @tables
      end

      
      def show
        render json: @table
      end

      def occupy_table
        # Encuentra la mesa por su ID (puedes ajustar esto según tus necesidades)
        @table = Table.find(params[:id])
        if @table.status == "free"
          @table.update(status: "occupied")
        else
          @table.update(status: "free")  
        end 
        # Guarda los cambios en la base de datos
        if @table.save
          render json: { message: "La mesa ha sido marcada como ocupada." }
        else
          render json: { error: "Hubo un problema al cambiar el estado de la mesa." }, status: :unprocessable_entity
        end
      end

      
      def create
        @table = Table.new(table_params)

        if @table.save
          render json: @table, status: :created, location: @table
        else
          render json: @table.errors, status: :unprocessable_entity
        end
      end

      
      def update
        if @table.update(table_params)
          render json: @table
        else
          render json: @table.errors, status: :unprocessable_entity
        end
      end

      
      def destroy
        @table.destroy!
      end

     private
      def set_table
        @table = Table.find(params[:id])
      end

        
      def table_params
        params.require(:table).permit(:status, :capacity)
      end
    end
  end
end
