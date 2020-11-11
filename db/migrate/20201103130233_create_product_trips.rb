class CreateProductTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :product_trips do |t|
      t.integer :number_of_days
      t.integer :price

      t.timestamps
    end
  end
end
