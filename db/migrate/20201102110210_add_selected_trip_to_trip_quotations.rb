class AddSelectedTripToTripQuotations < ActiveRecord::Migration[5.2]
  def change
    add_column :trip_quotations, :selected_trip, :integer
  end
end
