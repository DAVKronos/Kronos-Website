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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_23_095817) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agendaitems", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "date"
    t.string "location"
    t.boolean "subscribe"
    t.datetime "subscriptiondeadline"
    t.integer "commission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "category"
    t.boolean "intern"
    t.integer "agendaitemtype_id"
    t.string "url"
    t.integer "user_id"
    t.string "name_en"
    t.text "description_en"
    t.integer "maxsubscription"
  end

  create_table "agendaitemtype_eventtypes", force: :cascade do |t|
    t.integer "agendaitemtype_id"
    t.integer "eventtype_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agendaitemtypes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_match"
    t.string "name_en"
  end

  create_table "aliases", force: :cascade do |t|
    t.text "name"
    t.text "emailaddress"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "aliases_mailinglists", id: false, force: :cascade do |t|
    t.integer "alias_id"
    t.integer "mailinglist_id"
    t.index ["alias_id", "mailinglist_id"], name: "index_aliases_mailinglists_on_alias_id_and_mailinglist_id"
  end

  create_table "announcements", force: :cascade do |t|
    t.text "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "background_file_name"
    t.string "background_content_type"
    t.integer "background_file_size"
    t.datetime "background_updated_at"
    t.text "title"
    t.text "url"
  end

  create_table "apps_exceptions", force: :cascade do |t|
    t.string "email"
    t.boolean "way"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group_email"
  end

  create_table "chatmessages", force: :cascade do |t|
    t.string "by"
    t.text "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email"
    t.integer "user_id"
    t.string "user_ip"
    t.string "user_agent"
    t.string "referrer"
  end

  create_table "comments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "agendaitem_id"
    t.integer "result_id"
    t.integer "photo_id"
    t.integer "newsitem_id"
    t.text "commenttext"
    t.integer "commentable_id"
    t.string "commentable_type"
  end

  create_table "commission_memberships", force: :cascade do |t|
    t.string "function"
    t.boolean "installed", default: false
    t.integer "user_id", null: false
    t.integer "commission_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "role"
    t.string "name_en"
    t.text "description_en"
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "queue"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", force: :cascade do |t|
    t.time "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "eventtype_id"
    t.integer "agendaitem_id"
    t.float "distance"
  end

  create_table "eventtypes", force: :cascade do |t|
    t.string "name"
    t.string "formula"
    t.string "shortname"
    t.string "measuringunit"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "calculated_unit"
    t.boolean "show_wind", default: false
    t.string "female_formula"
    t.boolean "important"
  end

  create_table "folders", force: :cascade do |t|
    t.string "name"
    t.integer "folder_id"
  end

  create_table "kronometers", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "file_file_name"
    t.string "file_content_type"
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "folder_id"
    t.boolean "public", default: false
  end

  create_table "mailinglist_memberships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "mailinglist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mailinglist_id"], name: "index_mailinglist_memberships_on_mailinglist_id"
    t.index ["user_id"], name: "index_mailinglist_memberships_on_user_id"
  end

  create_table "mailinglists", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "local_part"
    t.integer "commission_id"
    t.integer "mailinglist_id"
  end

  create_table "newsitems", force: :cascade do |t|
    t.string "title"
    t.text "news"
    t.boolean "agreed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "agreed_by"
    t.string "articlephoto_file_name"
    t.string "articlephoto_content_type"
    t.integer "articlephoto_file_size"
    t.datetime "articlephoto_updated_at"
    t.string "title_en"
    t.text "news_en"
  end

  create_table "old_photoalbums", id: false, force: :cascade do |t|
    t.integer "FotoAlbumID", null: false
    t.string "Naam", limit: 150
    t.date "Datum"
  end

  create_table "old_photos", id: false, force: :cascade do |t|
    t.integer "FotoID", null: false
    t.integer "FotoAlbumID"
    t.text "Omschrijving"
    t.integer "LidID"
  end

  create_table "old_users", id: false, force: :cascade do |t|
    t.integer "LidID", null: false
    t.string "Voorletters", limit: 12
    t.string "Voornaam", limit: 50
    t.string "Achternaam", limit: 60
    t.string "Naam", limit: 70
    t.date "GeboorteDatum"
    t.string "Email", limit: 100
    t.string "Adres", limit: 100
    t.string "Postcode", limit: 10
    t.string "Woonplaats", limit: 80
    t.string "Wijk", limit: 20
    t.string "UIN", limit: 20
    t.string "Telefoon", limit: 30
    t.string "MobieleTelefoon", limit: 30
    t.text "Opmerking"
    t.integer "Geslacht"
    t.string "Wachtwoord", limit: 15
    t.string "LicentieNummer", limit: 25
    t.integer "LidTypeID"
    t.integer "Privacy"
    t.integer "Incasso"
    t.integer "Jurylid"
    t.string "Campuskaart", limit: 20
    t.string "Rekeningnummer", limit: 20
    t.string "WedstrijdVereniging", limit: 80
    t.string "Nickname", limit: 100
    t.integer "OVKaart"
    t.integer "KMeterPapier"
  end

  create_table "pages", force: :cascade do |t|
    t.text "information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "pagetag"
    t.string "menu"
    t.boolean "highlight"
    t.string "pagetag_en"
    t.text "information_en"
    t.boolean "public", default: true
    t.integer "sort_order"
  end

  create_table "photoalbums", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "agendaitem_id"
    t.boolean "public"
    t.datetime "eventdate"
    t.string "name_en"
    t.string "url"
  end

  create_table "photos", force: :cascade do |t|
    t.string "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer "photoalbum_id"
    t.string "youtube_id"
    t.boolean "processing"
    t.datetime "exif_date"
  end

  create_table "results", force: :cascade do |t|
    t.string "username"
    t.string "result"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "event_id"
    t.integer "user_id"
    t.decimal "wind"
    t.integer "place"
    t.decimal "calculated"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.text "comment"
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "agendaitem_id"
    t.boolean "reserve", default: false
  end

  create_table "tags", force: :cascade do |t|
    t.integer "photo_id"
    t.integer "user_id"
    t.integer "xpos"
    t.integer "ypos"
    t.integer "width"
    t.integer "heigth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", force: :cascade do |t|
    t.string "name"
    t.boolean "donor"
    t.boolean "competition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "initials"
    t.string "email", default: "", null: false
    t.date "birthdate"
    t.string "address"
    t.string "postalcode"
    t.string "city"
    t.string "sex"
    t.string "licensenumber"
    t.boolean "papieren_kronometer", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "phonenumber"
    t.integer "user_type_id"
    t.string "bank_account_number"
    t.string "xtracard"
    t.string "iban"
    t.string "studie"
    t.string "instelling"
    t.integer "aanvang"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.datetime "confirmed_at", default: "2021-01-25 19:44:55"
    t.boolean "allow_password_change", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "versions", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

end
