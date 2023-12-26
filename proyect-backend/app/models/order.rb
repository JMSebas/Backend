class Order < ApplicationRecord
  before_save :calculate_total

  has_many :items
  has_many :products, through: :items
  has_one :invoices
  accepts_nested_attributes_for :items, allow_destroy: true


  enum status: { in_process: 1, ready: 2, finish: 3 } 

  
  def calculate_total
    self.total = items.present? ? items.sum(&:subtotal) : 0
  end

  belongs_to :table
  belongs_to :employee
end
