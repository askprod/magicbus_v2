class CreatePrivateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :private_trips do |t|
      t.integer :number_of_days
      t.timestamps
    end
  end
end
