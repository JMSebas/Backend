class Order < ApplicationRecord
  before_save :calculate_total
  after_create_commit { broadcast_message }
  after_update_commit { update_message }

  has_many :items, dependent: :destroy
  has_many :products, through: :items
  has_one :invoices
  accepts_nested_attributes_for :items, allow_destroy: true


  enum status: { in_process: 1, ready: 2, finish: 3, billed: 4 } 

  belongs_to :table
  belongs_to :employee
  
  

  def update_message
    ActionCable.server.broadcast("OrderChannel", { action: "updated", order: self })

  end
  
  def broadcast_message
    ActionCable.server.broadcast("OrderChannel", { action: "created", order: self })
  end

  def calculate_total
    self.total = items.present? ? items.sum(&:subtotal) : 0
  end

  
end
