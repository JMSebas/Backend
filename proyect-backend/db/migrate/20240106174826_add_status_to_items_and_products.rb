class AddStatusToItemsAndProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :status, :integer
    add_column :products, :status, :integer
  end
end
