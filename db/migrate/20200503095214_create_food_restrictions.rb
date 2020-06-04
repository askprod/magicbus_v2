class CreateFoodRestrictions < ActiveRecord::Migration[5.2]
  def change
    create_table :food_restrictions do |t|
      t.boolean :approved_status, default: false
      t.string :name_fr
      t.string :name_en
      t.timestamps
    end
  end
end
