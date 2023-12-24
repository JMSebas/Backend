# frozen_string_literal: true

class Employees::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, if: :devise_controller?
  respond_to :json
 

  private 
  def  configure_sign_up_params
    devise_parameter.permit(:sign_up, keys: [:first_name, :last_name, :username, :email, :password , :role])
  end

  def respond_with(data, _options={})
  if data.persisted?
    render json: {
      status: {code: 200, message: 'Registro exitoso', datas: data}
    }
  else 
    render json: {
      status: { message: 'Registro no exitoso', errors: resource.errors.full_messages }
    }
  end  
  end
end
