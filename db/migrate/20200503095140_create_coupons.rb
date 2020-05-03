class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
        t.string :code
        t.integer :remaining_uses
        t.integer :reduction_percentage
        t.date :expiry_date
      t.timestamps
    end
  end
end
