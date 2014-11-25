class AddDonationToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :amount, :decimal
    add_column :contacts, :frequency, :decimal
    add_column :contacts, :gift_date, :date
    add_column :contacts, :thanks, :boolean, default: false
  end
end
