class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
        t.string :name
        t.decimal :longitude
        t.decimal :latitude
        t.text :description
        t.boolean :approved_status
        t.boolean :secret_status
      t.timestamps
    end
  end
end
