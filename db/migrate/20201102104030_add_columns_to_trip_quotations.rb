class AddColumnsToTripQuotations < ActiveRecord::Migration[5.2]
  def change
      add_column :trip_quotations, :first_name, :string
      add_column :trip_quotations, :last_name, :string
      add_column :trip_quotations, :email, :string
      add_column :trip_quotations, :phone_number, :string
      add_column :trip_quotations, :arrival_date, :date
      add_column :trip_quotations, :departure_date, :date
  end
end
