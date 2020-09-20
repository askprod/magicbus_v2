class CreateWarningMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :warning_messages do |t|
      t.string :description
      t.timestamps
    end
  end
end
