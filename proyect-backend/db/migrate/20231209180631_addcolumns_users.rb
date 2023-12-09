class AddcolumnsUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :clients, :name, :first_name
    rename_column :clients, :lastname, :last_name
    add_column :clients, :adress, :string
    add_column :clients, :email, :string
    add_column :clients, :date, :date
    add_column :clients, :edad, :integer
  end
end
