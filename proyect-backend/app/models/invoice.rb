class Invoice < ApplicationRecord
  belongs_to :order
  belongs_to :client
  
  has_many :items, through: :order 
end
