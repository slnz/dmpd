class CreateCallSessions < ActiveRecord::Migration
  def change
    create_table :call_sessions do |t|
      t.integer :user_id
      t.integer :partner_id
      t.timestamp :end_time

      t.timestamps
    end
  end
end
