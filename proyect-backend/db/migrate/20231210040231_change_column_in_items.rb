class ChangeColumnInItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :orders, :order_number
  end
end
