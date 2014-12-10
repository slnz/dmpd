class AddReasonToContactCalls < ActiveRecord::Migration
  def change
    add_column :contact_calls, :reason, :integer
  end
end
