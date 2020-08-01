class AddCityToTravellers < ActiveRecord::Migration[5.2]
  def change
    add_column :travellers, :city, :string
  end
end
