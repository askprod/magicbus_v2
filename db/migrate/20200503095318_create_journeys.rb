class CreateJourneys < ActiveRecord::Migration[5.2]
  def change
    create_table :journeys do |t|
      t.boolean :status
      t.timestamps
    end
  end
end
