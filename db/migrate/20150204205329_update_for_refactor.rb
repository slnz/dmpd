class UpdateForRefactor < ActiveRecord::Migration
  def change
    drop_table :dmpd_contact_card_boxes if table_exists? :dmpd_contact_card_boxes
    drop_table :dmpd_weeks if table_exists? :dmpd_weeks
    drop_table :dmpd_appointments if table_exists? :dmpd_appointments
    drop_table :dmpd_weekly_calls if table_exists? :dmpd_weekly_calls
    drop_table :contact_card_boxes if table_exists? :contact_card_boxes
    drop_table :weeks if table_exists? :weeks
    drop_table :appointments if table_exists? :appointments
    drop_table :weekly_calls if table_exists? :weekly_calls
    rename_table :logs, :dmpd_logs
    rename_table :call_sessions, :dmpd_call_sessions
    rename_table :contact_appointments, :dmpd_contact_appointments
    rename_table :contact_calls, :dmpd_contact_calls
    rename_table :contact_return_calls, :dmpd_contact_return_calls
    rename_table :contact_call_events, :dmpd_contact_call_events
  end
end
