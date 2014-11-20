class CreateUsers < ActiveRecord::Migration
  def change
    return unless Rails.env.test? || Rails.env == 'staging'
    create_table "users", force: true do |t|
      t.string   "username"
      t.string   "admin"
      t.datetime "created_at",                         null: false
      t.datetime "updated_at",                         null: false
      t.string   "email",              default: "",    null: false
      t.string   "first_name"
      t.string   "last_name"
      t.integer  "bootcamp_coach_id"
      t.integer  "currency_id"
      t.decimal  "mpd_goal"
      t.integer  "XP",                 default: 0
      t.integer  "sign_in_count",      default: 0
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string   "current_sign_in_ip"
      t.string   "last_sign_in_ip"
      t.string   "encrypted_password"
      t.integer  "gma_id"
      t.string   "gma_update"
      t.boolean  "dmpd",               default: false
      t.boolean  "stats",              default: false
      t.boolean  "pac",                default: false
      t.string   "primary_phone"
      t.string   "home_phone"
      t.string   "office_phone"
      t.string   "address"
      t.integer  "contacts_count",     default: 0
    end
  end
end
