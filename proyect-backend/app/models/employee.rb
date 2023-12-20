class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

    has_many :orders

    enum role:  { waiter: 1, chef: 2, admin: 3 }

    def jwt_payload
         super #llaves = hash  Key_value whais
    end
end
