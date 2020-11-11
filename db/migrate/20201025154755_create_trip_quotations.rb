class CreateTripQuotations < ActiveRecord::Migration[5.2]
  def change
    create_table :trip_quotations do |t|
      t.text :message

      t.timestamps
    end
  end
end
