class CreateDietTravellers < ActiveRecord::Migration[5.2]
  def change
    create_table :diet_travellers do |t|
      t.references :traveller
      t.references :food_diet
      t.timestamps
    end
  end
end
