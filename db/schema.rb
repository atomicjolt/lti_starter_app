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

ActiveRecord::Schema.define(version: 20170613231518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "application_bundles", force: :cascade do |t|
    t.integer  "application_id"
    t.integer  "bundle_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["application_id", "bundle_id"], name: "index_application_bundles_on_application_id_and_bundle_id", using: :btree
  end

  create_table "application_instances", force: :cascade do |t|
    t.integer  "application_id"
    t.string   "lti_key"
    t.string   "lti_secret"
    t.string   "encrypted_canvas_token"
    t.string   "encrypted_canvas_token_salt"
    t.string   "encrypted_canvas_token_iv"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
    t.string   "domain",                      limit: 2048
    t.integer  "site_id"
    t.string   "tenant"
    t.jsonb    "config",                                   default: {}
    t.jsonb    "lti_config"
    t.index ["application_id"], name: "index_application_instances_on_application_id", using: :btree
    t.index ["site_id"], name: "index_application_instances_on_site_id", using: :btree
  end

  create_table "applications", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "client_application_name"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.integer  "kind",                        default: 0
    t.integer  "application_instances_count"
    t.jsonb    "default_config",              default: {}
    t.jsonb    "lti_config"
    t.jsonb    "canvas_api_permissions",      default: {}
  end

  create_table "authentications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.text     "json_response"
    t.string   "uid"
    t.string   "provider_avatar"
    t.string   "username"
    t.string   "provider_url",                 limit: 2048
    t.string   "encrypted_token"
    t.string   "encrypted_token_salt"
    t.string   "encrypted_token_iv"
    t.string   "encrypted_secret"
    t.string   "encrypted_secret_salt"
    t.string   "encrypted_secret_iv"
    t.string   "encrypted_refresh_token"
    t.string   "encrypted_refresh_token_salt"
    t.string   "encrypted_refresh_token_iv"
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid", using: :btree
    t.index ["user_id"], name: "index_authentications_on_user_id", using: :btree
  end

  create_table "bundles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lti_launches", force: :cascade do |t|
    t.jsonb    "config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "token"
    t.index ["token"], name: "index_lti_launches_on_token", unique: true, using: :btree
  end

  create_table "nonces", force: :cascade do |t|
    t.string   "nonce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nonce"], name: "index_nonces_on_nonce", unique: true, using: :btree
  end

  create_table "oauth_states", force: :cascade do |t|
    t.string   "state"
    t.text     "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_oauth_states_on_state", using: :btree
  end

  create_table "permissions", force: :cascade do |t|
    t.integer  "role_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "context_id"
    t.index ["context_id"], name: "index_permissions_on_context_id", using: :btree
    t.index ["role_id", "user_id", "context_id"], name: "index_permissions_on_role_id_and_user_id_and_context_id", using: :btree
    t.index ["role_id", "user_id"], name: "index_permissions_on_role_id_and_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: :cascade do |t|
    t.string   "url",          limit: 2048
    t.string   "oauth_key"
    t.string   "oauth_secret"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["url"], name: "index_sites_on_url", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "time_zone",              default: "UTC"
    t.string   "password_salt"
    t.string   "lti_user_id"
    t.string   "lti_provider"
    t.string   "lms_user_id"
    t.integer  "create_method",          default: 0
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
