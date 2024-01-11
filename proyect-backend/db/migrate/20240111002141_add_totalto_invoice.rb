class AddTotaltoInvoice < ActiveRecord::Migration[7.1]
  def change
    add_column :invoices, :total, :decimal
  end
end
