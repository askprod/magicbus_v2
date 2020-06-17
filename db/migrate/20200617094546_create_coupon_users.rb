class CreateCouponUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_users do |t|
      t.references :user
      t.references :coupon
      t.timestamps
    end
  end
end
