class AddPaidAtFieldToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :paid_at, :datetime, default: nil
  end
end
