# frozen_string_literal: true

class Employees::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _options = {})
    render json: {
      status: { code: 200, message: 'User signed in successfully', data: { email: current_employee.email, first_name: 
        current_employee.first_name, last_name: current_employee.last_name, role: current_employee.role } 
      }
    }
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.credentials.fetch(:secret_key_base)).first
    current_employee = User.find(jwt_payload['sub'])
    if current_employee
      render json: {
        status: { code: 200, message: 'User signed out successfully' }
      }
    else
      render json: {
        status: { code: 401, message: 'User has no active session' }
      }
    end
  end
end
