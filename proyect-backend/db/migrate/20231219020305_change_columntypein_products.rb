class ChangeColumntypeinProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :tables, :status, 'integer USING status::integer'

    change_column :products, :category, 'integer USING CAST(category AS integer)'


  end
end
