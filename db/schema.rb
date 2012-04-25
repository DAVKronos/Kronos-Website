# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20120425094348) do

  create_table "agendaitems", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "date"
    t.string   "location"
    t.boolean  "subscribe"
    t.datetime "subscriptiondeadline"
    t.integer  "commission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "category"
    t.boolean  "intern"
    t.integer  "agendaitemtype_id"
  end

  create_table "agendaitemtype_eventtypes", :force => true do |t|
    t.integer  "agendaitemtype_id"
    t.integer  "eventtype_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "agendaitemtypes", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "is_match"
  end

  create_table "chatmessages", :force => true do |t|
    t.string   "by"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.integer  "user_id"
  end

  create_table "commission_memberships", :force => true do |t|
    t.string   "function"
    t.boolean  "installed",     :default => false
    t.integer  "user_id",                          :null => false
    t.integer  "commission_id",                    :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.time     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "eventtype_id"
    t.integer  "agendaitem_id"
    t.float    "distance"
  end

  create_table "eventtypes", :force => true do |t|
    t.string   "name"
    t.string   "formula"
    t.string   "shortname"
    t.string   "measuringunit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "calculated_unit"
  end

  create_table "newsitems", :force => true do |t|
    t.string   "title"
    t.text     "news"
    t.boolean  "agreed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "agreed_by"
  end

  create_table "pages", :force => true do |t|
    t.text     "information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "pagetag"
    t.integer  "user_id"
  end

  create_table "photoalbums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "agendaitem_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "photoalbum_id"
    t.string   "youtube_id"
    t.boolean  "processing"
  end

  create_table "reactions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "agendaitem_id"
    t.integer  "result_id"
    t.integer  "photo_id"
    t.integer  "newsitem_id"
    t.text     "reactiontext"
  end

  create_table "results", :force => true do |t|
    t.string   "username"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "user_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.text     "comment"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "agendaitem_id"
  end

  create_table "tags", :force => true do |t|
    t.integer  "photo_id"
    t.integer  "user_id"
    t.integer  "xpos"
    t.integer  "ypos"
    t.integer  "width"
    t.integer  "heigth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "initials"
    t.string   "email",                  :default => "",    :null => false
    t.date     "birthdate"
    t.string   "address"
    t.string   "postalcode"
    t.string   "city"
    t.string   "sex"
    t.string   "licensenumber"
    t.boolean  "papieren_kronometer",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "phonenumber"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
