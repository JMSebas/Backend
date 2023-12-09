class CreateTables < ActiveRecord::Migration[7.1]
  def change
    create_table :tables do |t|
      t.string :status
      t.integer :capacity

      t.timestamps
    end
  end
end
