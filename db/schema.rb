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

ActiveRecord::Schema.define(:version => 20120318201037) do

  create_table "agendaitems", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "date"
    t.string   "location"
    t.boolean  "subscribe"
    t.datetime "subscriptiondeadline"
    t.integer  "commission_id"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "category"
    t.boolean  "intern"
  end

  create_table "chatmessages", :force => true do |t|
    t.string   "by"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
    t.integer  "user_id"
  end

  create_table "commission_memberships", :force => true do |t|
    t.string   "function"
    t.boolean  "installed",     :default => false
    t.integer  "user_id",                          :null => false
    t.integer  "commission_id",                    :null => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "commissions", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "email"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
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
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "events", :force => true do |t|
    t.time     "date"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "eventtype_id"
    t.integer  "agendaitem_id"
    t.float    "distance"
  end

  create_table "eventtypes", :force => true do |t|
    t.string   "name"
    t.string   "formula"
    t.string   "shortname"
    t.string   "measuringunit"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "calculated_unit"
  end

  create_table "newsitems", :force => true do |t|
    t.string   "title"
    t.text     "news"
    t.boolean  "agreed"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.integer  "agreed_by"
  end

  create_table "old_agendaitems", :id => false, :force => true do |t|
    t.integer "AgendaID",                            :null => false
    t.date    "Datum"
    t.string  "Plaats",               :limit => 100
    t.string  "Omschrijving",         :limit => 80
    t.text    "ExtraInfo"
    t.integer "Inschrijven"
    t.date    "SluitingInschrijving"
    t.integer "CommissieID"
    t.integer "AgendapuntTypeID"
    t.integer "Voorpagina"
    t.string  "InschrijvenEmail"
  end

  create_table "old_events", :id => false, :force => true do |t|
    t.integer "WedstrijdID",                :null => false
    t.date    "Datum"
    t.string  "Plaats",      :limit => 100
    t.string  "Naam",        :limit => 120
    t.text    "Opmerking"
    t.integer "Outdoor"
  end

  create_table "old_photoalbums", :id => false, :force => true do |t|
    t.integer "FotoAlbumID",                :null => false
    t.string  "Naam",        :limit => 150
    t.date    "Datum"
  end

  create_table "old_results", :id => false, :force => true do |t|
    t.integer "UitslagID",                                  :null => false
    t.integer "WedstrijdID",                :default => 0,  :null => false
    t.string  "Deelnemer",   :limit => 100, :default => "", :null => false
    t.string  "Onderdeel",   :limit => 100, :default => "", :null => false
    t.string  "Prestatie",   :limit => 30,  :default => "", :null => false
    t.integer "VoorKronos"
    t.integer "Geslacht"
    t.float   "Wind"
    t.string  "Punten",      :limit => 20
    t.float   "Kosten"
  end

  create_table "old_users", :id => false, :force => true do |t|
    t.integer "LidID",                              :null => false
    t.string  "Voorletters",         :limit => 12
    t.string  "Voornaam",            :limit => 50
    t.string  "Achternaam",          :limit => 60
    t.string  "Naam",                :limit => 70
    t.date    "GeboorteDatum"
    t.string  "Email",               :limit => 100
    t.string  "Adres",               :limit => 100
    t.string  "Postcode",            :limit => 10
    t.string  "Woonplaats",          :limit => 80
    t.string  "Wijk",                :limit => 20
    t.string  "UIN",                 :limit => 20
    t.string  "Telefoon",            :limit => 30
    t.string  "MobieleTelefoon",     :limit => 30
    t.text    "Opmerking"
    t.integer "Geslacht"
    t.string  "Wachtwoord",          :limit => 15
    t.string  "LicentieNummer",      :limit => 25
    t.integer "LidTypeID"
    t.integer "Privacy",             :limit => 2
    t.integer "Incasso",             :limit => 2
    t.integer "Jurylid",             :limit => 2
    t.string  "Campuskaart",         :limit => 20
    t.string  "Rekeningnummer",      :limit => 20
    t.string  "WedstrijdVereniging", :limit => 80
    t.string  "Nickname",            :limit => 100
    t.integer "OVKaart"
    t.integer "KMeterPapier",        :limit => 2
  end

  create_table "pages", :force => true do |t|
    t.text     "information"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "pagetag"
    t.integer  "user_id"
  end

  create_table "photoalbums", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "agendaitem_id"
  end

  create_table "photos", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "photoalbum_id"
    t.string   "youtube_id"
    t.boolean  "processing"
  end

  create_table "reactions", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "event_id"
    t.integer  "user_id"
  end

  create_table "subscriptions", :force => true do |t|
    t.text     "comment"
    t.string   "name"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
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
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin",               :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

end
