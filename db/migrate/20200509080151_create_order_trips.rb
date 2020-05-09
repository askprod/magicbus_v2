class CreateOrderTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :order_trips do |t|
      t.integer :order_id
      t.integer :trip_id
      t.timestamps
    end
  end
end
