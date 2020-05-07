class CreateTripTravellers < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_travellers do |t|
      t.integer :trip_id
      t.integer :traveller_id
      t.timestamps
    end
  end
end
