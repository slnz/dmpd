class AddResultToContactAppointments < ActiveRecord::Migration
  def change
    add_column :contact_appointments, :result, :integer, default: 0
  end
end
