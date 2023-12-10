class Invoice < ApplicationRecord
  belongs_to :order
  belongs_to :client
  
  has_many :items, through: :order 

  enum payment_method: {efectivo: 1, transferencia: 2, pago_tarjeta: 3, pasarela_pago: 4}
end
