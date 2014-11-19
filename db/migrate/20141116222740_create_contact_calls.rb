class CreateContactCalls < ActiveRecord::Migration
  def change
    create_table :contact_calls do |t|
      t.integer :state, default: 0
      t.integer :step, default: 0
      t.integer :contact_id
      t.timestamp :end_time
      t.timestamps
    end
  end
end
