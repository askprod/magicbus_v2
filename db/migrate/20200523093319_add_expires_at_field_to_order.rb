class AddExpiresAtFieldToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :expires_at, :datetime, default: nil
  end
end
