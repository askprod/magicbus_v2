class CreateFoodRestrictions < ActiveRecord::Migration[5.2]
  def change
    create_table :food_restrictions do |t|

      t.timestamps
    end
  end
end
