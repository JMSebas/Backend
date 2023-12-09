class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.bigint :order_number
      t.date :date
      t.integer :status
      t.decimal :total
      t.references :table, null: false, foreign_key: true
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
