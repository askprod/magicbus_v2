class CreateThemes < ActiveRecord::Migration[5.2]
  def change
    create_table :themes do |t|
        t.string :name_fr
        t.string :name_en
      t.timestamps
    end
  end
end
