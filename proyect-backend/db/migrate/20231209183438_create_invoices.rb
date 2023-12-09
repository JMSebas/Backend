class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.bigint :invoice_number
      t.integer :payment_method
      t.references :order, null: false, foreign_key: true
      t.string :client_id, null: false

      t.timestamps
    end
    add_index :invoices, :client_id
    add_foreign_key :invoices, :clients, column: :client_id, primary_key: :id
  end
end
