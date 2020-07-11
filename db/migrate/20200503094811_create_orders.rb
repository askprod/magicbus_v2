class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :user
      t.string :name
      t.integer :total_price
      t.boolean :payment_status, default: false
      t.boolean :rgpd_validated, default: true
      t.jsonb :details
      t.timestamps
    end
  end
end
