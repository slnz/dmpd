class CreateContactReturnCalls < ActiveRecord::Migration
  def change
    create_table :contact_return_calls do |t|
      t.integer :contact_id
      t.timestamp :time
      t.text :notes
      t.integer :state

      t.timestamps
    end
  end
end
