class AddSeasonToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :season, foreign_key: true 
  end
end
