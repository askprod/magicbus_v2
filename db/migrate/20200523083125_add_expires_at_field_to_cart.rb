class AddExpiresAtFieldToCart < ActiveRecord::Migration[5.2]
  def change
    add_column :carts, :expires_at, :datetime, default: nil
  end
end
