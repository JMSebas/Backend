class Order < ApplicationRecord
  belongs_to :table
  belongs_to :employee
  has_many :items
  has_one :invoices

  enum status: { in_process: 1, ready: 2, finish: 3 } 
end
