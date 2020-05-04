class CreateCartTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_trips do |t|
      t.integer :cart_id
      t.integer :trip_id
      t.timestamps
    end
  end
end
