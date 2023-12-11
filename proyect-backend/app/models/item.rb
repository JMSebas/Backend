class Item < ApplicationRecord
  belongs_to :product
  belongs_to :order

  before_save :calculate_subtotal
  
  def calculate_subtotal
    self.subtotal = unit_price * quantity
  end
end
