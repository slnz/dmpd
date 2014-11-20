class AddMessageToContactCallEvents < ActiveRecord::Migration
  def change
    add_column :contact_call_events, :message, :string
  end
end
