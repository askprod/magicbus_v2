class AddSeatsAvailableToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :seats_available, :integer, default: 8
  end
end
