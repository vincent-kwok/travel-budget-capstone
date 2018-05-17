class CreateTrips < ActiveRecord::Migration[5.1]
  def change
    create_table :trips do |t|
      t.integer :user_id
      t.string :city
      t.string :state
      t.date :start_date
      t.date :end_date
      t.integer :budget_flight
      t.integer :budget_accom
      t.integer :budget_food
      t.integer :budget_fun

      t.timestamps
    end
  end
end
