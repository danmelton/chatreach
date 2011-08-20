# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110817035228) do

  create_table "brand_admins", :force => true do |t|
    t.integer  "user_id"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_categories", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_organizations", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "organization_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_settings", :force => true do |t|
    t.integer  "brand_id"
    t.string   "name"
    t.text     "setting",    :limit => 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brand_tags", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chatters", :force => true do |t|
    t.integer  "age"
    t.string   "gender"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keywords", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "weight"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.integer  "phone"
    t.string   "sms_about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "website"
    t.string   "email"
    t.float    "latitude"
    t.float    "longitude"
  end

  add_index "organizations", ["id"], :name => "index_organizations_on_id"

  create_table "tag_typos", :force => true do |t|
    t.integer  "tag_id"
    t.string   "typo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "taggable_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "text_contents", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "tag_id"
    t.integer  "category_id"
    t.string   "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "text_contents", ["id"], :name => "index_text_contents_on_id"

  create_table "text_histories", :force => true do |t|
    t.integer  "text_session_id"
    t.integer  "tag_id"
    t.string   "text"
    t.string   "response"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "text_type"
  end

  add_index "text_histories", ["id"], :name => "index_text_histories_on_id"

  create_table "text_sessions", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "chatter_id"
    t.string   "session"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "text_sessions", ["id"], :name => "index_text_sessions_on_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                 :default => "",    :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                                 :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
