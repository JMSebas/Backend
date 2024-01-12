module Api
  module V1
    class EmployeesController < ApplicationController
      # before_action :authenticate_employee!

      before_action :set_employee, only: %i[ show update destroy ]

      
      def index
        @employees = Employee.all

        render json: @employees
      end

      
      def show
        render json: @employee
      end

      
      def create
        @employee = Employee.new(employee_params)

        if @employee.save
          render json: @employee, status: :created #, location: @employee
        else
          render json: @employee.errors, status: :unprocessable_entity
        end
      end

      
      def update
        if @employee.update(employee_params)
          render json: @employee
        else
          render json: @employee.errors, status: :unprocessable_entity
        end
      end

      
      def destroy
        @employee.destroy!
          
      end

      private
        
      def set_employee
        @employee = Employee.find(params[:id])
      end

        
      def employee_params
        params.require(:employee).permit(:first_name, :last_name, :username, :email, :password, :role)
      end
    end
  end 
end