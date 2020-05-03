class CreateTravellers < ActiveRecord::Migration[5.2]
  def change
    create_table :travellers do |t|
        t.string :first_name
        t.string :last_name
        t.string :email_address
        t.string :address
        t.string :address
        t.string :zip_code
        t.date :birth_date
        t.integer :phone_number
        t.boolean :insurance_status
      t.timestamps
    end
  end
end
