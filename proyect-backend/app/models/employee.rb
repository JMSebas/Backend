class Employee < ApplicationRecord

  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

    has_many :orders

    enum role:  { waiter: 1, chef: 2, admin: 3, cashier: 4 }

    def jwt_payload
         super 
    end
end
