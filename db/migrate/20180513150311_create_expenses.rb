class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.string :category
      t.integer :amount
      t.string :description
      t.integer :trip_id

      t.timestamps
    end
  end
end
