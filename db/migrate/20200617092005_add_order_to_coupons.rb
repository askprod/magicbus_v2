class AddOrderToCoupons < ActiveRecord::Migration[5.2]
  def change
    add_reference :coupons, :order, foreign_key: true
  end
end
