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

ActiveRecord::Schema[7.0].define(version: 2023_11_19_125502) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactions", force: :cascade do |t|
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.integer "transaction_type", default: 0
    t.uuid "source_id"
    t.uuid "destination_id"
    t.uuid "recipient_id"
    t.uuid "creator_id"
    t.uuid "last_updater_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_transactions_on_creator_id"
    t.index ["destination_id"], name: "index_transactions_on_destination_id"
    t.index ["last_updater_id"], name: "index_transactions_on_last_updater_id"
    t.index ["recipient_id"], name: "index_transactions_on_recipient_id"
    t.index ["source_id"], name: "index_transactions_on_source_id"
  end

  create_table "user_sessions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "session_token"
    t.string "login_ip"
    t.string "browser"
    t.uuid "user_id"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_sessions_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password_encrypted", null: false
    t.string "type"
    t.integer "role", default: 1
    t.integer "status", default: 0
    t.datetime "confirmed_at"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "resourcable_type"
    t.uuid "resourcable_id"
    t.decimal "balance", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resourcable_type", "resourcable_id"], name: "index_wallets_on_resourcable"
  end

end
