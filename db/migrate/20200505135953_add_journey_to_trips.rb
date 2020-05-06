class AddJourneyToTrips < ActiveRecord::Migration[5.2]
  def change
    add_reference :trips, :journey, foreign_key: true
  end
end
