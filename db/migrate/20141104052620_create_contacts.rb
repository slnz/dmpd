class CreateContacts < ActiveRecord::Migration
  def change
    return unless Rails.env.test? || Rails.env == 'staging'
    create_table "contacts", force: true do |t|
      t.string   "first_name"
      t.string   "last_name"
      t.integer  "user_id"
      t.datetime "created_at",                null: false
      t.datetime "updated_at",                null: false
      t.integer  "priority_code"
      t.boolean  "new_church"
      t.string   "email"
      t.string   "address"
      t.string   "primary_phone"
      t.string   "home_phone"
      t.string   "office_phone"
      t.integer  "referer_id"
      t.string   "how_knows"
      t.string   "occupation"
      t.string   "church"
      t.string   "children"
      t.date     "anniversary"
      t.text     "search"
      t.integer  "status",        default: 0
      t.integer  "category",      default: 0
    end
  end
end
