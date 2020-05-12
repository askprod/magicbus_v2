class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.jsonb :location, default: {lat: 48.839155, lng: 2.389909}
      t.text :description
      t.boolean :approved_status, default: false
      t.boolean :secret_status
      t.timestamps
    end
  end
end
