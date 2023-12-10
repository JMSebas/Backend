class ChangeIdOrdersToOrderNumber < ActiveRecord::Migration[7.1]
  def change
    rename_column :orders, :id, :order_number 
  end
end
