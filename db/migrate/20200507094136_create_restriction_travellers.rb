class CreateRestrictionTravellers < ActiveRecord::Migration[5.2]
  def change
    create_table :restriction_travellers do |t|
      t.references :traveller
      t.references :food_restriction
      t.timestamps
    end
  end
end
