class ChangeTypeOfIdInvoices < ActiveRecord::Migration[7.1]
  def change
    change_column :invoices, :invoice_number, :bigint, using: 'invoice_number::bigint'

  end
end
