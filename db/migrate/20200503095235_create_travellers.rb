class CreateTravellers < ActiveRecord::Migration[5.2]
  def change
    create_table :travellers do |t|
        t.string :gender
        t.string :first_name
        t.string :last_name
        t.string :email_address
        t.string :nationality
        t.string :address
        t.string :zip_code
        t.date :birth_date
        t.string :phone_number
        t.string :medical_condition
        t.string :additional_comment
        t.boolean :insurance_status
        t.references :cart, index: true
        t.references :order, index: true
      t.timestamps
    end
  end
end
