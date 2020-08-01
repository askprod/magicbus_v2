class AddCrossedOutPriceToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :crossed_out_price, :string
  end
end
