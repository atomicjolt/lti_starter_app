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

ActiveRecord::Schema.define(version: 2022_03_29_023856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accommodations", force: :cascade do |t|
    t.string "sis_id"
    t.string "course_crn"
    t.datetime "date_requested"
    t.float "time_extension"
    t.integer "attempts"
    t.integer "due_date_minutes"
    t.integer "close_date_minutes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lms_user_id"
    t.string "lms_course_id"
  end

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

  create_table "api_tokens", force: :cascade do |t|
    t.string "key", null: false
    t.string "encrypted_secret", null: false
    t.string "encrypted_secret_salt", null: false
    t.string "encrypted_secret_iv", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "application_instance_id"
    t.index ["application_instance_id"], name: "index_api_tokens_on_application_instance_id"
    t.index ["key"], name: "index_api_tokens_on_key", unique: true
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "application_bundles", force: :cascade do |t|
    t.bigint "application_id"
    t.bigint "bundle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id", "bundle_id"], name: "index_application_bundles_on_application_id_and_bundle_id"
  end

  create_table "application_instances", force: :cascade do |t|
    t.bigint "application_id"
    t.string "lti_key"
    t.string "lti_secret"
    t.string "encrypted_canvas_token"
    t.string "encrypted_canvas_token_salt"
    t.string "encrypted_canvas_token_iv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "domain", limit: 2048
    t.bigint "site_id"
    t.string "tenant"
    t.jsonb "config", default: {}
    t.jsonb "lti_config"
    t.datetime "disabled_at"
    t.bigint "bundle_instance_id"
    t.boolean "anonymous", default: false
    t.datetime "paid_at"
    t.boolean "rollbar_enabled", default: true
    t.boolean "use_scoped_developer_key", default: false, null: false
    t.text "global_css"
    t.string "proctorio_key"
    t.string "encrypted_proctorio_secret"
    t.string "encrypted_proctorio_secret_salt"
    t.string "encrypted_proctorio_secret_iv"
    t.string "nickname"
    t.string "primary_contact"
    t.datetime "license_start_date"
    t.datetime "license_end_date"
    t.datetime "trial_start_date"
    t.datetime "trial_end_date"
    t.text "license_notes"
    t.text "trial_notes"
    t.integer "licensed_users"
    t.integer "trial_users"
    t.index ["application_id"], name: "index_application_instances_on_application_id"
    t.index ["lti_key"], name: "index_application_instances_on_lti_key"
    t.index ["site_id"], name: "index_application_instances_on_site_id"
  end

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "client_application_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "kind", default: 0
    t.bigint "application_instances_count"
    t.jsonb "default_config", default: {}
    t.jsonb "lti_config"
    t.jsonb "canvas_api_permissions", default: {}
    t.string "subdomain"
    t.string "key"
    t.string "oauth_precedence", default: "global,user,application_instance,course"
    t.boolean "anonymous", default: false
    t.integer "free_trial_period", default: 31
    t.jsonb "lti_advantage_config", default: {}
    t.boolean "rollbar_enabled", default: true
    t.string "oauth_scopes", default: [], array: true
    t.string "oauth_key"
    t.string "oauth_secret"
    t.index ["key"], name: "index_applications_on_key"
  end

  create_table "assignment_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "assignment_id"
    t.boolean "submitted", default: false
    t.string "redirect_url"
    t.string "lis_result_sourcedid"
    t.string "lis_outcome_service_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "need_grading"
    t.string "ext_outcome_data_values_accepted"
    t.boolean "ext_outcome_result_total_score_accepted"
    t.string "ext_lti_assignment_id"
    t.string "token"
    t.datetime "submitted_to_lms_at"
    t.index ["assignment_id"], name: "index_assignment_users_on_assignment_id"
    t.index ["token"], name: "index_assignment_users_on_token", unique: true
    t.index ["user_id"], name: "index_assignment_users_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.string "reference_id"
    t.string "resource_id"
    t.string "resource_title"
    t.text "config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lms_assignment_id"
    t.datetime "available_from"
    t.datetime "available_until"
    t.string "lms_course_id"
    t.string "resource_link_id"
    t.boolean "is_submitted", default: false
    t.boolean "published", default: false
    t.string "embed_url", limit: 2048
    t.datetime "due_date"
    t.string "lms_assignment_override_id"
    t.boolean "is_embedded", default: false
    t.integer "assigned_student_count"
    t.float "score_average", default: 0.0
    t.boolean "is_deeply_linked", default: false, null: false
    t.boolean "is_adaptive", default: false, null: false
    t.float "ability_score_average"
    t.boolean "deleted", default: false, null: false
    t.string "line_item_id"
    t.bigint "lti_deployment_id"
    t.index ["lms_course_id"], name: "index_assignments_on_lms_course_id"
    t.index ["resource_link_id"], name: "index_assignments_on_resource_link_id"
  end

  create_table "attempt_events", force: :cascade do |t|
    t.bigint "attempt_id"
    t.string "name", null: false
    t.string "kind", null: false
    t.string "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "question_ref"
    t.string "item_ref"
    t.string "response_id"
    t.datetime "resolved_at"
    t.bigint "resolved_by_id"
    t.bigint "user_id"
    t.index ["attempt_id"], name: "index_attempt_events_on_attempt_id"
  end

  create_table "attempts", force: :cascade do |t|
    t.boolean "completed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "assignment_user_id"
    t.string "session_id"
    t.boolean "is_primary", default: false
    t.datetime "completed_at"
    t.boolean "started"
    t.datetime "started_at"
    t.datetime "paused_at"
    t.datetime "failed_at"
    t.text "failed_error"
    t.datetime "reviewed_at"
    t.string "reference_ids", array: true
    t.datetime "last_scored_at"
    t.float "decimal_score"
    t.float "manual_score"
    t.float "total_score"
    t.float "total_max_score"
    t.datetime "unscorable_at"
    t.string "lrn_score_job_id"
    t.datetime "additional_time_started_at"
    t.float "ability_score"
    t.boolean "graded"
    t.datetime "last_attempted_at"
    t.datetime "time_limit_expires_at"
    t.index ["assignment_user_id"], name: "index_attempts_on_assignment_user_id"
    t.index ["completed", "time_limit_expires_at"], name: "index_attempts_on_completed_and_time_limit_expires_at"
  end

  create_table "authentications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uid"
    t.string "provider_avatar"
    t.string "username"
    t.string "provider_url", limit: 2048
    t.string "encrypted_token"
    t.string "encrypted_token_salt"
    t.string "encrypted_token_iv"
    t.string "encrypted_secret"
    t.string "encrypted_secret_salt"
    t.string "encrypted_secret_iv"
    t.string "encrypted_refresh_token"
    t.string "encrypted_refresh_token_salt"
    t.string "encrypted_refresh_token_iv"
    t.string "id_token"
    t.string "lti_user_id"
    t.bigint "application_instance_id"
    t.bigint "canvas_course_id"
    t.index ["lti_user_id"], name: "index_authentications_on_lti_user_id"
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["uid", "provider", "provider_url"], name: "index_authentications_on_uid_and_provider_and_provider_url"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "bundle_instances", force: :cascade do |t|
    t.bigint "site_id"
    t.bigint "bundle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "entity_key"
    t.string "id_token"
    t.index ["id_token"], name: "index_bundle_instances_on_id_token"
  end

  create_table "bundles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
    t.boolean "shared_tenant", default: false
    t.index ["key"], name: "index_bundles_on_key"
  end

  create_table "canvas_content_export_conversion_errors", force: :cascade do |t|
    t.string "error_type"
    t.string "message"
    t.integer "question_index"
    t.bigint "canvas_quiz_id"
    t.string "question_type"
    t.bigint "canvas_content_export_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "qti_item_id"
    t.index ["canvas_content_export_id", "canvas_quiz_id", "question_index"], name: "canvas_content_export_conversion_errors_question_uniq", unique: true
    t.index ["canvas_content_export_id"], name: "index_canvas_content_export_conversion_errors_export_id"
  end

  create_table "canvas_content_exports", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "guid"
    t.string "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "tags"
  end

  create_table "canvas_courses", force: :cascade do |t|
    t.bigint "lms_course_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "custom_css"
    t.string "export_copy_type", default: "copy", null: false
    t.string "import_strategy", default: "import_all_content", null: false
    t.datetime "enable_authoring_at"
    t.string "author_setting_user_id"
    t.text "author_setting", default: "global"
    t.index ["lms_course_id"], name: "index_canvas_courses_on_lms_course_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "subdomain"
    t.string "domain"
    t.string "lms_domain"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_notifications", force: :cascade do |t|
    t.string "message", null: false
    t.string "context_id", null: false
    t.boolean "acknowledged", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_users", force: :cascade do |t|
    t.bigint "section_ids", array: true
    t.string "lms_user_id"
    t.bigint "lms_course_id"
    t.string "context_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["lms_course_id", "lms_user_id"], name: "index_course_users_on_lms_course_id_and_lms_user_id", unique: true
  end

  create_table "find_tagged_items_statuses", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "error_message"
    t.text "error_trace"
    t.bigint "assignment_id"
    t.string "context_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_find_tagged_items_statuses_on_assignment_id", unique: true
  end

  create_table "ims_exports", id: :serial, force: :cascade do |t|
    t.string "token"
    t.string "tool_consumer_instance_guid"
    t.string "context_id"
    t.string "custom_canvas_course_id"
    t.jsonb "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "processing"
    t.string "message", limit: 2048
    t.index ["token"], name: "index_ims_exports_on_token"
  end

  create_table "ims_import_statuses", force: :cascade do |t|
    t.bigint "ims_import_id", null: false
    t.string "kind", null: false
    t.string "status", default: "initialized", null: false
    t.string "error_message"
    t.text "error_trace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "info"
    t.index ["ims_import_id"], name: "index_ims_import_statuses_on_ims_import_id"
  end

  create_table "ims_imports", force: :cascade do |t|
    t.string "create_launches_status", default: "initialized", null: false
    t.string "error_message"
    t.text "error_trace"
    t.string "export_token"
    t.string "context_id", null: false
    t.string "tci_guid", null: false
    t.string "lms_course_id", null: false
    t.string "source_context_id", null: false
    t.string "source_tci_guid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "create_activities_status", default: "finished", null: false
    t.string "update_activities_status", default: "finished", null: false
    t.string "create_items_status", default: "finished", null: false
    t.string "update_items_status", default: "finished", null: false
    t.jsonb "payload"
    t.boolean "acknowledged", default: false, null: false
    t.string "course_workflow_state", default: "active", null: false
  end

  create_table "job_statuses", force: :cascade do |t|
    t.string "kind", null: false
    t.string "key", null: false
    t.string "status", default: "initialized", null: false
    t.jsonb "data", default: {}, null: false
    t.string "error_message"
    t.string "error_trace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["kind", "key"], name: "index_job_statuses_on_kind_and_key"
  end

  create_table "jwks", force: :cascade do |t|
    t.string "kid"
    t.string "pem"
    t.bigint "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_jwks_on_application_id"
    t.index ["kid"], name: "index_jwks_on_kid"
  end

  create_table "leads", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "site_id"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_leads_on_email"
    t.index ["site_id"], name: "index_leads_on_site_id"
    t.index ["user_id"], name: "index_leads_on_user_id"
  end

  create_table "learnosity_authentications", force: :cascade do |t|
    t.bigint "application_instance_id"
    t.string "learnosity_key"
    t.string "learnosity_secret"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "region"
  end

  create_table "learnosity_exports", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "temp_file_path"
    t.string "guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "error_message"
    t.text "error_trace"
    t.index ["guid"], name: "index_learnosity_exports_on_guid", unique: true
  end

  create_table "learnosity_imports", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "temp_file_path"
    t.string "guid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "error_message"
    t.text "error_trace"
    t.index ["guid"], name: "index_learnosity_imports_on_guid", unique: true
  end

  create_table "lti_deployments", force: :cascade do |t|
    t.bigint "application_instance_id"
    t.string "deployment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lti_install_id"
    t.index ["application_instance_id"], name: "index_lti_deployments_on_application_instance_id"
    t.index ["deployment_id", "application_instance_id", "lti_install_id"], name: "index_lti_deployments_on_d_id_and_ai_id_and_li_id", unique: true
    t.index ["deployment_id"], name: "index_lti_deployments_on_deployment_id"
    t.index ["lti_install_id"], name: "index_lti_deployments_on_lti_install_id"
  end

  create_table "lti_installs", force: :cascade do |t|
    t.string "iss"
    t.bigint "application_id"
    t.string "client_id"
    t.string "jwks_url"
    t.string "token_url"
    t.string "oidc_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "registration_client_uri"
    t.index ["application_id", "iss"], name: "index_lti_installs_on_application_id_and_iss"
    t.index ["application_id"], name: "index_lti_installs_on_application_id"
    t.index ["client_id", "iss"], name: "index_lti_installs_on_client_id_and_iss", unique: true
    t.index ["client_id"], name: "index_lti_installs_on_client_id"
    t.index ["iss"], name: "index_lti_installs_on_iss"
  end

  create_table "lti_launches", force: :cascade do |t|
    t.jsonb "config"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.string "context_id"
    t.string "tool_consumer_instance_guid"
    t.bigint "assignment_id"
    t.string "resource_link_id"
    t.index ["assignment_id"], name: "index_lti_launches_on_assignment_id"
    t.index ["context_id"], name: "index_lti_launches_on_context_id"
    t.index ["resource_link_id"], name: "index_lti_launches_on_resource_link_id"
    t.index ["token", "context_id"], name: "index_lti_launches_on_token_and_context_id", unique: true
  end

  create_table "lti_tools", force: :cascade do |t|
    t.string "name"
    t.string "icon"
    t.string "url"
    t.string "encrypted_lti_key"
    t.string "encrypted_lti_key_salt"
    t.string "encrypted_lti_key_iv"
    t.string "encrypted_lti_secret"
    t.string "encrypted_lti_secret_salt"
    t.string "encrypted_lti_secret_iv"
    t.integer "kind", default: 0
    t.bigint "application_instance_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "no_response_auth_required", default: false
    t.index ["application_instance_id"], name: "index_lti_tools_on_application_instance_id"
  end

  create_table "nonces", force: :cascade do |t|
    t.string "nonce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nonce"], name: "index_nonces_on_nonce", unique: true
  end

  create_table "oauth_states", force: :cascade do |t|
    t.string "state"
    t.text "payload"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state"], name: "index_oauth_states_on_state"
  end

  create_table "onboard_job_statuses", force: :cascade do |t|
    t.string "learnosity_key", null: false
    t.string "status", default: "started"
    t.datetime "started_at"
    t.string "error"
    t.string "backtrace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learnosity_key"], name: "index_onboard_job_statuses_on_learnosity_key", unique: true
  end

  create_table "open_id_states", force: :cascade do |t|
    t.string "nonce"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nonce"], name: "index_open_id_states_on_nonce", unique: true
  end

  create_table "overrides", force: :cascade do |t|
    t.integer "time_limit"
    t.integer "allowed_attempts", default: 1
    t.bigint "lms_id"
    t.bigint "assignment_id"
    t.string "student_ids", array: true
    t.bigint "course_section_id"
    t.datetime "due_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "unlock_at"
    t.datetime "lock_at"
    t.bigint "lock_job_id"
    t.datetime "lock_job_run_at"
    t.index ["assignment_id"], name: "index_overrides_on_assignment_id"
  end

  create_table "parent_contexts", force: :cascade do |t|
    t.bigint "lms_course_id"
    t.string "parent_context_id", null: false
    t.string "parent_tool_consumer_instance_guid", null: false
    t.string "context_id", null: false
    t.string "tool_consumer_instance_guid", null: false
    t.boolean "is_readonly"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_context_id", "parent_tool_consumer_instance_guid", "context_id", "tool_consumer_instance_guid"], name: "parent_contexts_context_parent_uniq", unique: true
    t.check_constraint "(parent_context_id)::text <> (context_id)::text", name: "parent_contexts_not_self_ref"
  end

  create_table "permissions", force: :cascade do |t|
    t.bigint "role_id"
    t.bigint "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "context_id"
    t.index ["context_id"], name: "index_permissions_on_context_id"
    t.index ["role_id", "user_id", "context_id"], name: "index_permissions_on_role_id_and_user_id_and_context_id", unique: true
    t.index ["role_id", "user_id"], name: "index_permissions_on_role_id_and_user_id", unique: true, where: "(context_id IS NULL)"
  end

  create_table "proctor_presets", force: :cascade do |t|
    t.string "name", null: false
    t.string "lms_course_id"
    t.string "context_id"
    t.string "proctoring_tool"
    t.jsonb "proctor_settings"
    t.string "preset_type", default: "CUSTOM", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "application_instance_id"
    t.index ["application_instance_id"], name: "index_proctor_presets_on_application_instance_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "tag"
    t.string "image_url"
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "client_id"
  end

  create_table "publish_assignment_statuses", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "error_message"
    t.text "error_trace"
    t.bigint "assignment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "job_id"
    t.index ["assignment_id"], name: "index_publish_assignment_statuses_on_assignment_id", unique: true
  end

  create_table "qti_import_conversion_errors", force: :cascade do |t|
    t.string "error_type"
    t.string "message"
    t.integer "question_index"
    t.string "question_type"
    t.string "qti_item_id"
    t.bigint "learnosity_import_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["learnosity_import_id"], name: "index_qti_import_conversion_errors_on_learnosity_import_id"
  end

  create_table "que_jobs", comment: "5", force: :cascade do |t|
    t.integer "priority", limit: 2, default: 100, null: false
    t.datetime "run_at", default: -> { "now()" }, null: false
    t.text "job_class", null: false
    t.integer "error_count", default: 0, null: false
    t.text "last_error_message"
    t.text "queue", default: "default", null: false
    t.text "last_error_backtrace"
    t.datetime "finished_at"
    t.datetime "expired_at"
    t.jsonb "args", default: [], null: false
    t.jsonb "data", default: {}, null: false
    t.integer "job_schema_version", default: 1
    t.index ["args"], name: "que_jobs_args_gin_idx", opclass: :jsonb_path_ops, using: :gin
    t.index ["data"], name: "que_jobs_data_gin_idx", opclass: :jsonb_path_ops, using: :gin
    t.index ["job_class"], name: "que_scheduler_job_in_que_jobs_unique_index", unique: true, where: "(job_class = 'Que::Scheduler::SchedulerJob'::text)"
    t.index ["job_schema_version", "queue", "priority", "run_at", "id"], name: "que_poll_idx_with_job_schema_version", where: "((finished_at IS NULL) AND (expired_at IS NULL))"
    t.index ["queue", "priority", "run_at", "id"], name: "que_poll_idx", where: "((finished_at IS NULL) AND (expired_at IS NULL))"
    t.check_constraint "(char_length(last_error_message) <= 500) AND (char_length(last_error_backtrace) <= 10000)", name: "error_length"
    t.check_constraint "(jsonb_typeof(data) = 'object'::text) AND ((NOT (data ? 'tags'::text)) OR ((jsonb_typeof((data -> 'tags'::text)) = 'array'::text) AND (jsonb_array_length((data -> 'tags'::text)) <= 5) AND que_validate_tags((data -> 'tags'::text))))", name: "valid_data"
    t.check_constraint "char_length(queue) <= 100", name: "queue_length"
    t.check_constraint "jsonb_typeof(args) = 'array'::text", name: "valid_args"
    t.check_constraint nil, name: "job_class_length"
  end

  create_table "que_lockers", primary_key: "pid", id: :integer, default: nil, force: :cascade do |t|
    t.integer "worker_count", null: false
    t.integer "worker_priorities", null: false, array: true
    t.integer "ruby_pid", null: false
    t.text "ruby_hostname", null: false
    t.text "queues", null: false, array: true
    t.boolean "listening", null: false
    t.integer "job_schema_version", default: 1
    t.check_constraint "(array_ndims(queues) = 1) AND (array_length(queues, 1) IS NOT NULL)", name: "valid_queues"
    t.check_constraint "(array_ndims(worker_priorities) = 1) AND (array_length(worker_priorities, 1) IS NOT NULL)", name: "valid_worker_priorities"
  end

  create_table "que_scheduler_audit", primary_key: "scheduler_job_id", id: :bigint, default: nil, comment: "6", force: :cascade do |t|
    t.datetime "executed_at", null: false
  end

  create_table "que_scheduler_audit_enqueued", id: false, force: :cascade do |t|
    t.bigint "scheduler_job_id", null: false
    t.string "job_class", limit: 255, null: false
    t.string "queue", limit: 255
    t.integer "priority"
    t.jsonb "args", null: false
    t.bigint "job_id"
    t.datetime "run_at"
    t.index ["args"], name: "que_scheduler_audit_enqueued_args"
    t.index ["job_class"], name: "que_scheduler_audit_enqueued_job_class"
    t.index ["job_id"], name: "que_scheduler_audit_enqueued_job_id"
  end

  create_table "que_values", primary_key: "key", id: :text, force: :cascade do |t|
    t.jsonb "value", default: {}, null: false
    t.check_constraint "jsonb_typeof(value) = 'object'::text", name: "valid_value"
  end

  create_table "request_statistics", primary_key: ["truncated_time", "tenant"], force: :cascade do |t|
    t.datetime "truncated_time", null: false
    t.string "tenant", null: false
    t.integer "number_of_hits", default: 1
    t.integer "number_of_lti_launches", default: 0
    t.integer "number_of_errors", default: 0
  end

  create_table "request_user_statistics", primary_key: ["truncated_time", "tenant", "user_id"], force: :cascade do |t|
    t.datetime "truncated_time", null: false
    t.string "tenant", null: false
    t.bigint "user_id", null: false
  end

  create_table "response_exports", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "temp_file_path"
    t.string "guid"
    t.string "error_message"
    t.text "error_trace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid"], name: "index_response_exports_on_guid", unique: true
  end

  create_table "response_score_overrides", force: :cascade do |t|
    t.bigint "attempt_id"
    t.float "score"
    t.float "max_score"
    t.string "response_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attempt_id", "response_id"], name: "index_response_score_overrides_on_attempt_id_and_response_id", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "score_assignment_statuses", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "error_message"
    t.text "error_trace"
    t.bigint "assignment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_score_assignment_statuses_on_assignment_id", unique: true
  end

  create_table "setting_presets", force: :cascade do |t|
    t.string "name", null: false
    t.string "lms_course_id"
    t.string "context_id"
    t.boolean "auto_submit", default: false
    t.integer "retake_amount", default: 1
    t.boolean "use_access_code", default: false
    t.string "access_code"
    t.string "show_answers", default: "AFTER_SUBMISSION"
    t.boolean "render_inline", default: true
    t.boolean "shuffle_items", default: false
    t.boolean "time_limit", default: false
    t.integer "limit_minutes"
    t.string "keep_score", default: "LATEST"
    t.boolean "assign_to_specific_students", default: false
    t.boolean "show_time"
    t.boolean "show_intro"
    t.boolean "show_summary", default: true
    t.boolean "hide_module_navigation"
    t.integer "random_question_count"
    t.boolean "high_stakes", default: false
    t.boolean "skip_submit_confirmation", default: true
    t.boolean "show_remaining_attempts", default: true
    t.boolean "show_sample_answer", default: false
    t.boolean "continue_after_correct", default: false
    t.boolean "create_gradebook", default: true
    t.boolean "show_manual_feedback_to_students", default: true
    t.boolean "display_try_again", default: true
    t.float "penalty_percent", default: 0.0
    t.string "check_answer_enabled", default: "ITEM"
    t.integer "use_penalty_type", default: 0
    t.integer "check_answer_count", default: 1
    t.boolean "show_mercy", default: false, null: false
    t.integer "highlighting_timing", default: 15
    t.integer "correct_answer_timing", default: 7
    t.integer "correct_feedback_timing", default: 15
    t.integer "general_feedback_timing", default: 7
    t.integer "response_feedback_timing", default: 15
    t.integer "sample_answer_timing", default: 7
    t.integer "score_timing", default: 15
    t.integer "teacher_feedback_timing", default: 3
    t.string "ip_filters", limit: 1024
    t.integer "points_possible_timing", default: 0, null: false
    t.boolean "enable_numbering", default: true, null: false
    t.bigint "application_instance_id"
    t.string "preset_type", default: "CUSTOM", null: false
    t.boolean "auto_finish_after_close", default: false, null: false
    t.boolean "enable_hints", default: true
    t.boolean "wall_clock_timer", default: false
    t.boolean "show_student_outcomes", default: false
    t.index ["application_instance_id"], name: "index_setting_presets_on_application_instance_id"
  end

  create_table "settings", force: :cascade do |t|
    t.bigint "assignment_id"
    t.boolean "auto_submit", default: false
    t.integer "retake_amount", default: 1
    t.boolean "use_access_code", default: false
    t.string "access_code"
    t.string "show_answers", default: "AFTER_SUBMISSION"
    t.boolean "render_inline", default: true
    t.boolean "shuffle_items", default: false
    t.boolean "time_limit", default: false
    t.integer "limit_minutes"
    t.string "keep_score", default: "LATEST"
    t.boolean "assign_to_specific_students", default: false
    t.boolean "show_time"
    t.boolean "show_intro"
    t.boolean "show_summary", default: true
    t.boolean "hide_module_navigation"
    t.integer "random_question_count"
    t.boolean "high_stakes", default: false
    t.boolean "skip_submit_confirmation", default: true
    t.boolean "show_remaining_attempts", default: true
    t.boolean "show_sample_answer", default: false
    t.boolean "continue_after_correct", default: false
    t.boolean "create_gradebook", default: true
    t.boolean "show_manual_feedback_to_students", default: true
    t.boolean "display_try_again", default: true
    t.float "penalty_percent", default: 0.0
    t.boolean "sample_on_tags", default: false
    t.jsonb "tags_to_sample"
    t.string "check_answer_enabled", default: "ITEM"
    t.integer "use_penalty_type", default: 0
    t.integer "check_answer_count", default: 1
    t.boolean "show_mercy", default: false, null: false
    t.integer "highlighting_timing", default: 15
    t.integer "correct_answer_timing", default: 7
    t.integer "correct_feedback_timing", default: 15
    t.integer "general_feedback_timing", default: 7
    t.integer "response_feedback_timing", default: 15
    t.integer "sample_answer_timing", default: 7
    t.integer "score_timing", default: 15
    t.integer "teacher_feedback_timing", default: 3
    t.string "ip_filters", limit: 1024
    t.integer "points_possible_timing", default: 0, null: false
    t.boolean "enable_numbering", default: true, null: false
    t.boolean "auto_finish_after_close", default: false, null: false
    t.string "proctoring_tool"
    t.jsonb "proctor_settings", default: {}
    t.boolean "enable_hints", default: true
    t.boolean "wall_clock_timer", default: false
    t.boolean "show_student_outcomes", default: false
    t.index ["assignment_id"], name: "index_settings_on_assignment_id"
  end

  create_table "site_urls", force: :cascade do |t|
    t.bigint "site_id"
    t.string "url", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sites", force: :cascade do |t|
    t.string "url", limit: 2048
    t.string "oauth_key"
    t.string "oauth_secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "secret"
    t.index ["url"], name: "index_sites_on_url"
  end

  create_table "submit_all_attempts_statuses", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "error_message"
    t.text "error_trace"
    t.bigint "assignment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_submit_all_attempts_statuses_on_assignment_id", unique: true
  end

  create_table "summary_exports", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "temp_file_path"
    t.string "guid"
    t.string "error_message"
    t.text "error_trace"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guid"], name: "index_summary_exports_on_guid", unique: true
  end

  create_table "tag_types", force: :cascade do |t|
    t.bigint "lms_course_id", null: false
    t.string "name", null: false
    t.text "context_id", null: false
    t.index ["context_id", "name"], name: "index_tag_types_on_context_id_and_name", unique: true
    t.index ["lms_course_id"], name: "index_tag_types_on_lms_course_id"
  end

  create_table "tags", force: :cascade do |t|
    t.bigint "tag_type_id", null: false
    t.string "name", null: false
    t.index ["tag_type_id", "name"], name: "index_tags_on_tag_type_id_and_name", unique: true
  end

  create_table "update_and_publish_score_statuses", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "error_message"
    t.text "error_trace"
    t.bigint "assignment_user_id"
    t.string "context_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "publish_assignment_status_id"
    t.bigint "job_id"
    t.index ["assignment_user_id"], name: "index_update_and_publish_score_statuses_on_assignment_user_id", unique: true
  end

  create_table "update_scores_job_statuses", force: :cascade do |t|
    t.string "status", default: "initialized"
    t.string "error_message"
    t.text "error_trace"
    t.bigint "attempt_id"
    t.string "context_id"
    t.string "job_reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "job_id"
    t.index ["attempt_id"], name: "index_update_scores_job_statuses_on_attempt_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.bigint "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "password_salt"
    t.string "lti_user_id"
    t.string "lti_provider"
    t.string "lms_user_id"
    t.bigint "create_method", default: 0
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "sis_id"
    t.string "legacy_lti_user_id"
    t.string "encrypted_otp_secret"
    t.string "encrypted_otp_secret_iv"
    t.string "encrypted_otp_secret_salt"
    t.integer "consumed_timestep"
    t.boolean "otp_required_for_login"
    t.string "otp_backup_codes", array: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["legacy_lti_user_id"], name: "index_users_on_legacy_lti_user_id", unique: true
    t.index ["lms_user_id", "lti_user_id"], name: "index_users_on_lms_user_id_and_lti_user_id"
    t.index ["lti_user_id"], name: "index_users_on_lti_user_id", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "assignments", "lti_deployments", name: "fk_assignments_lti_deployments"
  add_foreign_key "canvas_content_export_conversion_errors", "canvas_content_exports", on_delete: :cascade
  add_foreign_key "find_tagged_items_statuses", "assignments", on_delete: :cascade
  add_foreign_key "ims_import_statuses", "ims_imports", on_delete: :cascade
  add_foreign_key "lti_deployments", "lti_installs"
  add_foreign_key "overrides", "assignments"
  add_foreign_key "publish_assignment_statuses", "assignments", on_delete: :cascade
  add_foreign_key "qti_import_conversion_errors", "learnosity_imports", on_delete: :cascade
  add_foreign_key "que_scheduler_audit_enqueued", "que_scheduler_audit", column: "scheduler_job_id", primary_key: "scheduler_job_id", name: "que_scheduler_audit_enqueued_scheduler_job_id_fkey"
  add_foreign_key "response_score_overrides", "attempts", on_delete: :cascade
  add_foreign_key "score_assignment_statuses", "assignments", on_delete: :cascade
  add_foreign_key "submit_all_attempts_statuses", "assignments", on_delete: :cascade
  add_foreign_key "tags", "tag_types", on_delete: :cascade
  add_foreign_key "update_and_publish_score_statuses", "assignment_users", on_delete: :cascade
  add_foreign_key "update_and_publish_score_statuses", "publish_assignment_statuses", on_delete: :cascade
  add_foreign_key "update_scores_job_statuses", "attempts", on_delete: :cascade
end
