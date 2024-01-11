class Invoice < ApplicationRecord
  before_create :calculate_total_invoice
  belongs_to :order
  belongs_to :client
  
  has_many :items, through: :order 
  has_many :products, through: :items #me lo pienso

 
  enum payment_method: {efectivo: 1, transferencia: 2, pago_tarjeta: 3, pasarela_pago: 4}

  def calculate_total_invoice
     order_total = order.total
     self.total = order_total * (1 + 0.12)
  end
  
end
