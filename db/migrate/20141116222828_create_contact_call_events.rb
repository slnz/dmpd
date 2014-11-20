class CreateContactCallEvents < ActiveRecord::Migration
  def change
    create_table :contact_call_events do |t|
      t.integer :state, default: 0
      t.integer :step, default: 0
      t.integer :call_id
      t.timestamps
    end
  end
end
