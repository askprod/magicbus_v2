class AddMinimumTripsValidityToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_column :coupons, :minimum_trips_validity, :integer
  end
end
