class CreateContactAppointments < ActiveRecord::Migration
  def change
    create_table :contact_appointments do |t|
      t.timestamp :time
      t.boolean :support
      t.decimal :amount
      t.integer :contact_id
      t.boolean :reccuring
      t.decimal :frequency
      t.text :notes
      t.string :address
      t.date :gift_date
      t.date :gift_confirmed_date

      t.timestamps
    end
  end
end
