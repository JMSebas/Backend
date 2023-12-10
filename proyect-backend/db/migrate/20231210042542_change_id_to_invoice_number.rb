class ChangeIdToInvoiceNumber < ActiveRecord::Migration[7.1]
  def change
    change_column :invoices, :id, :string
    rename_column :invoices, :id, :invoice_number
  end
end
