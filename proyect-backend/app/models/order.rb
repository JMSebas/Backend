class Order < ApplicationRecord
  before_save :calculate_total

  belongs_to :table
  belongs_to :employee
  has_many :products, through: :items
  has_many :items
  has_one :invoices


  enum status: { in_process: 1, ready: 2, finish: 3 } 

  
  def calculate_total
    self.total = items.sum(&:subtotal)
  end
end
