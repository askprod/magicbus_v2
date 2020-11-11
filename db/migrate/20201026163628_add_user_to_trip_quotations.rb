class AddUserToTripQuotations < ActiveRecord::Migration[5.2]
  def change
    add_reference :trip_quotations, :user, foreign_key: true
  end
end
