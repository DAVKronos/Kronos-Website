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

ActiveRecord::Schema.define(:version => 20111203184352) do

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
  end

  create_table "eventtypes", :force => true do |t|
    t.string   "name"
    t.string   "calculation"
    t.string   "shortname"
    t.string   "measuringunit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "calculated_unit"
  end

  create_table "results", :force => true do |t|
    t.string   "username"
    t.string   "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
    t.integer  "user_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.integer  "authorizable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", :force => true do |t|
    t.text     "comment"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "agendaitem_id"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "initials"
    t.string   "email"
    t.date     "birthdate"
    t.string   "address"
    t.string   "postalcode"
    t.string   "city"
    t.string   "sex"
    t.string   "licensenumber"
    t.string   "login",                                  :null => false
    t.string   "persistence_token",                      :null => false
    t.string   "crypted_password",                       :null => false
    t.string   "password_salt",                          :null => false
    t.string   "single_access_token",                    :null => false
    t.string   "perishable_token",                       :null => false
    t.integer  "login_count",         :default => 0,     :null => false
    t.integer  "failed_login_count",  :default => 0,     :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "papieren_kronometer", :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
