class RemoveUnitPriceFromItems < ActiveRecord::Migration[7.1]
  def change
    
      remove_column :items, :unit_price
    
  end
end
