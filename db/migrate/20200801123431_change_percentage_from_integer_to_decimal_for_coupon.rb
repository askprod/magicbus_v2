class ChangePercentageFromIntegerToDecimalForCoupon < ActiveRecord::Migration[5.2]
  def change
    change_column :coupons, :reduction_percentage, :decimal, precision: 10, scale: 2
  end
end
