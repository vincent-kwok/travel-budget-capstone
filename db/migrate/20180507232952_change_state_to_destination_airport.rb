class ChangeStateToDestinationAirport < ActiveRecord::Migration[5.1]
  def change
    rename_column :trips, :state, :destination_airport
    rename_column :trips, :city, :home_airport
    add_column :trips, :destination, :string
  end
end
