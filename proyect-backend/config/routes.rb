Rails.application.routes.draw do
 
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  devise_for :employees, controllers: {
    registrations: 'employees/registrations',
    sessions: 'employees/sessions'
  }

  # devise_scope :employee do
  #   delete 'employees/sign_out', to: 'employees/sessions#destroy'
  # end
  mount ActionCable.server => '/cable'
  namespace :api do
    namespace :v1 do
      resources :invoices
      resources :items
      resources :employees
      resources :orders
      resources :tables

      resources :tables do
        member do
          put 'MesaOcupada', to: 'tables#occupy_table'
        end
      end

      resources :items do 
        member do
          put 'ActualizarEstado', to: 'items#update_status'
        end
      end  


      resources :orders do
        member do 
          put 'OrdenLista', to: 'orders#set_ready'
          put 'OrdenFinalizada', to: 'orders#set_finished'
        end
      end
      resources :products
      resources :clients
    end
  end 
  # Defines the root path route ("/")
  # root "posts#index"
end
