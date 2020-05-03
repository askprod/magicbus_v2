class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
        t.integer :traveller_quantity, default: 1
      t.timestamps
    end
  end
end
