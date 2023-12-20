class AddColumnsinEmployees < ActiveRecord::Migration[7.1]
  def change
    add_column :employees, :jti, :string, null: false
    add_index :employees, :jti, unique: true
  end
end
