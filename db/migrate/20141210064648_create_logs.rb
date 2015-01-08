class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.date :start
      t.date :finish
      t.decimal :calling_hours
      t.integer :calls_made
      t.integer :appointment_asks
      t.integer :response_to_appointment_ask
      t.integer :appointment_set
      t.integer :contact_asks
      t.integer :decisions
      t.integer :yes_to_monthly
      t.decimal :total_monthly_pledged
      t.decimal :total_special_pledged
      t.decimal :total_monthly_confirmed
      t.decimal :total_special_confirmed
      t.integer :used_contacts
      t.integer :received_contacts

      t.timestamps
    end
  end
end
