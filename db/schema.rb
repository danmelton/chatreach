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

ActiveRecord::Schema.define(:version => 20110807221158) do

  create_table "account_articles", :force => true do |t|
    t.integer  "account_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_brands", :force => true do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_organizations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "oprofile_id"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "account_texts", :force => true do |t|
    t.integer  "account_id"
    t.integer  "text_content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "accounts", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "user_id"
    t.string   "code"
  end

  add_index "accounts", ["id"], :name => "index_accounts_on_id"

  create_table "article_brands", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "article_categories", :force => true do |t|
    t.integer  "article_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", :force => true do |t|
    t.string   "name"
    t.text     "content"
    t.boolean  "published"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["id"], :name => "index_articles_on_id"
  add_index "articles", ["name"], :name => "index_articles_on_title"

  create_table "blogs", :force => true do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.string   "title"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_at"
  end

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

  create_table "brand_settings", :force => true do |t|
    t.integer  "account_id"
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

  create_table "brand_videos", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "video_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carriers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "carrierid"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "account_id", :default => 1
  end

  create_table "category_texts", :force => true do |t|
    t.integer  "category_id"
    t.integer  "text_content_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chatter_profiles", :force => true do |t|
    t.date     "birthday"
    t.integer  "age"
    t.string   "gender"
    t.string   "phone"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "country"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "chatter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chatters", :force => true do |t|
    t.integer  "demographic_id"
    t.integer  "profile_id"
    t.integer  "social_id"
    t.boolean  "initiated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conversations", :force => true do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.integer  "user_id"
    t.text     "transcript"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "credits", :force => true do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.string   "cents"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "faqs", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "user_id"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feed_entries", :force => true do |t|
    t.string   "name"
    t.text     "summary"
    t.string   "url"
    t.date     "published_at"
    t.string   "guid"
    t.string   "feed_source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "feed_entries", ["id"], :name => "index_feed_entries_on_id"

  create_table "feed_sources", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.string   "source_url"
    t.integer  "brand_id"
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "author"
  end

  create_table "helps", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "user_id"
    t.text     "content"
    t.string   "title"
    t.boolean  "feature"
    t.boolean  "published"
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

  create_table "oprofiles", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "phone"
    t.string   "mobile"
    t.string   "pager"
    t.text     "about",        :limit => 255
    t.string   "sms_about"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "geom"
    t.integer  "custodial_id"
    t.string   "website"
    t.string   "email"
  end

  add_index "oprofiles", ["id"], :name => "index_oprofiles_on_id"

  create_table "poweron_chatters", :force => true do |t|
    t.string   "screen_name"
    t.integer  "profile_id"
    t.integer  "account_id"
    t.integer  "age"
    t.integer  "gender"
    t.integer  "hiv"
    t.integer  "race"
    t.integer  "sexual_orientation"
    t.integer  "drug_use"
    t.integer  "alcohol_use"
    t.integer  "smoking"
    t.integer  "out_level"
    t.integer  "risk_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "poweron_keywords", :force => true do |t|
    t.integer  "poweron_chatter_id"
    t.integer  "keyword_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_types", :force => true do |t|
    t.string   "name"
    t.string   "thumbnail"
    t.string   "url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type"
    t.string   "filename"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "account_id"
    t.integer  "brand_id"
    t.string   "username"
    t.string   "password"
    t.integer  "profile_type_id"
    t.string   "profile_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "referrals", :force => true do |t|
    t.integer  "user_id"
    t.string   "code"
    t.integer  "brand_id"
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rcontent_id"
    t.string   "rcontent_type"
    t.string   "name"
  end

  create_table "session_powerons", :force => true do |t|
    t.integer  "account_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "referral_id"
  end

  add_index "session_powerons", ["id"], :name => "index_session_powerons_on_id"
  add_index "session_powerons", ["referral_id"], :name => "index_session_powerons_on_referral_id"

  create_table "session_videos", :force => true do |t|
    t.integer  "account_id"
    t.integer  "video_id"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "referral_id"
    t.integer  "session_poweron_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "session_videos", ["id"], :name => "index_session_videos_on_id"

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
    t.string   "response"
    t.integer  "user_id"
    t.boolean  "published"
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
    t.integer  "account_id"
    t.integer  "brand_id"
    t.string   "phone"
    t.integer  "carrier_id"
    t.integer  "chatter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session"
  end

  add_index "text_sessions", ["id"], :name => "index_text_sessions_on_id"

  create_table "uprofiles", :force => true do |t|
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "phone"
    t.string   "mobile"
    t.string   "pager"
    t.text     "about",      :limit => 255
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "uprofiles", ["id"], :name => "index_uprofiles_on_id"

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

  create_table "videos", :force => true do |t|
    t.string   "video_id"
    t.string   "name"
    t.string   "thumbnail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "videos", ["id"], :name => "index_videos_on_id"
  add_index "videos", ["name"], :name => "index_videos_on_name"

end
