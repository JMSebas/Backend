class RemoveColumnToInvoicesTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :invoices, :invoice_number
  end
end
