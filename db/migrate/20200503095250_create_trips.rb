class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
        t.string :name
        t.text :description
        t.jsonb :arrival_location
        t.jsonb :departure_location
        t.date :departure_date
        t.date :arrival_date
        t.integer :price
        t.integer :week
      t.timestamps
    end
  end
end
