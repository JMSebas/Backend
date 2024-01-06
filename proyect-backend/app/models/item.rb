class Item < ApplicationRecord
  validates :subtotal, presence: true

  belongs_to :product
  belongs_to :order

  enum status: { pending: 1, finished: 2 }
  
  before_validation :calculate_subtotal
  
  def calculate_subtotal
    self.subtotal = product.price * quantity
  end
end
