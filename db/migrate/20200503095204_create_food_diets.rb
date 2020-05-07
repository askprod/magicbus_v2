class CreateFoodDiets < ActiveRecord::Migration[5.2]
  def change
    create_table :food_diets do |t|
      t.boolean :approved_status, default: false
      t.string :name
      t.timestamps
    end
  end
end
