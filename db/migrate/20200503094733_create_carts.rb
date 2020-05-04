class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.belongs_to :user
      t.integer :traveller_quantity, default: 1
      t.string :name
      t.timestamps
    end
  end
end
