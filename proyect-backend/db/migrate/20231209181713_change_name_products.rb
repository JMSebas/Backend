class ChangeNameProducts < ActiveRecord::Migration[7.1]
  def change
    rename_column :products, :cost, :price
    add_column :products, :description, :string
  end
end
