class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.belongs_to :user
      t.string :name
      t.integer :number_of_travellers, default: 1
      t.timestamps
    end
  end
end
