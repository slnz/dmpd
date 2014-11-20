class AddTransitionToContactCallEvents < ActiveRecord::Migration
  def change
    add_column :contact_call_events, :transition, :integer
  end
end
