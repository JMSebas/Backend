class ChangeTypeidUserToString < ActiveRecord::Migration[7.1]
  def up
    change_column :clients, :id, :string
  end

  def down
    change_column :clients, :id, :bigint
  end
end
