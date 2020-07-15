class CreateDiscovers < ActiveRecord::Migration[5.2]
  def change
    create_table :discovers do |t|
      t.string :description
      t.timestamps
    end
  end
end
