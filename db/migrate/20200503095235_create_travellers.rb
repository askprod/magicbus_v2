class CreateTravellers < ActiveRecord::Migration[5.2]
  def change
    create_table :travellers do |t|

      t.timestamps
    end
  end
end
