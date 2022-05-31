# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_06_01_111111) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "agendaitems", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.datetime "date"
    t.string "location", limit: 255
    t.boolean "subscribe"
    t.datetime "subscriptiondeadline"
    t.integer "commission_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "category", limit: 255
    t.boolean "intern"
    t.integer "agendaitemtype_id"
    t.string "url", limit: 255
    t.integer "user_id"
    t.string "name_en", limit: 255
    t.text "description_en"
    t.integer "maxsubscription"
  end

  create_table "agendaitemtype_eventtypes", id: :serial, force: :cascade do |t|
    t.integer "agendaitemtype_id"
    t.integer "eventtype_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "agendaitemtypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_match"
    t.string "name_en", limit: 255
  end

  create_table "aliases", id: :serial, force: :cascade do |t|
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

  create_table "announcements", id: :serial, force: :cascade do |t|
    t.text "message"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "background_file_name", limit: 255
    t.string "background_content_type", limit: 255
    t.integer "background_file_size"
    t.datetime "background_updated_at"
    t.text "title"
    t.text "url"
  end

  create_table "apps_exceptions", id: :serial, force: :cascade do |t|
    t.string "email", limit: 255
    t.boolean "way"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "group_email", limit: 255
  end

  create_table "chatmessages", id: :serial, force: :cascade do |t|
    t.string "by", limit: 255
    t.text "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", limit: 255
    t.integer "user_id"
    t.string "user_ip", limit: 255
    t.string "user_agent", limit: 255
    t.string "referrer", limit: 255
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "agendaitem_id"
    t.integer "result_id"
    t.integer "photo_id"
    t.integer "newsitem_id"
    t.text "commenttext"
    t.integer "commentable_id"
    t.string "commentable_type", limit: 255
  end

  create_table "commission_memberships", id: :serial, force: :cascade do |t|
    t.string "function", limit: 255
    t.boolean "installed", default: false
    t.integer "user_id", null: false
    t.integer "commission_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commissions", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.string "email", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "role", limit: 255
    t.string "name_en", limit: 255
    t.text "description_en"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0
    t.integer "attempts", default: 0
    t.text "handler"
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "queue", limit: 255
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.time "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "eventtype_id"
    t.integer "agendaitem_id"
    t.float "distance"
  end

  create_table "eventtypes", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "formula", limit: 255
    t.string "shortname", limit: 255
    t.string "measuringunit", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "calculated_unit", limit: 255
    t.boolean "show_wind", default: false
    t.string "female_formula", limit: 255
    t.boolean "important"
  end

  create_table "folders", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "folder_id"
  end

  create_table "kronometers", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.date "date"
    t.string "file_file_name", limit: 255
    t.string "file_content_type", limit: 255
    t.integer "file_file_size"
    t.datetime "file_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "folder_id"
    t.boolean "public", default: false
  end

  create_table "mailinglist_memberships", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "mailinglist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mailinglist_id"], name: "index_mailinglist_memberships_on_mailinglist_id"
    t.index ["user_id"], name: "index_mailinglist_memberships_on_user_id"
  end

  create_table "mailinglists", id: :serial, force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "local_part", limit: 255
    t.integer "commission_id"
    t.integer "mailinglist_id"
  end

  create_table "newsitems", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255
    t.text "news"
    t.boolean "agreed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "agreed_by"
    t.string "articlephoto_file_name", limit: 255
    t.string "articlephoto_content_type", limit: 255
    t.integer "articlephoto_file_size"
    t.datetime "articlephoto_updated_at"
    t.string "title_en", limit: 255
    t.text "news_en"
  end

  create_table "old_photoalbums", primary_key: "FotoAlbumID", id: :integer, default: nil, force: :cascade do |t|
    t.string "Naam", limit: 150
    t.date "Datum"
  end

  create_table "old_photos", primary_key: "FotoID", id: :integer, default: nil, force: :cascade do |t|
    t.integer "FotoAlbumID"
    t.text "Omschrijving"
    t.integer "LidID"
  end

  create_table "old_users", primary_key: "LidID", id: :integer, default: nil, force: :cascade do |t|
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

  create_table "pages", id: :serial, force: :cascade do |t|
    t.text "information"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "pagetag", limit: 255
    t.string "menu", limit: 255
    t.boolean "highlight"
    t.string "pagetag_en", limit: 255
    t.text "information_en"
    t.boolean "public", default: true
    t.integer "sort_order"
  end

  create_table "photoalbums", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "agendaitem_id"
    t.boolean "public"
    t.datetime "eventdate"
    t.string "name_en"
    t.string "url"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "caption", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "photo_file_name", limit: 255
    t.string "photo_content_type", limit: 255
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer "photoalbum_id"
    t.string "youtube_id", limit: 255
    t.boolean "processing"
    t.datetime "exif_date"
  end

  create_table "results", id: :serial, force: :cascade do |t|
    t.string "username", limit: 255
    t.string "result", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "event_id"
    t.integer "user_id"
    t.decimal "wind"
    t.integer "place"
    t.decimal "calculated"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.text "comment"
    t.string "name", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.integer "agendaitem_id"
    t.boolean "reserve", default: false
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.integer "photo_id"
    t.integer "user_id"
    t.integer "xpos"
    t.integer "ypos"
    t.integer "width"
    t.integer "heigth"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", id: :serial, force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_types", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.boolean "donor"
    t.boolean "competition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name_en"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "initials", limit: 255
    t.string "email", limit: 255, default: "", null: false
    t.date "birthdate"
    t.string "address", limit: 255
    t.string "postalcode", limit: 255
    t.string "city", limit: 255
    t.string "sex", limit: 255
    t.string "licensenumber", limit: 255
    t.boolean "papieren_kronometer", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "avatar_file_name", limit: 255
    t.string "avatar_content_type", limit: 255
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "encrypted_password", limit: 255, default: "", null: false
    t.string "reset_password_token", limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip", limit: 255
    t.string "last_sign_in_ip", limit: 255
    t.string "phonenumber", limit: 255
    t.integer "user_type_id"
    t.string "bank_account_number", limit: 255
    t.string "xtracard", limit: 255
    t.string "iban", limit: 255
    t.string "studie", limit: 255
    t.string "instelling", limit: 255
    t.integer "aanvang"
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.text "tokens"
    t.datetime "confirmed_at", default: "2021-07-21 17:41:51"
    t.boolean "allow_password_change", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", limit: 255, null: false
    t.integer "item_id", null: false
    t.string "event", limit: 255, null: false
    t.string "whodunnit", limit: 255
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
