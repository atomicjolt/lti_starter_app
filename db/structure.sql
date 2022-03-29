SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.que_scheduler_audit_enqueued DROP CONSTRAINT IF EXISTS que_scheduler_audit_enqueued_scheduler_job_id_fkey;
ALTER TABLE IF EXISTS ONLY public.find_tagged_items_statuses DROP CONSTRAINT IF EXISTS fk_rails_e20272d2d1;
ALTER TABLE IF EXISTS ONLY public.lti_deployments DROP CONSTRAINT IF EXISTS fk_rails_d5b56eb24a;
ALTER TABLE IF EXISTS ONLY public.active_storage_attachments DROP CONSTRAINT IF EXISTS fk_rails_c3b3935057;
ALTER TABLE IF EXISTS ONLY public.update_scores_job_statuses DROP CONSTRAINT IF EXISTS fk_rails_c2b1188048;
ALTER TABLE IF EXISTS ONLY public.update_and_publish_score_statuses DROP CONSTRAINT IF EXISTS fk_rails_ab99166d0c;
ALTER TABLE IF EXISTS ONLY public.overrides DROP CONSTRAINT IF EXISTS fk_rails_9ea8def08b;
ALTER TABLE IF EXISTS ONLY public.active_storage_variant_records DROP CONSTRAINT IF EXISTS fk_rails_993965df05;
ALTER TABLE IF EXISTS ONLY public.publish_assignment_statuses DROP CONSTRAINT IF EXISTS fk_rails_93b78a617c;
ALTER TABLE IF EXISTS ONLY public.score_assignment_statuses DROP CONSTRAINT IF EXISTS fk_rails_7f96a22b41;
ALTER TABLE IF EXISTS ONLY public.canvas_content_export_conversion_errors DROP CONSTRAINT IF EXISTS fk_rails_7f74435535;
ALTER TABLE IF EXISTS ONLY public.ims_import_statuses DROP CONSTRAINT IF EXISTS fk_rails_5deeb262e7;
ALTER TABLE IF EXISTS ONLY public.qti_import_conversion_errors DROP CONSTRAINT IF EXISTS fk_rails_583772d8e5;
ALTER TABLE IF EXISTS ONLY public.submit_all_attempts_statuses DROP CONSTRAINT IF EXISTS fk_rails_52060d416a;
ALTER TABLE IF EXISTS ONLY public.response_score_overrides DROP CONSTRAINT IF EXISTS fk_rails_0e485744e0;
ALTER TABLE IF EXISTS ONLY public.update_and_publish_score_statuses DROP CONSTRAINT IF EXISTS fk_rails_0db8ecbd4f;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS fk_rails_08dd3a10dd;
ALTER TABLE IF EXISTS ONLY public.assignments DROP CONSTRAINT IF EXISTS fk_assignments_lti_deployments;
DROP TRIGGER IF EXISTS que_state_notify ON public.que_jobs;
DROP TRIGGER IF EXISTS que_scheduler_prevent_job_deletion_trigger ON public.que_jobs;
DROP TRIGGER IF EXISTS que_job_notify ON public.que_jobs;
DROP INDEX IF EXISTS public.que_scheduler_job_in_que_jobs_unique_index;
DROP INDEX IF EXISTS public.que_scheduler_audit_enqueued_job_id;
DROP INDEX IF EXISTS public.que_scheduler_audit_enqueued_job_class;
DROP INDEX IF EXISTS public.que_scheduler_audit_enqueued_args;
DROP INDEX IF EXISTS public.que_poll_idx_with_job_schema_version;
DROP INDEX IF EXISTS public.que_poll_idx;
DROP INDEX IF EXISTS public.que_jobs_data_gin_idx;
DROP INDEX IF EXISTS public.que_jobs_args_gin_idx;
DROP INDEX IF EXISTS public.parent_contexts_context_parent_uniq;
DROP INDEX IF EXISTS public.index_users_on_reset_password_token;
DROP INDEX IF EXISTS public.index_users_on_lti_user_id;
DROP INDEX IF EXISTS public.index_users_on_lms_user_id_and_lti_user_id;
DROP INDEX IF EXISTS public.index_users_on_legacy_lti_user_id;
DROP INDEX IF EXISTS public.index_users_on_invited_by_id;
DROP INDEX IF EXISTS public.index_users_on_invited_by;
DROP INDEX IF EXISTS public.index_users_on_invitations_count;
DROP INDEX IF EXISTS public.index_users_on_invitation_token;
DROP INDEX IF EXISTS public.index_users_on_email;
DROP INDEX IF EXISTS public.index_update_scores_job_statuses_on_attempt_id;
DROP INDEX IF EXISTS public.index_update_and_publish_score_statuses_on_assignment_user_id;
DROP INDEX IF EXISTS public.index_tags_on_tag_type_id_and_name;
DROP INDEX IF EXISTS public.index_tag_types_on_lms_course_id;
DROP INDEX IF EXISTS public.index_tag_types_on_context_id_and_name;
DROP INDEX IF EXISTS public.index_summary_exports_on_guid;
DROP INDEX IF EXISTS public.index_submit_all_attempts_statuses_on_assignment_id;
DROP INDEX IF EXISTS public.index_sites_on_url;
DROP INDEX IF EXISTS public.index_settings_on_assignment_id;
DROP INDEX IF EXISTS public.index_setting_presets_on_application_instance_id;
DROP INDEX IF EXISTS public.index_score_assignment_statuses_on_assignment_id;
DROP INDEX IF EXISTS public.index_response_score_overrides_on_attempt_id_and_response_id;
DROP INDEX IF EXISTS public.index_response_exports_on_guid;
DROP INDEX IF EXISTS public.index_qti_import_conversion_errors_on_learnosity_import_id;
DROP INDEX IF EXISTS public.index_publish_assignment_statuses_on_assignment_id;
DROP INDEX IF EXISTS public.index_proctor_presets_on_application_instance_id;
DROP INDEX IF EXISTS public.index_permissions_on_role_id_and_user_id_and_context_id;
DROP INDEX IF EXISTS public.index_permissions_on_role_id_and_user_id;
DROP INDEX IF EXISTS public.index_permissions_on_context_id;
DROP INDEX IF EXISTS public.index_overrides_on_assignment_id;
DROP INDEX IF EXISTS public.index_open_id_states_on_nonce;
DROP INDEX IF EXISTS public.index_onboard_job_statuses_on_learnosity_key;
DROP INDEX IF EXISTS public.index_oauth_states_on_state;
DROP INDEX IF EXISTS public.index_nonces_on_nonce;
DROP INDEX IF EXISTS public.index_lti_tools_on_application_instance_id;
DROP INDEX IF EXISTS public.index_lti_launches_on_token_and_context_id;
DROP INDEX IF EXISTS public.index_lti_launches_on_resource_link_id;
DROP INDEX IF EXISTS public.index_lti_launches_on_context_id;
DROP INDEX IF EXISTS public.index_lti_launches_on_assignment_id;
DROP INDEX IF EXISTS public.index_lti_installs_on_iss;
DROP INDEX IF EXISTS public.index_lti_installs_on_client_id_and_iss;
DROP INDEX IF EXISTS public.index_lti_installs_on_client_id;
DROP INDEX IF EXISTS public.index_lti_installs_on_application_id_and_iss;
DROP INDEX IF EXISTS public.index_lti_installs_on_application_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_lti_install_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_deployment_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_d_id_and_ai_id_and_li_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_application_instance_id;
DROP INDEX IF EXISTS public.index_learnosity_imports_on_guid;
DROP INDEX IF EXISTS public.index_learnosity_exports_on_guid;
DROP INDEX IF EXISTS public.index_leads_on_user_id;
DROP INDEX IF EXISTS public.index_leads_on_site_id;
DROP INDEX IF EXISTS public.index_leads_on_email;
DROP INDEX IF EXISTS public.index_jwks_on_kid;
DROP INDEX IF EXISTS public.index_jwks_on_application_id;
DROP INDEX IF EXISTS public.index_job_statuses_on_kind_and_key;
DROP INDEX IF EXISTS public.index_ims_import_statuses_on_ims_import_id;
DROP INDEX IF EXISTS public.index_ims_exports_on_token;
DROP INDEX IF EXISTS public.index_find_tagged_items_statuses_on_assignment_id;
DROP INDEX IF EXISTS public.index_course_users_on_lms_course_id_and_lms_user_id;
DROP INDEX IF EXISTS public.index_canvas_courses_on_lms_course_id;
DROP INDEX IF EXISTS public.index_canvas_content_export_conversion_errors_export_id;
DROP INDEX IF EXISTS public.index_bundles_on_key;
DROP INDEX IF EXISTS public.index_bundle_instances_on_id_token;
DROP INDEX IF EXISTS public.index_authentications_on_user_id;
DROP INDEX IF EXISTS public.index_authentications_on_uid_and_provider_and_provider_url;
DROP INDEX IF EXISTS public.index_authentications_on_provider_and_uid;
DROP INDEX IF EXISTS public.index_authentications_on_lti_user_id;
DROP INDEX IF EXISTS public.index_attempts_on_completed_and_time_limit_expires_at;
DROP INDEX IF EXISTS public.index_attempts_on_assignment_user_id;
DROP INDEX IF EXISTS public.index_attempt_events_on_attempt_id;
DROP INDEX IF EXISTS public.index_assignments_on_resource_link_id;
DROP INDEX IF EXISTS public.index_assignments_on_lms_course_id;
DROP INDEX IF EXISTS public.index_assignment_users_on_user_id;
DROP INDEX IF EXISTS public.index_assignment_users_on_token;
DROP INDEX IF EXISTS public.index_assignment_users_on_assignment_id;
DROP INDEX IF EXISTS public.index_applications_on_key;
DROP INDEX IF EXISTS public.index_application_instances_on_site_id;
DROP INDEX IF EXISTS public.index_application_instances_on_lti_key;
DROP INDEX IF EXISTS public.index_application_instances_on_application_id;
DROP INDEX IF EXISTS public.index_application_bundles_on_application_id_and_bundle_id;
DROP INDEX IF EXISTS public.index_api_tokens_on_user_id;
DROP INDEX IF EXISTS public.index_api_tokens_on_key;
DROP INDEX IF EXISTS public.index_api_tokens_on_application_instance_id;
DROP INDEX IF EXISTS public.index_active_storage_variant_records_uniqueness;
DROP INDEX IF EXISTS public.index_active_storage_blobs_on_key;
DROP INDEX IF EXISTS public.index_active_storage_attachments_uniqueness;
DROP INDEX IF EXISTS public.index_active_storage_attachments_on_blob_id;
DROP INDEX IF EXISTS public.canvas_content_export_conversion_errors_question_uniq;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.update_scores_job_statuses DROP CONSTRAINT IF EXISTS update_scores_job_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.update_and_publish_score_statuses DROP CONSTRAINT IF EXISTS update_and_publish_score_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.tags DROP CONSTRAINT IF EXISTS tags_pkey;
ALTER TABLE IF EXISTS ONLY public.tag_types DROP CONSTRAINT IF EXISTS tag_types_pkey;
ALTER TABLE IF EXISTS ONLY public.summary_exports DROP CONSTRAINT IF EXISTS summary_exports_pkey;
ALTER TABLE IF EXISTS ONLY public.submit_all_attempts_statuses DROP CONSTRAINT IF EXISTS submit_all_attempts_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.sites DROP CONSTRAINT IF EXISTS sites_pkey;
ALTER TABLE IF EXISTS ONLY public.site_urls DROP CONSTRAINT IF EXISTS site_urls_pkey;
ALTER TABLE IF EXISTS ONLY public.settings DROP CONSTRAINT IF EXISTS settings_pkey;
ALTER TABLE IF EXISTS ONLY public.setting_presets DROP CONSTRAINT IF EXISTS setting_presets_pkey;
ALTER TABLE IF EXISTS ONLY public.score_assignment_statuses DROP CONSTRAINT IF EXISTS score_assignment_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY public.response_score_overrides DROP CONSTRAINT IF EXISTS response_score_overrides_pkey;
ALTER TABLE IF EXISTS ONLY public.response_exports DROP CONSTRAINT IF EXISTS response_exports_pkey;
ALTER TABLE IF EXISTS ONLY public.request_user_statistics DROP CONSTRAINT IF EXISTS request_user_statistics_pkey;
ALTER TABLE IF EXISTS ONLY public.request_statistics DROP CONSTRAINT IF EXISTS request_statistics_pkey;
ALTER TABLE IF EXISTS ONLY public.que_values DROP CONSTRAINT IF EXISTS que_values_pkey;
ALTER TABLE IF EXISTS ONLY public.que_scheduler_audit DROP CONSTRAINT IF EXISTS que_scheduler_audit_pkey;
ALTER TABLE IF EXISTS ONLY public.que_lockers DROP CONSTRAINT IF EXISTS que_lockers_pkey;
ALTER TABLE IF EXISTS ONLY public.que_jobs DROP CONSTRAINT IF EXISTS que_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.qti_import_conversion_errors DROP CONSTRAINT IF EXISTS qti_import_conversion_errors_pkey;
ALTER TABLE IF EXISTS ONLY public.publish_assignment_statuses DROP CONSTRAINT IF EXISTS publish_assignment_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.products DROP CONSTRAINT IF EXISTS products_pkey;
ALTER TABLE IF EXISTS ONLY public.proctor_presets DROP CONSTRAINT IF EXISTS proctor_presets_pkey;
ALTER TABLE IF EXISTS ONLY public.permissions DROP CONSTRAINT IF EXISTS permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.parent_contexts DROP CONSTRAINT IF EXISTS parent_contexts_pkey;
ALTER TABLE IF EXISTS ONLY public.overrides DROP CONSTRAINT IF EXISTS overrides_pkey;
ALTER TABLE IF EXISTS ONLY public.open_id_states DROP CONSTRAINT IF EXISTS open_id_states_pkey;
ALTER TABLE IF EXISTS ONLY public.onboard_job_statuses DROP CONSTRAINT IF EXISTS onboard_job_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.oauth_states DROP CONSTRAINT IF EXISTS oauth_states_pkey;
ALTER TABLE IF EXISTS ONLY public.nonces DROP CONSTRAINT IF EXISTS nonces_pkey;
ALTER TABLE IF EXISTS ONLY public.lti_tools DROP CONSTRAINT IF EXISTS lti_tools_pkey;
ALTER TABLE IF EXISTS ONLY public.lti_launches DROP CONSTRAINT IF EXISTS lti_launches_pkey;
ALTER TABLE IF EXISTS ONLY public.lti_installs DROP CONSTRAINT IF EXISTS lti_installs_pkey;
ALTER TABLE IF EXISTS ONLY public.lti_deployments DROP CONSTRAINT IF EXISTS lti_deployments_pkey;
ALTER TABLE IF EXISTS ONLY public.learnosity_imports DROP CONSTRAINT IF EXISTS learnosity_imports_pkey;
ALTER TABLE IF EXISTS ONLY public.learnosity_exports DROP CONSTRAINT IF EXISTS learnosity_exports_pkey;
ALTER TABLE IF EXISTS ONLY public.learnosity_authentications DROP CONSTRAINT IF EXISTS learnosity_authentications_pkey;
ALTER TABLE IF EXISTS ONLY public.leads DROP CONSTRAINT IF EXISTS leads_pkey;
ALTER TABLE IF EXISTS ONLY public.jwks DROP CONSTRAINT IF EXISTS jwks_pkey;
ALTER TABLE IF EXISTS ONLY public.job_statuses DROP CONSTRAINT IF EXISTS job_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.ims_imports DROP CONSTRAINT IF EXISTS ims_imports_pkey;
ALTER TABLE IF EXISTS ONLY public.ims_import_statuses DROP CONSTRAINT IF EXISTS ims_import_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.ims_exports DROP CONSTRAINT IF EXISTS ims_exports_pkey;
ALTER TABLE IF EXISTS ONLY public.find_tagged_items_statuses DROP CONSTRAINT IF EXISTS find_tagged_items_statuses_pkey;
ALTER TABLE IF EXISTS ONLY public.course_users DROP CONSTRAINT IF EXISTS course_users_pkey;
ALTER TABLE IF EXISTS ONLY public.course_notifications DROP CONSTRAINT IF EXISTS course_notifications_pkey;
ALTER TABLE IF EXISTS ONLY public.clients DROP CONSTRAINT IF EXISTS clients_pkey;
ALTER TABLE IF EXISTS ONLY public.canvas_courses DROP CONSTRAINT IF EXISTS canvas_courses_pkey;
ALTER TABLE IF EXISTS ONLY public.canvas_content_exports DROP CONSTRAINT IF EXISTS canvas_content_exports_pkey;
ALTER TABLE IF EXISTS ONLY public.canvas_content_export_conversion_errors DROP CONSTRAINT IF EXISTS canvas_content_export_conversion_errors_pkey;
ALTER TABLE IF EXISTS ONLY public.bundles DROP CONSTRAINT IF EXISTS bundles_pkey;
ALTER TABLE IF EXISTS ONLY public.bundle_instances DROP CONSTRAINT IF EXISTS bundle_instances_pkey;
ALTER TABLE IF EXISTS ONLY public.authentications DROP CONSTRAINT IF EXISTS authentications_pkey;
ALTER TABLE IF EXISTS ONLY public.attempts DROP CONSTRAINT IF EXISTS attempts_pkey;
ALTER TABLE IF EXISTS ONLY public.attempt_events DROP CONSTRAINT IF EXISTS attempt_events_pkey;
ALTER TABLE IF EXISTS ONLY public.assignments DROP CONSTRAINT IF EXISTS assignments_pkey;
ALTER TABLE IF EXISTS ONLY public.assignment_users DROP CONSTRAINT IF EXISTS assignment_users_pkey;
ALTER TABLE IF EXISTS ONLY public.ar_internal_metadata DROP CONSTRAINT IF EXISTS ar_internal_metadata_pkey;
ALTER TABLE IF EXISTS ONLY public.applications DROP CONSTRAINT IF EXISTS applications_pkey;
ALTER TABLE IF EXISTS ONLY public.application_instances DROP CONSTRAINT IF EXISTS application_instances_pkey;
ALTER TABLE IF EXISTS ONLY public.application_bundles DROP CONSTRAINT IF EXISTS application_bundles_pkey;
ALTER TABLE IF EXISTS ONLY public.api_tokens DROP CONSTRAINT IF EXISTS api_tokens_pkey;
ALTER TABLE IF EXISTS ONLY public.active_storage_variant_records DROP CONSTRAINT IF EXISTS active_storage_variant_records_pkey;
ALTER TABLE IF EXISTS ONLY public.active_storage_blobs DROP CONSTRAINT IF EXISTS active_storage_blobs_pkey;
ALTER TABLE IF EXISTS ONLY public.active_storage_attachments DROP CONSTRAINT IF EXISTS active_storage_attachments_pkey;
ALTER TABLE IF EXISTS ONLY public.accommodations DROP CONSTRAINT IF EXISTS accommodations_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.update_scores_job_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.update_and_publish_score_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tags ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.tag_types ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.summary_exports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.submit_all_attempts_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sites ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.site_urls ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.settings ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.setting_presets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.score_assignment_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.response_score_overrides ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.response_exports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.que_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.qti_import_conversion_errors ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.publish_assignment_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.products ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.proctor_presets ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.parent_contexts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.overrides ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.open_id_states ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.onboard_job_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.oauth_states ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.nonces ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lti_tools ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lti_launches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lti_installs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lti_deployments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.learnosity_imports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.learnosity_exports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.learnosity_authentications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.leads ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.jwks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.job_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ims_imports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ims_import_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ims_exports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.find_tagged_items_statuses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.course_users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.course_notifications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.clients ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.canvas_courses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.canvas_content_exports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.canvas_content_export_conversion_errors ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bundles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bundle_instances ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.authentications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.attempts ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.attempt_events ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.assignments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.assignment_users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.applications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.application_instances ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.application_bundles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.api_tokens ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.active_storage_variant_records ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.active_storage_blobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.active_storage_attachments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.accommodations ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.update_scores_job_statuses_id_seq;
DROP TABLE IF EXISTS public.update_scores_job_statuses;
DROP SEQUENCE IF EXISTS public.update_and_publish_score_statuses_id_seq;
DROP TABLE IF EXISTS public.update_and_publish_score_statuses;
DROP SEQUENCE IF EXISTS public.tags_id_seq;
DROP TABLE IF EXISTS public.tags;
DROP SEQUENCE IF EXISTS public.tag_types_id_seq;
DROP TABLE IF EXISTS public.tag_types;
DROP SEQUENCE IF EXISTS public.summary_exports_id_seq;
DROP TABLE IF EXISTS public.summary_exports;
DROP SEQUENCE IF EXISTS public.submit_all_attempts_statuses_id_seq;
DROP TABLE IF EXISTS public.submit_all_attempts_statuses;
DROP SEQUENCE IF EXISTS public.sites_id_seq;
DROP TABLE IF EXISTS public.sites;
DROP SEQUENCE IF EXISTS public.site_urls_id_seq;
DROP TABLE IF EXISTS public.site_urls;
DROP SEQUENCE IF EXISTS public.settings_id_seq;
DROP TABLE IF EXISTS public.settings;
DROP SEQUENCE IF EXISTS public.setting_presets_id_seq;
DROP TABLE IF EXISTS public.setting_presets;
DROP SEQUENCE IF EXISTS public.score_assignment_statuses_id_seq;
DROP TABLE IF EXISTS public.score_assignment_statuses;
DROP TABLE IF EXISTS public.schema_migrations;
DROP SEQUENCE IF EXISTS public.roles_id_seq;
DROP TABLE IF EXISTS public.roles;
DROP SEQUENCE IF EXISTS public.response_score_overrides_id_seq;
DROP TABLE IF EXISTS public.response_score_overrides;
DROP SEQUENCE IF EXISTS public.response_exports_id_seq;
DROP TABLE IF EXISTS public.response_exports;
DROP TABLE IF EXISTS public.request_user_statistics;
DROP TABLE IF EXISTS public.request_statistics;
DROP TABLE IF EXISTS public.que_values;
DROP TABLE IF EXISTS public.que_scheduler_audit_enqueued;
DROP TABLE IF EXISTS public.que_scheduler_audit;
DROP TABLE IF EXISTS public.que_lockers;
DROP SEQUENCE IF EXISTS public.que_jobs_id_seq;
DROP SEQUENCE IF EXISTS public.qti_import_conversion_errors_id_seq;
DROP TABLE IF EXISTS public.qti_import_conversion_errors;
DROP SEQUENCE IF EXISTS public.publish_assignment_statuses_id_seq;
DROP TABLE IF EXISTS public.publish_assignment_statuses;
DROP SEQUENCE IF EXISTS public.products_id_seq;
DROP TABLE IF EXISTS public.products;
DROP SEQUENCE IF EXISTS public.proctor_presets_id_seq;
DROP TABLE IF EXISTS public.proctor_presets;
DROP SEQUENCE IF EXISTS public.permissions_id_seq;
DROP TABLE IF EXISTS public.permissions;
DROP SEQUENCE IF EXISTS public.parent_contexts_id_seq;
DROP TABLE IF EXISTS public.parent_contexts;
DROP SEQUENCE IF EXISTS public.overrides_id_seq;
DROP TABLE IF EXISTS public.overrides;
DROP SEQUENCE IF EXISTS public.open_id_states_id_seq;
DROP TABLE IF EXISTS public.open_id_states;
DROP SEQUENCE IF EXISTS public.onboard_job_statuses_id_seq;
DROP TABLE IF EXISTS public.onboard_job_statuses;
DROP SEQUENCE IF EXISTS public.oauth_states_id_seq;
DROP TABLE IF EXISTS public.oauth_states;
DROP SEQUENCE IF EXISTS public.nonces_id_seq;
DROP TABLE IF EXISTS public.nonces;
DROP SEQUENCE IF EXISTS public.lti_tools_id_seq;
DROP TABLE IF EXISTS public.lti_tools;
DROP SEQUENCE IF EXISTS public.lti_launches_id_seq;
DROP TABLE IF EXISTS public.lti_launches;
DROP SEQUENCE IF EXISTS public.lti_installs_id_seq;
DROP TABLE IF EXISTS public.lti_installs;
DROP SEQUENCE IF EXISTS public.lti_deployments_id_seq;
DROP TABLE IF EXISTS public.lti_deployments;
DROP SEQUENCE IF EXISTS public.learnosity_imports_id_seq;
DROP TABLE IF EXISTS public.learnosity_imports;
DROP SEQUENCE IF EXISTS public.learnosity_exports_id_seq;
DROP TABLE IF EXISTS public.learnosity_exports;
DROP SEQUENCE IF EXISTS public.learnosity_authentications_id_seq;
DROP TABLE IF EXISTS public.learnosity_authentications;
DROP SEQUENCE IF EXISTS public.leads_id_seq;
DROP TABLE IF EXISTS public.leads;
DROP SEQUENCE IF EXISTS public.jwks_id_seq;
DROP TABLE IF EXISTS public.jwks;
DROP SEQUENCE IF EXISTS public.job_statuses_id_seq;
DROP TABLE IF EXISTS public.job_statuses;
DROP SEQUENCE IF EXISTS public.ims_imports_id_seq;
DROP TABLE IF EXISTS public.ims_imports;
DROP SEQUENCE IF EXISTS public.ims_import_statuses_id_seq;
DROP TABLE IF EXISTS public.ims_import_statuses;
DROP SEQUENCE IF EXISTS public.ims_exports_id_seq;
DROP TABLE IF EXISTS public.ims_exports;
DROP SEQUENCE IF EXISTS public.find_tagged_items_statuses_id_seq;
DROP TABLE IF EXISTS public.find_tagged_items_statuses;
DROP SEQUENCE IF EXISTS public.course_users_id_seq;
DROP TABLE IF EXISTS public.course_users;
DROP SEQUENCE IF EXISTS public.course_notifications_id_seq;
DROP TABLE IF EXISTS public.course_notifications;
DROP SEQUENCE IF EXISTS public.clients_id_seq;
DROP TABLE IF EXISTS public.clients;
DROP SEQUENCE IF EXISTS public.canvas_courses_id_seq;
DROP TABLE IF EXISTS public.canvas_courses;
DROP SEQUENCE IF EXISTS public.canvas_content_exports_id_seq;
DROP TABLE IF EXISTS public.canvas_content_exports;
DROP SEQUENCE IF EXISTS public.canvas_content_export_conversion_errors_id_seq;
DROP TABLE IF EXISTS public.canvas_content_export_conversion_errors;
DROP SEQUENCE IF EXISTS public.bundles_id_seq;
DROP TABLE IF EXISTS public.bundles;
DROP SEQUENCE IF EXISTS public.bundle_instances_id_seq;
DROP TABLE IF EXISTS public.bundle_instances;
DROP SEQUENCE IF EXISTS public.authentications_id_seq;
DROP TABLE IF EXISTS public.authentications;
DROP SEQUENCE IF EXISTS public.attempts_id_seq;
DROP TABLE IF EXISTS public.attempts;
DROP SEQUENCE IF EXISTS public.attempt_events_id_seq;
DROP TABLE IF EXISTS public.attempt_events;
DROP SEQUENCE IF EXISTS public.assignments_id_seq;
DROP TABLE IF EXISTS public.assignments;
DROP SEQUENCE IF EXISTS public.assignment_users_id_seq;
DROP TABLE IF EXISTS public.assignment_users;
DROP TABLE IF EXISTS public.ar_internal_metadata;
DROP SEQUENCE IF EXISTS public.applications_id_seq;
DROP TABLE IF EXISTS public.applications;
DROP SEQUENCE IF EXISTS public.application_instances_id_seq;
DROP TABLE IF EXISTS public.application_instances;
DROP SEQUENCE IF EXISTS public.application_bundles_id_seq;
DROP TABLE IF EXISTS public.application_bundles;
DROP SEQUENCE IF EXISTS public.api_tokens_id_seq;
DROP TABLE IF EXISTS public.api_tokens;
DROP SEQUENCE IF EXISTS public.active_storage_variant_records_id_seq;
DROP TABLE IF EXISTS public.active_storage_variant_records;
DROP SEQUENCE IF EXISTS public.active_storage_blobs_id_seq;
DROP TABLE IF EXISTS public.active_storage_blobs;
DROP SEQUENCE IF EXISTS public.active_storage_attachments_id_seq;
DROP TABLE IF EXISTS public.active_storage_attachments;
DROP SEQUENCE IF EXISTS public.accommodations_id_seq;
DROP TABLE IF EXISTS public.accommodations;
DROP FUNCTION IF EXISTS public.que_state_notify();
DROP FUNCTION IF EXISTS public.que_scheduler_prevent_job_deletion();
DROP FUNCTION IF EXISTS public.que_scheduler_check_job_exists();
DROP FUNCTION IF EXISTS public.que_job_notify();
DROP FUNCTION IF EXISTS public.que_determine_job_state(job public.que_jobs);
DROP TABLE IF EXISTS public.que_jobs;
DROP FUNCTION IF EXISTS public.que_validate_tags(tags_array jsonb);
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- Name: que_validate_tags(jsonb); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.que_validate_tags(tags_array jsonb) RETURNS boolean
    LANGUAGE sql
    AS $$
  SELECT bool_and(
    jsonb_typeof(value) = 'string'
    AND
    char_length(value::text) <= 100
  )
  FROM jsonb_array_elements(tags_array)
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: que_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.que_jobs (
    priority smallint DEFAULT 100 NOT NULL,
    run_at timestamp with time zone DEFAULT now() NOT NULL,
    id bigint NOT NULL,
    job_class text NOT NULL,
    error_count integer DEFAULT 0 NOT NULL,
    last_error_message text,
    queue text DEFAULT 'default'::text NOT NULL,
    last_error_backtrace text,
    finished_at timestamp with time zone,
    expired_at timestamp with time zone,
    args jsonb DEFAULT '[]'::jsonb NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    job_schema_version integer DEFAULT 1,
    CONSTRAINT error_length CHECK (((char_length(last_error_message) <= 500) AND (char_length(last_error_backtrace) <= 10000))),
    CONSTRAINT job_class_length CHECK ((char_length(
CASE job_class
    WHEN 'ActiveJob::QueueAdapters::QueAdapter::JobWrapper'::text THEN ((args -> 0) ->> 'job_class'::text)
    ELSE job_class
END) <= 200)),
    CONSTRAINT queue_length CHECK ((char_length(queue) <= 100)),
    CONSTRAINT valid_args CHECK ((jsonb_typeof(args) = 'array'::text)),
    CONSTRAINT valid_data CHECK (((jsonb_typeof(data) = 'object'::text) AND ((NOT (data ? 'tags'::text)) OR ((jsonb_typeof((data -> 'tags'::text)) = 'array'::text) AND (jsonb_array_length((data -> 'tags'::text)) <= 5) AND public.que_validate_tags((data -> 'tags'::text))))))
)
WITH (fillfactor='90');


--
-- Name: TABLE que_jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.que_jobs IS '5';


--
-- Name: que_determine_job_state(public.que_jobs); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.que_determine_job_state(job public.que_jobs) RETURNS text
    LANGUAGE sql
    AS $$
  SELECT
    CASE
    WHEN job.expired_at  IS NOT NULL    THEN 'expired'
    WHEN job.finished_at IS NOT NULL    THEN 'finished'
    WHEN job.error_count > 0            THEN 'errored'
    WHEN job.run_at > CURRENT_TIMESTAMP THEN 'scheduled'
    ELSE                                     'ready'
    END
$$;


--
-- Name: que_job_notify(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.que_job_notify() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  DECLARE
    locker_pid integer;
    sort_key json;
  BEGIN
    -- Don't do anything if the job is scheduled for a future time.
    IF NEW.run_at IS NOT NULL AND NEW.run_at > now() THEN
      RETURN null;
    END IF;

    -- Pick a locker to notify of the job's insertion, weighted by their number
    -- of workers. Should bounce pseudorandomly between lockers on each
    -- invocation, hence the md5-ordering, but still touch each one equally,
    -- hence the modulo using the job_id.
    SELECT pid
    INTO locker_pid
    FROM (
      SELECT *, last_value(row_number) OVER () + 1 AS count
      FROM (
        SELECT *, row_number() OVER () - 1 AS row_number
        FROM (
          SELECT *
          FROM public.que_lockers ql, generate_series(1, ql.worker_count) AS id
          WHERE
            listening AND
            queues @> ARRAY[NEW.queue] AND
            ql.job_schema_version = NEW.job_schema_version
          ORDER BY md5(pid::text || id::text)
        ) t1
      ) t2
    ) t3
    WHERE NEW.id % count = row_number;

    IF locker_pid IS NOT NULL THEN
      -- There's a size limit to what can be broadcast via LISTEN/NOTIFY, so
      -- rather than throw errors when someone enqueues a big job, just
      -- broadcast the most pertinent information, and let the locker query for
      -- the record after it's taken the lock. The worker will have to hit the
      -- DB in order to make sure the job is still visible anyway.
      SELECT row_to_json(t)
      INTO sort_key
      FROM (
        SELECT
          'job_available' AS message_type,
          NEW.queue       AS queue,
          NEW.priority    AS priority,
          NEW.id          AS id,
          -- Make sure we output timestamps as UTC ISO 8601
          to_char(NEW.run_at AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.US"Z"') AS run_at
      ) t;

      PERFORM pg_notify('que_listener_' || locker_pid::text, sort_key::text);
    END IF;

    RETURN null;
  END
$$;


--
-- Name: que_scheduler_check_job_exists(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.que_scheduler_check_job_exists() RETURNS boolean
    LANGUAGE sql
    AS $$
SELECT EXISTS(SELECT * FROM que_jobs WHERE job_class = 'Que::Scheduler::SchedulerJob');
$$;


--
-- Name: que_scheduler_prevent_job_deletion(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.que_scheduler_prevent_job_deletion() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
BEGIN
    IF OLD.job_class = 'Que::Scheduler::SchedulerJob' THEN
        IF NOT que_scheduler_check_job_exists() THEN
            raise exception 'Deletion of que_scheduler job % prevented. Deleting the que_scheduler job is almost certainly a mistake.', OLD.job_id;
        END IF;
    END IF;
    RETURN OLD;
END;
$$;


--
-- Name: que_state_notify(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.que_state_notify() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
  DECLARE
    row record;
    message json;
    previous_state text;
    current_state text;
  BEGIN
    IF TG_OP = 'INSERT' THEN
      previous_state := 'nonexistent';
      current_state  := public.que_determine_job_state(NEW);
      row            := NEW;
    ELSIF TG_OP = 'DELETE' THEN
      previous_state := public.que_determine_job_state(OLD);
      current_state  := 'nonexistent';
      row            := OLD;
    ELSIF TG_OP = 'UPDATE' THEN
      previous_state := public.que_determine_job_state(OLD);
      current_state  := public.que_determine_job_state(NEW);

      -- If the state didn't change, short-circuit.
      IF previous_state = current_state THEN
        RETURN null;
      END IF;

      row := NEW;
    ELSE
      RAISE EXCEPTION 'Unrecognized TG_OP: %', TG_OP;
    END IF;

    SELECT row_to_json(t)
    INTO message
    FROM (
      SELECT
        'job_change' AS message_type,
        row.id       AS id,
        row.queue    AS queue,

        coalesce(row.data->'tags', '[]'::jsonb) AS tags,

        to_char(row.run_at AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.US"Z"') AS run_at,
        to_char(now()      AT TIME ZONE 'UTC', 'YYYY-MM-DD"T"HH24:MI:SS.US"Z"') AS time,

        CASE row.job_class
        WHEN 'ActiveJob::QueueAdapters::QueAdapter::JobWrapper' THEN
          coalesce(
            row.args->0->>'job_class',
            'ActiveJob::QueueAdapters::QueAdapter::JobWrapper'
          )
        ELSE
          row.job_class
        END AS job_class,

        previous_state AS previous_state,
        current_state  AS current_state
    ) t;

    PERFORM pg_notify('que_state', message::text);

    RETURN null;
  END
$$;


--
-- Name: accommodations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.accommodations (
    id bigint NOT NULL,
    sis_id character varying,
    course_crn character varying,
    date_requested timestamp without time zone,
    time_extension double precision,
    attempts integer,
    due_date_minutes integer,
    close_date_minutes integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    lms_user_id character varying,
    lms_course_id character varying
);


--
-- Name: accommodations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.accommodations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accommodations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.accommodations_id_seq OWNED BY public.accommodations.id;


--
-- Name: active_storage_attachments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_attachments (
    id bigint NOT NULL,
    name character varying NOT NULL,
    record_type character varying NOT NULL,
    record_id bigint NOT NULL,
    blob_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_attachments_id_seq OWNED BY public.active_storage_attachments.id;


--
-- Name: active_storage_blobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_blobs (
    id bigint NOT NULL,
    key character varying NOT NULL,
    filename character varying NOT NULL,
    content_type character varying,
    metadata text,
    service_name character varying NOT NULL,
    byte_size bigint NOT NULL,
    checksum character varying NOT NULL,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_blobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_blobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_blobs_id_seq OWNED BY public.active_storage_blobs.id;


--
-- Name: active_storage_variant_records; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.active_storage_variant_records (
    id bigint NOT NULL,
    blob_id bigint NOT NULL,
    variation_digest character varying NOT NULL
);


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.active_storage_variant_records_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_storage_variant_records_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.active_storage_variant_records_id_seq OWNED BY public.active_storage_variant_records.id;


--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_tokens (
    id bigint NOT NULL,
    key character varying NOT NULL,
    encrypted_secret character varying NOT NULL,
    encrypted_secret_salt character varying NOT NULL,
    encrypted_secret_iv character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id bigint,
    application_instance_id bigint
);


--
-- Name: api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_tokens_id_seq OWNED BY public.api_tokens.id;


--
-- Name: application_bundles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.application_bundles (
    id bigint NOT NULL,
    application_id bigint,
    bundle_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: application_bundles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.application_bundles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_bundles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.application_bundles_id_seq OWNED BY public.application_bundles.id;


--
-- Name: application_instances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.application_instances (
    id bigint NOT NULL,
    application_id bigint,
    lti_key character varying,
    lti_secret character varying,
    encrypted_canvas_token character varying,
    encrypted_canvas_token_salt character varying,
    encrypted_canvas_token_iv character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    domain character varying(2048),
    site_id bigint,
    tenant character varying,
    config jsonb DEFAULT '{}'::jsonb,
    lti_config jsonb,
    disabled_at timestamp without time zone,
    bundle_instance_id bigint,
    anonymous boolean DEFAULT false,
    paid_at timestamp without time zone,
    rollbar_enabled boolean DEFAULT true,
    use_scoped_developer_key boolean DEFAULT false NOT NULL,
    global_css text,
    proctorio_key character varying,
    encrypted_proctorio_secret character varying,
    encrypted_proctorio_secret_salt character varying,
    encrypted_proctorio_secret_iv character varying,
    nickname character varying,
    primary_contact character varying,
    license_start_date timestamp without time zone,
    license_end_date timestamp without time zone,
    trial_start_date timestamp without time zone,
    trial_end_date timestamp without time zone,
    license_notes text,
    trial_notes text,
    licensed_users integer,
    trial_users integer
);


--
-- Name: application_instances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.application_instances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: application_instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.application_instances_id_seq OWNED BY public.application_instances.id;


--
-- Name: applications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.applications (
    id bigint NOT NULL,
    name character varying,
    description character varying,
    client_application_name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    kind bigint DEFAULT 0,
    application_instances_count bigint,
    default_config jsonb DEFAULT '{}'::jsonb,
    lti_config jsonb,
    canvas_api_permissions jsonb DEFAULT '{}'::jsonb,
    subdomain character varying,
    key character varying,
    oauth_precedence character varying DEFAULT 'global,user,application_instance,course'::character varying,
    anonymous boolean DEFAULT false,
    free_trial_period integer DEFAULT 31,
    lti_advantage_config jsonb DEFAULT '{}'::jsonb,
    rollbar_enabled boolean DEFAULT true,
    oauth_scopes character varying[] DEFAULT '{}'::character varying[],
    oauth_key character varying,
    oauth_secret character varying
);


--
-- Name: applications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.applications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: applications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.applications_id_seq OWNED BY public.applications.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: assignment_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assignment_users (
    id bigint NOT NULL,
    user_id bigint,
    assignment_id bigint,
    submitted boolean DEFAULT false,
    redirect_url character varying,
    lis_result_sourcedid character varying,
    lis_outcome_service_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    need_grading boolean,
    ext_outcome_data_values_accepted character varying,
    ext_outcome_result_total_score_accepted boolean,
    ext_lti_assignment_id character varying,
    token character varying,
    submitted_to_lms_at timestamp without time zone
);


--
-- Name: assignment_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.assignment_users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assignment_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.assignment_users_id_seq OWNED BY public.assignment_users.id;


--
-- Name: assignments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.assignments (
    id bigint NOT NULL,
    reference_id character varying,
    resource_id character varying,
    resource_title character varying,
    config text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    lms_assignment_id character varying,
    available_from timestamp without time zone,
    available_until timestamp without time zone,
    lms_course_id character varying,
    resource_link_id character varying,
    is_submitted boolean DEFAULT false,
    published boolean DEFAULT false,
    embed_url character varying(2048),
    due_date timestamp without time zone,
    lms_assignment_override_id character varying,
    is_embedded boolean DEFAULT false,
    assigned_student_count integer,
    score_average double precision DEFAULT 0.0,
    is_deeply_linked boolean DEFAULT false NOT NULL,
    is_adaptive boolean DEFAULT false NOT NULL,
    ability_score_average double precision,
    deleted boolean DEFAULT false NOT NULL,
    line_item_id character varying,
    lti_deployment_id bigint
);


--
-- Name: assignments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.assignments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: assignments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.assignments_id_seq OWNED BY public.assignments.id;


--
-- Name: attempt_events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attempt_events (
    id bigint NOT NULL,
    attempt_id bigint,
    name character varying NOT NULL,
    kind character varying NOT NULL,
    data character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    question_ref character varying,
    item_ref character varying,
    response_id character varying,
    resolved_at timestamp without time zone,
    resolved_by_id bigint,
    user_id bigint
);


--
-- Name: attempt_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attempt_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attempt_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attempt_events_id_seq OWNED BY public.attempt_events.id;


--
-- Name: attempts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attempts (
    id bigint NOT NULL,
    completed boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    assignment_user_id bigint,
    session_id character varying,
    is_primary boolean DEFAULT false,
    completed_at timestamp without time zone,
    started boolean,
    started_at timestamp without time zone,
    paused_at timestamp without time zone,
    failed_at timestamp without time zone,
    failed_error text,
    reviewed_at timestamp without time zone,
    reference_ids character varying[],
    last_scored_at timestamp without time zone,
    decimal_score double precision,
    manual_score double precision,
    total_score double precision,
    total_max_score double precision,
    unscorable_at timestamp without time zone,
    lrn_score_job_id character varying,
    additional_time_started_at timestamp without time zone,
    ability_score double precision,
    graded boolean,
    last_attempted_at timestamp without time zone,
    time_limit_expires_at timestamp without time zone
);


--
-- Name: attempts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attempts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attempts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attempts_id_seq OWNED BY public.attempts.id;


--
-- Name: authentications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authentications (
    id bigint NOT NULL,
    user_id bigint,
    provider character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    uid character varying,
    provider_avatar character varying,
    username character varying,
    provider_url character varying(2048),
    encrypted_token character varying,
    encrypted_token_salt character varying,
    encrypted_token_iv character varying,
    encrypted_secret character varying,
    encrypted_secret_salt character varying,
    encrypted_secret_iv character varying,
    encrypted_refresh_token character varying,
    encrypted_refresh_token_salt character varying,
    encrypted_refresh_token_iv character varying,
    id_token character varying,
    lti_user_id character varying,
    application_instance_id bigint,
    canvas_course_id bigint
);


--
-- Name: authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.authentications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.authentications_id_seq OWNED BY public.authentications.id;


--
-- Name: bundle_instances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bundle_instances (
    id bigint NOT NULL,
    site_id bigint,
    bundle_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    entity_key character varying,
    id_token character varying
);


--
-- Name: bundle_instances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bundle_instances_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bundle_instances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bundle_instances_id_seq OWNED BY public.bundle_instances.id;


--
-- Name: bundles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bundles (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    key character varying,
    shared_tenant boolean DEFAULT false
);


--
-- Name: bundles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.bundles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bundles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.bundles_id_seq OWNED BY public.bundles.id;


--
-- Name: canvas_content_export_conversion_errors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canvas_content_export_conversion_errors (
    id bigint NOT NULL,
    error_type character varying,
    message character varying,
    question_index integer,
    canvas_quiz_id bigint,
    question_type character varying,
    canvas_content_export_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    qti_item_id character varying
);


--
-- Name: canvas_content_export_conversion_errors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.canvas_content_export_conversion_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: canvas_content_export_conversion_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.canvas_content_export_conversion_errors_id_seq OWNED BY public.canvas_content_export_conversion_errors.id;


--
-- Name: canvas_content_exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canvas_content_exports (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    guid character varying,
    error_message character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    tags jsonb
);


--
-- Name: canvas_content_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.canvas_content_exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: canvas_content_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.canvas_content_exports_id_seq OWNED BY public.canvas_content_exports.id;


--
-- Name: canvas_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canvas_courses (
    id bigint NOT NULL,
    lms_course_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    custom_css text,
    export_copy_type character varying DEFAULT 'copy'::character varying NOT NULL,
    import_strategy character varying DEFAULT 'import_all_content'::character varying NOT NULL,
    enable_authoring_at timestamp without time zone,
    author_setting_user_id character varying,
    author_setting text DEFAULT 'global'::text
);


--
-- Name: canvas_courses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.canvas_courses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: canvas_courses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.canvas_courses_id_seq OWNED BY public.canvas_courses.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.clients (
    id bigint NOT NULL,
    name character varying,
    subdomain character varying,
    domain character varying,
    lms_domain character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.clients_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.clients_id_seq OWNED BY public.clients.id;


--
-- Name: course_notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_notifications (
    id bigint NOT NULL,
    message character varying NOT NULL,
    context_id character varying NOT NULL,
    acknowledged boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: course_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_notifications_id_seq OWNED BY public.course_notifications.id;


--
-- Name: course_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.course_users (
    id bigint NOT NULL,
    section_ids bigint[],
    lms_user_id character varying,
    lms_course_id bigint,
    context_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: course_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.course_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: course_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.course_users_id_seq OWNED BY public.course_users.id;


--
-- Name: find_tagged_items_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.find_tagged_items_statuses (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    error_message character varying,
    error_trace text,
    assignment_id bigint,
    context_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: find_tagged_items_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.find_tagged_items_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: find_tagged_items_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.find_tagged_items_statuses_id_seq OWNED BY public.find_tagged_items_statuses.id;


--
-- Name: ims_exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ims_exports (
    id integer NOT NULL,
    token character varying,
    tool_consumer_instance_guid character varying,
    context_id character varying,
    custom_canvas_course_id character varying,
    payload jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    status character varying DEFAULT 'processing'::character varying,
    message character varying(2048)
);


--
-- Name: ims_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ims_exports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ims_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ims_exports_id_seq OWNED BY public.ims_exports.id;


--
-- Name: ims_import_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ims_import_statuses (
    id bigint NOT NULL,
    ims_import_id bigint NOT NULL,
    kind character varying NOT NULL,
    status character varying DEFAULT 'initialized'::character varying NOT NULL,
    error_message character varying,
    error_trace text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    info text
);


--
-- Name: ims_import_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ims_import_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ims_import_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ims_import_statuses_id_seq OWNED BY public.ims_import_statuses.id;


--
-- Name: ims_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ims_imports (
    id bigint NOT NULL,
    create_launches_status character varying DEFAULT 'initialized'::character varying NOT NULL,
    error_message character varying,
    error_trace text,
    export_token character varying,
    context_id character varying NOT NULL,
    tci_guid character varying NOT NULL,
    lms_course_id character varying NOT NULL,
    source_context_id character varying NOT NULL,
    source_tci_guid character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    create_activities_status character varying DEFAULT 'finished'::character varying NOT NULL,
    update_activities_status character varying DEFAULT 'finished'::character varying NOT NULL,
    create_items_status character varying DEFAULT 'finished'::character varying NOT NULL,
    update_items_status character varying DEFAULT 'finished'::character varying NOT NULL,
    payload jsonb,
    acknowledged boolean DEFAULT false NOT NULL,
    course_workflow_state character varying DEFAULT 'active'::character varying NOT NULL
);


--
-- Name: ims_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.ims_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ims_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.ims_imports_id_seq OWNED BY public.ims_imports.id;


--
-- Name: job_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_statuses (
    id bigint NOT NULL,
    kind character varying NOT NULL,
    key character varying NOT NULL,
    status character varying DEFAULT 'initialized'::character varying NOT NULL,
    data jsonb DEFAULT '{}'::jsonb NOT NULL,
    error_message character varying,
    error_trace character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: job_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.job_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: job_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.job_statuses_id_seq OWNED BY public.job_statuses.id;


--
-- Name: jwks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jwks (
    id bigint NOT NULL,
    kid character varying,
    pem character varying,
    application_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: jwks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jwks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jwks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jwks_id_seq OWNED BY public.jwks.id;


--
-- Name: leads; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.leads (
    id bigint NOT NULL,
    user_id bigint,
    site_id bigint,
    email character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: leads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.leads_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: leads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.leads_id_seq OWNED BY public.leads.id;


--
-- Name: learnosity_authentications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.learnosity_authentications (
    id bigint NOT NULL,
    application_instance_id bigint,
    learnosity_key character varying,
    learnosity_secret character varying,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    region character varying
);


--
-- Name: learnosity_authentications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.learnosity_authentications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: learnosity_authentications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.learnosity_authentications_id_seq OWNED BY public.learnosity_authentications.id;


--
-- Name: learnosity_exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.learnosity_exports (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    temp_file_path character varying,
    guid character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    error_message character varying,
    error_trace text
);


--
-- Name: learnosity_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.learnosity_exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: learnosity_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.learnosity_exports_id_seq OWNED BY public.learnosity_exports.id;


--
-- Name: learnosity_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.learnosity_imports (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    temp_file_path character varying,
    guid character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    error_message character varying,
    error_trace text
);


--
-- Name: learnosity_imports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.learnosity_imports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: learnosity_imports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.learnosity_imports_id_seq OWNED BY public.learnosity_imports.id;


--
-- Name: lti_deployments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lti_deployments (
    id bigint NOT NULL,
    application_instance_id bigint,
    deployment_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    lti_install_id bigint
);


--
-- Name: lti_deployments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lti_deployments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lti_deployments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lti_deployments_id_seq OWNED BY public.lti_deployments.id;


--
-- Name: lti_installs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lti_installs (
    id bigint NOT NULL,
    iss character varying,
    application_id bigint,
    client_id character varying,
    jwks_url character varying,
    token_url character varying,
    oidc_url character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    registration_client_uri character varying
);


--
-- Name: lti_installs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lti_installs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lti_installs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lti_installs_id_seq OWNED BY public.lti_installs.id;


--
-- Name: lti_launches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lti_launches (
    id bigint NOT NULL,
    config jsonb,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    token character varying,
    context_id character varying,
    tool_consumer_instance_guid character varying,
    assignment_id bigint,
    resource_link_id character varying
);


--
-- Name: lti_launches_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lti_launches_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lti_launches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lti_launches_id_seq OWNED BY public.lti_launches.id;


--
-- Name: lti_tools; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.lti_tools (
    id bigint NOT NULL,
    name character varying,
    icon character varying,
    url character varying,
    encrypted_lti_key character varying,
    encrypted_lti_key_salt character varying,
    encrypted_lti_key_iv character varying,
    encrypted_lti_secret character varying,
    encrypted_lti_secret_salt character varying,
    encrypted_lti_secret_iv character varying,
    kind integer DEFAULT 0,
    application_instance_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    no_response_auth_required boolean DEFAULT false
);


--
-- Name: lti_tools_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lti_tools_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: lti_tools_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lti_tools_id_seq OWNED BY public.lti_tools.id;


--
-- Name: nonces; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.nonces (
    id bigint NOT NULL,
    nonce character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: nonces_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.nonces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: nonces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.nonces_id_seq OWNED BY public.nonces.id;


--
-- Name: oauth_states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.oauth_states (
    id bigint NOT NULL,
    state character varying,
    payload text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: oauth_states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.oauth_states_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: oauth_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.oauth_states_id_seq OWNED BY public.oauth_states.id;


--
-- Name: onboard_job_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.onboard_job_statuses (
    id bigint NOT NULL,
    learnosity_key character varying NOT NULL,
    status character varying DEFAULT 'started'::character varying,
    started_at timestamp without time zone,
    error character varying,
    backtrace character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: onboard_job_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.onboard_job_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: onboard_job_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.onboard_job_statuses_id_seq OWNED BY public.onboard_job_statuses.id;


--
-- Name: open_id_states; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.open_id_states (
    id bigint NOT NULL,
    nonce character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: open_id_states_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.open_id_states_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: open_id_states_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.open_id_states_id_seq OWNED BY public.open_id_states.id;


--
-- Name: overrides; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.overrides (
    id bigint NOT NULL,
    time_limit integer,
    allowed_attempts integer DEFAULT 1,
    lms_id bigint,
    assignment_id bigint,
    student_ids character varying[],
    course_section_id bigint,
    due_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    unlock_at timestamp without time zone,
    lock_at timestamp without time zone,
    lock_job_id bigint,
    lock_job_run_at timestamp with time zone
);


--
-- Name: overrides_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.overrides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: overrides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.overrides_id_seq OWNED BY public.overrides.id;


--
-- Name: parent_contexts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parent_contexts (
    id bigint NOT NULL,
    lms_course_id bigint,
    parent_context_id character varying NOT NULL,
    parent_tool_consumer_instance_guid character varying NOT NULL,
    context_id character varying NOT NULL,
    tool_consumer_instance_guid character varying NOT NULL,
    is_readonly boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT parent_contexts_not_self_ref CHECK (((parent_context_id)::text <> (context_id)::text))
);


--
-- Name: parent_contexts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.parent_contexts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: parent_contexts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.parent_contexts_id_seq OWNED BY public.parent_contexts.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.permissions (
    id bigint NOT NULL,
    role_id bigint,
    user_id bigint,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    context_id character varying
);


--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.permissions_id_seq OWNED BY public.permissions.id;


--
-- Name: proctor_presets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.proctor_presets (
    id bigint NOT NULL,
    name character varying NOT NULL,
    lms_course_id character varying,
    context_id character varying,
    proctoring_tool character varying,
    proctor_settings jsonb,
    preset_type character varying DEFAULT 'CUSTOM'::character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    application_instance_id bigint
);


--
-- Name: proctor_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.proctor_presets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: proctor_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.proctor_presets_id_seq OWNED BY public.proctor_presets.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    title character varying,
    description character varying,
    tag character varying,
    image_url character varying,
    color character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    client_id bigint
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: publish_assignment_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.publish_assignment_statuses (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    error_message character varying,
    error_trace text,
    assignment_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    job_id bigint
);


--
-- Name: publish_assignment_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.publish_assignment_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: publish_assignment_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.publish_assignment_statuses_id_seq OWNED BY public.publish_assignment_statuses.id;


--
-- Name: qti_import_conversion_errors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.qti_import_conversion_errors (
    id bigint NOT NULL,
    error_type character varying,
    message character varying,
    question_index integer,
    question_type character varying,
    qti_item_id character varying,
    learnosity_import_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: qti_import_conversion_errors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.qti_import_conversion_errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: qti_import_conversion_errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.qti_import_conversion_errors_id_seq OWNED BY public.qti_import_conversion_errors.id;


--
-- Name: que_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.que_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: que_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.que_jobs_id_seq OWNED BY public.que_jobs.id;


--
-- Name: que_lockers; Type: TABLE; Schema: public; Owner: -
--

CREATE UNLOGGED TABLE public.que_lockers (
    pid integer NOT NULL,
    worker_count integer NOT NULL,
    worker_priorities integer[] NOT NULL,
    ruby_pid integer NOT NULL,
    ruby_hostname text NOT NULL,
    queues text[] NOT NULL,
    listening boolean NOT NULL,
    job_schema_version integer DEFAULT 1,
    CONSTRAINT valid_queues CHECK (((array_ndims(queues) = 1) AND (array_length(queues, 1) IS NOT NULL))),
    CONSTRAINT valid_worker_priorities CHECK (((array_ndims(worker_priorities) = 1) AND (array_length(worker_priorities, 1) IS NOT NULL)))
);


--
-- Name: que_scheduler_audit; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.que_scheduler_audit (
    scheduler_job_id bigint NOT NULL,
    executed_at timestamp with time zone NOT NULL
);


--
-- Name: TABLE que_scheduler_audit; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE public.que_scheduler_audit IS '6';


--
-- Name: que_scheduler_audit_enqueued; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.que_scheduler_audit_enqueued (
    scheduler_job_id bigint NOT NULL,
    job_class character varying(255) NOT NULL,
    queue character varying(255),
    priority integer,
    args jsonb NOT NULL,
    job_id bigint,
    run_at timestamp with time zone
);


--
-- Name: que_values; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.que_values (
    key text NOT NULL,
    value jsonb DEFAULT '{}'::jsonb NOT NULL,
    CONSTRAINT valid_value CHECK ((jsonb_typeof(value) = 'object'::text))
)
WITH (fillfactor='90');


--
-- Name: request_statistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.request_statistics (
    truncated_time timestamp without time zone NOT NULL,
    tenant character varying NOT NULL,
    number_of_hits integer DEFAULT 1,
    number_of_lti_launches integer DEFAULT 0,
    number_of_errors integer DEFAULT 0
);


--
-- Name: request_user_statistics; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.request_user_statistics (
    truncated_time timestamp without time zone NOT NULL,
    tenant character varying NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: response_exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.response_exports (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    temp_file_path character varying,
    guid character varying,
    error_message character varying,
    error_trace text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: response_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.response_exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: response_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.response_exports_id_seq OWNED BY public.response_exports.id;


--
-- Name: response_score_overrides; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.response_score_overrides (
    id bigint NOT NULL,
    attempt_id bigint,
    score double precision,
    max_score double precision,
    response_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: response_score_overrides_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.response_score_overrides_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: response_score_overrides_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.response_score_overrides_id_seq OWNED BY public.response_score_overrides.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: score_assignment_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.score_assignment_statuses (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    error_message character varying,
    error_trace text,
    assignment_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: score_assignment_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.score_assignment_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: score_assignment_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.score_assignment_statuses_id_seq OWNED BY public.score_assignment_statuses.id;


--
-- Name: setting_presets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.setting_presets (
    id bigint NOT NULL,
    name character varying NOT NULL,
    lms_course_id character varying,
    context_id character varying,
    auto_submit boolean DEFAULT false,
    retake_amount integer DEFAULT 1,
    use_access_code boolean DEFAULT false,
    access_code character varying,
    show_answers character varying DEFAULT 'AFTER_SUBMISSION'::character varying,
    render_inline boolean DEFAULT true,
    shuffle_items boolean DEFAULT false,
    time_limit boolean DEFAULT false,
    limit_minutes integer,
    keep_score character varying DEFAULT 'LATEST'::character varying,
    assign_to_specific_students boolean DEFAULT false,
    show_time boolean,
    show_intro boolean,
    show_summary boolean DEFAULT true,
    hide_module_navigation boolean,
    random_question_count integer,
    high_stakes boolean DEFAULT false,
    skip_submit_confirmation boolean DEFAULT true,
    show_remaining_attempts boolean DEFAULT true,
    show_sample_answer boolean DEFAULT false,
    continue_after_correct boolean DEFAULT false,
    create_gradebook boolean DEFAULT true,
    show_manual_feedback_to_students boolean DEFAULT true,
    display_try_again boolean DEFAULT true,
    penalty_percent double precision DEFAULT 0.0,
    check_answer_enabled character varying DEFAULT 'ITEM'::character varying,
    use_penalty_type integer DEFAULT 0,
    check_answer_count integer DEFAULT 1,
    show_mercy boolean DEFAULT false NOT NULL,
    highlighting_timing integer DEFAULT 15,
    correct_answer_timing integer DEFAULT 7,
    correct_feedback_timing integer DEFAULT 15,
    general_feedback_timing integer DEFAULT 7,
    response_feedback_timing integer DEFAULT 15,
    sample_answer_timing integer DEFAULT 7,
    score_timing integer DEFAULT 15,
    teacher_feedback_timing integer DEFAULT 3,
    ip_filters character varying(1024),
    points_possible_timing integer DEFAULT 0 NOT NULL,
    enable_numbering boolean DEFAULT true NOT NULL,
    application_instance_id bigint,
    preset_type character varying DEFAULT 'CUSTOM'::character varying NOT NULL,
    auto_finish_after_close boolean DEFAULT false NOT NULL,
    enable_hints boolean DEFAULT true,
    wall_clock_timer boolean DEFAULT false,
    show_student_outcomes boolean DEFAULT false
);


--
-- Name: setting_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.setting_presets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: setting_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.setting_presets_id_seq OWNED BY public.setting_presets.id;


--
-- Name: settings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.settings (
    id bigint NOT NULL,
    assignment_id bigint,
    auto_submit boolean DEFAULT false,
    retake_amount integer DEFAULT 1,
    use_access_code boolean DEFAULT false,
    access_code character varying,
    show_answers character varying DEFAULT 'AFTER_SUBMISSION'::character varying,
    render_inline boolean DEFAULT true,
    shuffle_items boolean DEFAULT false,
    time_limit boolean DEFAULT false,
    limit_minutes integer,
    keep_score character varying DEFAULT 'LATEST'::character varying,
    assign_to_specific_students boolean DEFAULT false,
    show_time boolean,
    show_intro boolean,
    show_summary boolean DEFAULT true,
    hide_module_navigation boolean,
    random_question_count integer,
    high_stakes boolean DEFAULT false,
    skip_submit_confirmation boolean DEFAULT true,
    show_remaining_attempts boolean DEFAULT true,
    show_sample_answer boolean DEFAULT false,
    continue_after_correct boolean DEFAULT false,
    create_gradebook boolean DEFAULT true,
    show_manual_feedback_to_students boolean DEFAULT true,
    display_try_again boolean DEFAULT true,
    penalty_percent double precision DEFAULT 0.0,
    sample_on_tags boolean DEFAULT false,
    tags_to_sample jsonb,
    check_answer_enabled character varying DEFAULT 'ITEM'::character varying,
    use_penalty_type integer DEFAULT 0,
    check_answer_count integer DEFAULT 1,
    show_mercy boolean DEFAULT false NOT NULL,
    highlighting_timing integer DEFAULT 15,
    correct_answer_timing integer DEFAULT 7,
    correct_feedback_timing integer DEFAULT 15,
    general_feedback_timing integer DEFAULT 7,
    response_feedback_timing integer DEFAULT 15,
    sample_answer_timing integer DEFAULT 7,
    score_timing integer DEFAULT 15,
    teacher_feedback_timing integer DEFAULT 3,
    ip_filters character varying(1024),
    points_possible_timing integer DEFAULT 0 NOT NULL,
    enable_numbering boolean DEFAULT true NOT NULL,
    auto_finish_after_close boolean DEFAULT false NOT NULL,
    proctoring_tool character varying,
    proctor_settings jsonb DEFAULT '{}'::jsonb,
    enable_hints boolean DEFAULT true,
    wall_clock_timer boolean DEFAULT false,
    show_student_outcomes boolean DEFAULT false
);


--
-- Name: settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.settings_id_seq OWNED BY public.settings.id;


--
-- Name: site_urls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.site_urls (
    id bigint NOT NULL,
    site_id bigint,
    url character varying NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: site_urls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.site_urls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: site_urls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.site_urls_id_seq OWNED BY public.site_urls.id;


--
-- Name: sites; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sites (
    id bigint NOT NULL,
    url character varying(2048),
    oauth_key character varying,
    oauth_secret character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    secret character varying
);


--
-- Name: sites_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.sites_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.sites_id_seq OWNED BY public.sites.id;


--
-- Name: submit_all_attempts_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.submit_all_attempts_statuses (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    error_message character varying,
    error_trace text,
    assignment_id bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: submit_all_attempts_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submit_all_attempts_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submit_all_attempts_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submit_all_attempts_statuses_id_seq OWNED BY public.submit_all_attempts_statuses.id;


--
-- Name: summary_exports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.summary_exports (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    temp_file_path character varying,
    guid character varying,
    error_message character varying,
    error_trace text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: summary_exports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.summary_exports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: summary_exports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.summary_exports_id_seq OWNED BY public.summary_exports.id;


--
-- Name: tag_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tag_types (
    id bigint NOT NULL,
    lms_course_id bigint NOT NULL,
    name character varying NOT NULL,
    context_id text NOT NULL
);


--
-- Name: tag_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tag_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tag_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tag_types_id_seq OWNED BY public.tag_types.id;


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tags (
    id bigint NOT NULL,
    tag_type_id bigint NOT NULL,
    name character varying NOT NULL
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tags_id_seq OWNED BY public.tags.id;


--
-- Name: update_and_publish_score_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.update_and_publish_score_statuses (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    error_message character varying,
    error_trace text,
    assignment_user_id bigint,
    context_id character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    publish_assignment_status_id bigint,
    job_id bigint
);


--
-- Name: update_and_publish_score_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.update_and_publish_score_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: update_and_publish_score_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.update_and_publish_score_statuses_id_seq OWNED BY public.update_and_publish_score_statuses.id;


--
-- Name: update_scores_job_statuses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.update_scores_job_statuses (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying,
    error_message character varying,
    error_trace text,
    attempt_id bigint,
    context_id character varying,
    job_reference character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    job_id bigint
);


--
-- Name: update_scores_job_statuses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.update_scores_job_statuses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: update_scores_job_statuses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.update_scores_job_statuses_id_seq OWNED BY public.update_scores_job_statuses.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count bigint DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    name character varying,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    password_salt character varying,
    lti_user_id character varying,
    lti_provider character varying,
    lms_user_id character varying,
    create_method bigint DEFAULT 0,
    invitation_token character varying,
    invitation_created_at timestamp without time zone,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id bigint,
    invitations_count integer DEFAULT 0,
    sis_id character varying,
    legacy_lti_user_id character varying,
    encrypted_otp_secret character varying,
    encrypted_otp_secret_iv character varying,
    encrypted_otp_secret_salt character varying,
    consumed_timestep integer,
    otp_required_for_login boolean,
    otp_backup_codes character varying[]
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: accommodations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accommodations ALTER COLUMN id SET DEFAULT nextval('public.accommodations_id_seq'::regclass);


--
-- Name: active_storage_attachments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments ALTER COLUMN id SET DEFAULT nextval('public.active_storage_attachments_id_seq'::regclass);


--
-- Name: active_storage_blobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs ALTER COLUMN id SET DEFAULT nextval('public.active_storage_blobs_id_seq'::regclass);


--
-- Name: active_storage_variant_records id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records ALTER COLUMN id SET DEFAULT nextval('public.active_storage_variant_records_id_seq'::regclass);


--
-- Name: api_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens ALTER COLUMN id SET DEFAULT nextval('public.api_tokens_id_seq'::regclass);


--
-- Name: application_bundles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_bundles ALTER COLUMN id SET DEFAULT nextval('public.application_bundles_id_seq'::regclass);


--
-- Name: application_instances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_instances ALTER COLUMN id SET DEFAULT nextval('public.application_instances_id_seq'::regclass);


--
-- Name: applications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications ALTER COLUMN id SET DEFAULT nextval('public.applications_id_seq'::regclass);


--
-- Name: assignment_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignment_users ALTER COLUMN id SET DEFAULT nextval('public.assignment_users_id_seq'::regclass);


--
-- Name: assignments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignments ALTER COLUMN id SET DEFAULT nextval('public.assignments_id_seq'::regclass);


--
-- Name: attempt_events id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempt_events ALTER COLUMN id SET DEFAULT nextval('public.attempt_events_id_seq'::regclass);


--
-- Name: attempts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts ALTER COLUMN id SET DEFAULT nextval('public.attempts_id_seq'::regclass);


--
-- Name: authentications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentications ALTER COLUMN id SET DEFAULT nextval('public.authentications_id_seq'::regclass);


--
-- Name: bundle_instances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundle_instances ALTER COLUMN id SET DEFAULT nextval('public.bundle_instances_id_seq'::regclass);


--
-- Name: bundles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundles ALTER COLUMN id SET DEFAULT nextval('public.bundles_id_seq'::regclass);


--
-- Name: canvas_content_export_conversion_errors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_content_export_conversion_errors ALTER COLUMN id SET DEFAULT nextval('public.canvas_content_export_conversion_errors_id_seq'::regclass);


--
-- Name: canvas_content_exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_content_exports ALTER COLUMN id SET DEFAULT nextval('public.canvas_content_exports_id_seq'::regclass);


--
-- Name: canvas_courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_courses ALTER COLUMN id SET DEFAULT nextval('public.canvas_courses_id_seq'::regclass);


--
-- Name: clients id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients ALTER COLUMN id SET DEFAULT nextval('public.clients_id_seq'::regclass);


--
-- Name: course_notifications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_notifications ALTER COLUMN id SET DEFAULT nextval('public.course_notifications_id_seq'::regclass);


--
-- Name: course_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_users ALTER COLUMN id SET DEFAULT nextval('public.course_users_id_seq'::regclass);


--
-- Name: find_tagged_items_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.find_tagged_items_statuses ALTER COLUMN id SET DEFAULT nextval('public.find_tagged_items_statuses_id_seq'::regclass);


--
-- Name: ims_exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_exports ALTER COLUMN id SET DEFAULT nextval('public.ims_exports_id_seq'::regclass);


--
-- Name: ims_import_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_import_statuses ALTER COLUMN id SET DEFAULT nextval('public.ims_import_statuses_id_seq'::regclass);


--
-- Name: ims_imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_imports ALTER COLUMN id SET DEFAULT nextval('public.ims_imports_id_seq'::regclass);


--
-- Name: job_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_statuses ALTER COLUMN id SET DEFAULT nextval('public.job_statuses_id_seq'::regclass);


--
-- Name: jwks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jwks ALTER COLUMN id SET DEFAULT nextval('public.jwks_id_seq'::regclass);


--
-- Name: leads id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads ALTER COLUMN id SET DEFAULT nextval('public.leads_id_seq'::regclass);


--
-- Name: learnosity_authentications id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.learnosity_authentications ALTER COLUMN id SET DEFAULT nextval('public.learnosity_authentications_id_seq'::regclass);


--
-- Name: learnosity_exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.learnosity_exports ALTER COLUMN id SET DEFAULT nextval('public.learnosity_exports_id_seq'::regclass);


--
-- Name: learnosity_imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.learnosity_imports ALTER COLUMN id SET DEFAULT nextval('public.learnosity_imports_id_seq'::regclass);


--
-- Name: lti_deployments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_deployments ALTER COLUMN id SET DEFAULT nextval('public.lti_deployments_id_seq'::regclass);


--
-- Name: lti_installs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_installs ALTER COLUMN id SET DEFAULT nextval('public.lti_installs_id_seq'::regclass);


--
-- Name: lti_launches id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_launches ALTER COLUMN id SET DEFAULT nextval('public.lti_launches_id_seq'::regclass);


--
-- Name: lti_tools id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_tools ALTER COLUMN id SET DEFAULT nextval('public.lti_tools_id_seq'::regclass);


--
-- Name: nonces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nonces ALTER COLUMN id SET DEFAULT nextval('public.nonces_id_seq'::regclass);


--
-- Name: oauth_states id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states ALTER COLUMN id SET DEFAULT nextval('public.oauth_states_id_seq'::regclass);


--
-- Name: onboard_job_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.onboard_job_statuses ALTER COLUMN id SET DEFAULT nextval('public.onboard_job_statuses_id_seq'::regclass);


--
-- Name: open_id_states id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_id_states ALTER COLUMN id SET DEFAULT nextval('public.open_id_states_id_seq'::regclass);


--
-- Name: overrides id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overrides ALTER COLUMN id SET DEFAULT nextval('public.overrides_id_seq'::regclass);


--
-- Name: parent_contexts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parent_contexts ALTER COLUMN id SET DEFAULT nextval('public.parent_contexts_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: proctor_presets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proctor_presets ALTER COLUMN id SET DEFAULT nextval('public.proctor_presets_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Name: publish_assignment_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_assignment_statuses ALTER COLUMN id SET DEFAULT nextval('public.publish_assignment_statuses_id_seq'::regclass);


--
-- Name: qti_import_conversion_errors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.qti_import_conversion_errors ALTER COLUMN id SET DEFAULT nextval('public.qti_import_conversion_errors_id_seq'::regclass);


--
-- Name: que_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_jobs ALTER COLUMN id SET DEFAULT nextval('public.que_jobs_id_seq'::regclass);


--
-- Name: response_exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.response_exports ALTER COLUMN id SET DEFAULT nextval('public.response_exports_id_seq'::regclass);


--
-- Name: response_score_overrides id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.response_score_overrides ALTER COLUMN id SET DEFAULT nextval('public.response_score_overrides_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: score_assignment_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.score_assignment_statuses ALTER COLUMN id SET DEFAULT nextval('public.score_assignment_statuses_id_seq'::regclass);


--
-- Name: setting_presets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting_presets ALTER COLUMN id SET DEFAULT nextval('public.setting_presets_id_seq'::regclass);


--
-- Name: settings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings ALTER COLUMN id SET DEFAULT nextval('public.settings_id_seq'::regclass);


--
-- Name: site_urls id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_urls ALTER COLUMN id SET DEFAULT nextval('public.site_urls_id_seq'::regclass);


--
-- Name: sites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- Name: submit_all_attempts_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submit_all_attempts_statuses ALTER COLUMN id SET DEFAULT nextval('public.submit_all_attempts_statuses_id_seq'::regclass);


--
-- Name: summary_exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.summary_exports ALTER COLUMN id SET DEFAULT nextval('public.summary_exports_id_seq'::regclass);


--
-- Name: tag_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag_types ALTER COLUMN id SET DEFAULT nextval('public.tag_types_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags ALTER COLUMN id SET DEFAULT nextval('public.tags_id_seq'::regclass);


--
-- Name: update_and_publish_score_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.update_and_publish_score_statuses ALTER COLUMN id SET DEFAULT nextval('public.update_and_publish_score_statuses_id_seq'::regclass);


--
-- Name: update_scores_job_statuses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.update_scores_job_statuses ALTER COLUMN id SET DEFAULT nextval('public.update_scores_job_statuses_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: accommodations accommodations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.accommodations
    ADD CONSTRAINT accommodations_pkey PRIMARY KEY (id);


--
-- Name: active_storage_attachments active_storage_attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT active_storage_attachments_pkey PRIMARY KEY (id);


--
-- Name: active_storage_blobs active_storage_blobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_blobs
    ADD CONSTRAINT active_storage_blobs_pkey PRIMARY KEY (id);


--
-- Name: active_storage_variant_records active_storage_variant_records_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT active_storage_variant_records_pkey PRIMARY KEY (id);


--
-- Name: api_tokens api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_tokens_pkey PRIMARY KEY (id);


--
-- Name: application_bundles application_bundles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_bundles
    ADD CONSTRAINT application_bundles_pkey PRIMARY KEY (id);


--
-- Name: application_instances application_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.application_instances
    ADD CONSTRAINT application_instances_pkey PRIMARY KEY (id);


--
-- Name: applications applications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.applications
    ADD CONSTRAINT applications_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: assignment_users assignment_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignment_users
    ADD CONSTRAINT assignment_users_pkey PRIMARY KEY (id);


--
-- Name: assignments assignments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT assignments_pkey PRIMARY KEY (id);


--
-- Name: attempt_events attempt_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempt_events
    ADD CONSTRAINT attempt_events_pkey PRIMARY KEY (id);


--
-- Name: attempts attempts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attempts
    ADD CONSTRAINT attempts_pkey PRIMARY KEY (id);


--
-- Name: authentications authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authentications
    ADD CONSTRAINT authentications_pkey PRIMARY KEY (id);


--
-- Name: bundle_instances bundle_instances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundle_instances
    ADD CONSTRAINT bundle_instances_pkey PRIMARY KEY (id);


--
-- Name: bundles bundles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bundles
    ADD CONSTRAINT bundles_pkey PRIMARY KEY (id);


--
-- Name: canvas_content_export_conversion_errors canvas_content_export_conversion_errors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_content_export_conversion_errors
    ADD CONSTRAINT canvas_content_export_conversion_errors_pkey PRIMARY KEY (id);


--
-- Name: canvas_content_exports canvas_content_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_content_exports
    ADD CONSTRAINT canvas_content_exports_pkey PRIMARY KEY (id);


--
-- Name: canvas_courses canvas_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_courses
    ADD CONSTRAINT canvas_courses_pkey PRIMARY KEY (id);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: course_notifications course_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_notifications
    ADD CONSTRAINT course_notifications_pkey PRIMARY KEY (id);


--
-- Name: course_users course_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.course_users
    ADD CONSTRAINT course_users_pkey PRIMARY KEY (id);


--
-- Name: find_tagged_items_statuses find_tagged_items_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.find_tagged_items_statuses
    ADD CONSTRAINT find_tagged_items_statuses_pkey PRIMARY KEY (id);


--
-- Name: ims_exports ims_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_exports
    ADD CONSTRAINT ims_exports_pkey PRIMARY KEY (id);


--
-- Name: ims_import_statuses ims_import_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_import_statuses
    ADD CONSTRAINT ims_import_statuses_pkey PRIMARY KEY (id);


--
-- Name: ims_imports ims_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_imports
    ADD CONSTRAINT ims_imports_pkey PRIMARY KEY (id);


--
-- Name: job_statuses job_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_statuses
    ADD CONSTRAINT job_statuses_pkey PRIMARY KEY (id);


--
-- Name: jwks jwks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jwks
    ADD CONSTRAINT jwks_pkey PRIMARY KEY (id);


--
-- Name: leads leads_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.leads
    ADD CONSTRAINT leads_pkey PRIMARY KEY (id);


--
-- Name: learnosity_authentications learnosity_authentications_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.learnosity_authentications
    ADD CONSTRAINT learnosity_authentications_pkey PRIMARY KEY (id);


--
-- Name: learnosity_exports learnosity_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.learnosity_exports
    ADD CONSTRAINT learnosity_exports_pkey PRIMARY KEY (id);


--
-- Name: learnosity_imports learnosity_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.learnosity_imports
    ADD CONSTRAINT learnosity_imports_pkey PRIMARY KEY (id);


--
-- Name: lti_deployments lti_deployments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_deployments
    ADD CONSTRAINT lti_deployments_pkey PRIMARY KEY (id);


--
-- Name: lti_installs lti_installs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_installs
    ADD CONSTRAINT lti_installs_pkey PRIMARY KEY (id);


--
-- Name: lti_launches lti_launches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_launches
    ADD CONSTRAINT lti_launches_pkey PRIMARY KEY (id);


--
-- Name: lti_tools lti_tools_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_tools
    ADD CONSTRAINT lti_tools_pkey PRIMARY KEY (id);


--
-- Name: nonces nonces_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nonces
    ADD CONSTRAINT nonces_pkey PRIMARY KEY (id);


--
-- Name: oauth_states oauth_states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states
    ADD CONSTRAINT oauth_states_pkey PRIMARY KEY (id);


--
-- Name: onboard_job_statuses onboard_job_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.onboard_job_statuses
    ADD CONSTRAINT onboard_job_statuses_pkey PRIMARY KEY (id);


--
-- Name: open_id_states open_id_states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_id_states
    ADD CONSTRAINT open_id_states_pkey PRIMARY KEY (id);


--
-- Name: overrides overrides_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overrides
    ADD CONSTRAINT overrides_pkey PRIMARY KEY (id);


--
-- Name: parent_contexts parent_contexts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parent_contexts
    ADD CONSTRAINT parent_contexts_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: proctor_presets proctor_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.proctor_presets
    ADD CONSTRAINT proctor_presets_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: publish_assignment_statuses publish_assignment_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_assignment_statuses
    ADD CONSTRAINT publish_assignment_statuses_pkey PRIMARY KEY (id);


--
-- Name: qti_import_conversion_errors qti_import_conversion_errors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.qti_import_conversion_errors
    ADD CONSTRAINT qti_import_conversion_errors_pkey PRIMARY KEY (id);


--
-- Name: que_jobs que_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_jobs
    ADD CONSTRAINT que_jobs_pkey PRIMARY KEY (id);


--
-- Name: que_lockers que_lockers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_lockers
    ADD CONSTRAINT que_lockers_pkey PRIMARY KEY (pid);


--
-- Name: que_scheduler_audit que_scheduler_audit_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_scheduler_audit
    ADD CONSTRAINT que_scheduler_audit_pkey PRIMARY KEY (scheduler_job_id);


--
-- Name: que_values que_values_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_values
    ADD CONSTRAINT que_values_pkey PRIMARY KEY (key);


--
-- Name: request_statistics request_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_statistics
    ADD CONSTRAINT request_statistics_pkey PRIMARY KEY (truncated_time, tenant);


--
-- Name: request_user_statistics request_user_statistics_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.request_user_statistics
    ADD CONSTRAINT request_user_statistics_pkey PRIMARY KEY (truncated_time, tenant, user_id);


--
-- Name: response_exports response_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.response_exports
    ADD CONSTRAINT response_exports_pkey PRIMARY KEY (id);


--
-- Name: response_score_overrides response_score_overrides_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.response_score_overrides
    ADD CONSTRAINT response_score_overrides_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: score_assignment_statuses score_assignment_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.score_assignment_statuses
    ADD CONSTRAINT score_assignment_statuses_pkey PRIMARY KEY (id);


--
-- Name: setting_presets setting_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.setting_presets
    ADD CONSTRAINT setting_presets_pkey PRIMARY KEY (id);


--
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- Name: site_urls site_urls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.site_urls
    ADD CONSTRAINT site_urls_pkey PRIMARY KEY (id);


--
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: submit_all_attempts_statuses submit_all_attempts_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submit_all_attempts_statuses
    ADD CONSTRAINT submit_all_attempts_statuses_pkey PRIMARY KEY (id);


--
-- Name: summary_exports summary_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.summary_exports
    ADD CONSTRAINT summary_exports_pkey PRIMARY KEY (id);


--
-- Name: tag_types tag_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tag_types
    ADD CONSTRAINT tag_types_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: update_and_publish_score_statuses update_and_publish_score_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.update_and_publish_score_statuses
    ADD CONSTRAINT update_and_publish_score_statuses_pkey PRIMARY KEY (id);


--
-- Name: update_scores_job_statuses update_scores_job_statuses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.update_scores_job_statuses
    ADD CONSTRAINT update_scores_job_statuses_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: canvas_content_export_conversion_errors_question_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX canvas_content_export_conversion_errors_question_uniq ON public.canvas_content_export_conversion_errors USING btree (canvas_content_export_id, canvas_quiz_id, question_index);


--
-- Name: index_active_storage_attachments_on_blob_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_active_storage_attachments_on_blob_id ON public.active_storage_attachments USING btree (blob_id);


--
-- Name: index_active_storage_attachments_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_attachments_uniqueness ON public.active_storage_attachments USING btree (record_type, record_id, name, blob_id);


--
-- Name: index_active_storage_blobs_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_blobs_on_key ON public.active_storage_blobs USING btree (key);


--
-- Name: index_active_storage_variant_records_uniqueness; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_active_storage_variant_records_uniqueness ON public.active_storage_variant_records USING btree (blob_id, variation_digest);


--
-- Name: index_api_tokens_on_application_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_api_tokens_on_application_instance_id ON public.api_tokens USING btree (application_instance_id);


--
-- Name: index_api_tokens_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_api_tokens_on_key ON public.api_tokens USING btree (key);


--
-- Name: index_api_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_api_tokens_on_user_id ON public.api_tokens USING btree (user_id);


--
-- Name: index_application_bundles_on_application_id_and_bundle_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_bundles_on_application_id_and_bundle_id ON public.application_bundles USING btree (application_id, bundle_id);


--
-- Name: index_application_instances_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_instances_on_application_id ON public.application_instances USING btree (application_id);


--
-- Name: index_application_instances_on_lti_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_instances_on_lti_key ON public.application_instances USING btree (lti_key);


--
-- Name: index_application_instances_on_site_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_application_instances_on_site_id ON public.application_instances USING btree (site_id);


--
-- Name: index_applications_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_applications_on_key ON public.applications USING btree (key);


--
-- Name: index_assignment_users_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assignment_users_on_assignment_id ON public.assignment_users USING btree (assignment_id);


--
-- Name: index_assignment_users_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_assignment_users_on_token ON public.assignment_users USING btree (token);


--
-- Name: index_assignment_users_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assignment_users_on_user_id ON public.assignment_users USING btree (user_id);


--
-- Name: index_assignments_on_lms_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assignments_on_lms_course_id ON public.assignments USING btree (lms_course_id);


--
-- Name: index_assignments_on_resource_link_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_assignments_on_resource_link_id ON public.assignments USING btree (resource_link_id);


--
-- Name: index_attempt_events_on_attempt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempt_events_on_attempt_id ON public.attempt_events USING btree (attempt_id);


--
-- Name: index_attempts_on_assignment_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_on_assignment_user_id ON public.attempts USING btree (assignment_user_id);


--
-- Name: index_attempts_on_completed_and_time_limit_expires_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_attempts_on_completed_and_time_limit_expires_at ON public.attempts USING btree (completed, time_limit_expires_at);


--
-- Name: index_authentications_on_lti_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_lti_user_id ON public.authentications USING btree (lti_user_id);


--
-- Name: index_authentications_on_provider_and_uid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_provider_and_uid ON public.authentications USING btree (provider, uid);


--
-- Name: index_authentications_on_uid_and_provider_and_provider_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_uid_and_provider_and_provider_url ON public.authentications USING btree (uid, provider, provider_url);


--
-- Name: index_authentications_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authentications_on_user_id ON public.authentications USING btree (user_id);


--
-- Name: index_bundle_instances_on_id_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bundle_instances_on_id_token ON public.bundle_instances USING btree (id_token);


--
-- Name: index_bundles_on_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_bundles_on_key ON public.bundles USING btree (key);


--
-- Name: index_canvas_content_export_conversion_errors_export_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_canvas_content_export_conversion_errors_export_id ON public.canvas_content_export_conversion_errors USING btree (canvas_content_export_id);


--
-- Name: index_canvas_courses_on_lms_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_canvas_courses_on_lms_course_id ON public.canvas_courses USING btree (lms_course_id);


--
-- Name: index_course_users_on_lms_course_id_and_lms_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_course_users_on_lms_course_id_and_lms_user_id ON public.course_users USING btree (lms_course_id, lms_user_id);


--
-- Name: index_find_tagged_items_statuses_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_find_tagged_items_statuses_on_assignment_id ON public.find_tagged_items_statuses USING btree (assignment_id);


--
-- Name: index_ims_exports_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ims_exports_on_token ON public.ims_exports USING btree (token);


--
-- Name: index_ims_import_statuses_on_ims_import_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ims_import_statuses_on_ims_import_id ON public.ims_import_statuses USING btree (ims_import_id);


--
-- Name: index_job_statuses_on_kind_and_key; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_job_statuses_on_kind_and_key ON public.job_statuses USING btree (kind, key);


--
-- Name: index_jwks_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jwks_on_application_id ON public.jwks USING btree (application_id);


--
-- Name: index_jwks_on_kid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jwks_on_kid ON public.jwks USING btree (kid);


--
-- Name: index_leads_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_leads_on_email ON public.leads USING btree (email);


--
-- Name: index_leads_on_site_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_leads_on_site_id ON public.leads USING btree (site_id);


--
-- Name: index_leads_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_leads_on_user_id ON public.leads USING btree (user_id);


--
-- Name: index_learnosity_exports_on_guid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_learnosity_exports_on_guid ON public.learnosity_exports USING btree (guid);


--
-- Name: index_learnosity_imports_on_guid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_learnosity_imports_on_guid ON public.learnosity_imports USING btree (guid);


--
-- Name: index_lti_deployments_on_application_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_deployments_on_application_instance_id ON public.lti_deployments USING btree (application_instance_id);


--
-- Name: index_lti_deployments_on_d_id_and_ai_id_and_li_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lti_deployments_on_d_id_and_ai_id_and_li_id ON public.lti_deployments USING btree (deployment_id, application_instance_id, lti_install_id);


--
-- Name: index_lti_deployments_on_deployment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_deployments_on_deployment_id ON public.lti_deployments USING btree (deployment_id);


--
-- Name: index_lti_deployments_on_lti_install_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_deployments_on_lti_install_id ON public.lti_deployments USING btree (lti_install_id);


--
-- Name: index_lti_installs_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_application_id ON public.lti_installs USING btree (application_id);


--
-- Name: index_lti_installs_on_application_id_and_iss; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_application_id_and_iss ON public.lti_installs USING btree (application_id, iss);


--
-- Name: index_lti_installs_on_client_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_client_id ON public.lti_installs USING btree (client_id);


--
-- Name: index_lti_installs_on_client_id_and_iss; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lti_installs_on_client_id_and_iss ON public.lti_installs USING btree (client_id, iss);


--
-- Name: index_lti_installs_on_iss; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_installs_on_iss ON public.lti_installs USING btree (iss);


--
-- Name: index_lti_launches_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_launches_on_assignment_id ON public.lti_launches USING btree (assignment_id);


--
-- Name: index_lti_launches_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_launches_on_context_id ON public.lti_launches USING btree (context_id);


--
-- Name: index_lti_launches_on_resource_link_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_launches_on_resource_link_id ON public.lti_launches USING btree (resource_link_id);


--
-- Name: index_lti_launches_on_token_and_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lti_launches_on_token_and_context_id ON public.lti_launches USING btree (token, context_id);


--
-- Name: index_lti_tools_on_application_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_tools_on_application_instance_id ON public.lti_tools USING btree (application_instance_id);


--
-- Name: index_nonces_on_nonce; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_nonces_on_nonce ON public.nonces USING btree (nonce);


--
-- Name: index_oauth_states_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_states_on_state ON public.oauth_states USING btree (state);


--
-- Name: index_onboard_job_statuses_on_learnosity_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_onboard_job_statuses_on_learnosity_key ON public.onboard_job_statuses USING btree (learnosity_key);


--
-- Name: index_open_id_states_on_nonce; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_open_id_states_on_nonce ON public.open_id_states USING btree (nonce);


--
-- Name: index_overrides_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_overrides_on_assignment_id ON public.overrides USING btree (assignment_id);


--
-- Name: index_permissions_on_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_permissions_on_context_id ON public.permissions USING btree (context_id);


--
-- Name: index_permissions_on_role_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_role_id_and_user_id ON public.permissions USING btree (role_id, user_id) WHERE (context_id IS NULL);


--
-- Name: index_permissions_on_role_id_and_user_id_and_context_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_permissions_on_role_id_and_user_id_and_context_id ON public.permissions USING btree (role_id, user_id, context_id);


--
-- Name: index_proctor_presets_on_application_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_proctor_presets_on_application_instance_id ON public.proctor_presets USING btree (application_instance_id);


--
-- Name: index_publish_assignment_statuses_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_publish_assignment_statuses_on_assignment_id ON public.publish_assignment_statuses USING btree (assignment_id);


--
-- Name: index_qti_import_conversion_errors_on_learnosity_import_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_qti_import_conversion_errors_on_learnosity_import_id ON public.qti_import_conversion_errors USING btree (learnosity_import_id);


--
-- Name: index_response_exports_on_guid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_response_exports_on_guid ON public.response_exports USING btree (guid);


--
-- Name: index_response_score_overrides_on_attempt_id_and_response_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_response_score_overrides_on_attempt_id_and_response_id ON public.response_score_overrides USING btree (attempt_id, response_id);


--
-- Name: index_score_assignment_statuses_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_score_assignment_statuses_on_assignment_id ON public.score_assignment_statuses USING btree (assignment_id);


--
-- Name: index_setting_presets_on_application_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_setting_presets_on_application_instance_id ON public.setting_presets USING btree (application_instance_id);


--
-- Name: index_settings_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_settings_on_assignment_id ON public.settings USING btree (assignment_id);


--
-- Name: index_sites_on_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sites_on_url ON public.sites USING btree (url);


--
-- Name: index_submit_all_attempts_statuses_on_assignment_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_submit_all_attempts_statuses_on_assignment_id ON public.submit_all_attempts_statuses USING btree (assignment_id);


--
-- Name: index_summary_exports_on_guid; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_summary_exports_on_guid ON public.summary_exports USING btree (guid);


--
-- Name: index_tag_types_on_context_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tag_types_on_context_id_and_name ON public.tag_types USING btree (context_id, name);


--
-- Name: index_tag_types_on_lms_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tag_types_on_lms_course_id ON public.tag_types USING btree (lms_course_id);


--
-- Name: index_tags_on_tag_type_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tags_on_tag_type_id_and_name ON public.tags USING btree (tag_type_id, name);


--
-- Name: index_update_and_publish_score_statuses_on_assignment_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_update_and_publish_score_statuses_on_assignment_user_id ON public.update_and_publish_score_statuses USING btree (assignment_user_id);


--
-- Name: index_update_scores_job_statuses_on_attempt_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_update_scores_job_statuses_on_attempt_id ON public.update_scores_job_statuses USING btree (attempt_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invitations_count; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invitations_count ON public.users USING btree (invitations_count);


--
-- Name: index_users_on_invited_by; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by ON public.users USING btree (invited_by_type, invited_by_id);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_legacy_lti_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_legacy_lti_user_id ON public.users USING btree (legacy_lti_user_id);


--
-- Name: index_users_on_lms_user_id_and_lti_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_lms_user_id_and_lti_user_id ON public.users USING btree (lms_user_id, lti_user_id);


--
-- Name: index_users_on_lti_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_lti_user_id ON public.users USING btree (lti_user_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: parent_contexts_context_parent_uniq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX parent_contexts_context_parent_uniq ON public.parent_contexts USING btree (parent_context_id, parent_tool_consumer_instance_guid, context_id, tool_consumer_instance_guid);


--
-- Name: que_jobs_args_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX que_jobs_args_gin_idx ON public.que_jobs USING gin (args jsonb_path_ops);


--
-- Name: que_jobs_data_gin_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX que_jobs_data_gin_idx ON public.que_jobs USING gin (data jsonb_path_ops);


--
-- Name: que_poll_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX que_poll_idx ON public.que_jobs USING btree (queue, priority, run_at, id) WHERE ((finished_at IS NULL) AND (expired_at IS NULL));


--
-- Name: que_poll_idx_with_job_schema_version; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX que_poll_idx_with_job_schema_version ON public.que_jobs USING btree (job_schema_version, queue, priority, run_at, id) WHERE ((finished_at IS NULL) AND (expired_at IS NULL));


--
-- Name: que_scheduler_audit_enqueued_args; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX que_scheduler_audit_enqueued_args ON public.que_scheduler_audit_enqueued USING btree (args);


--
-- Name: que_scheduler_audit_enqueued_job_class; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX que_scheduler_audit_enqueued_job_class ON public.que_scheduler_audit_enqueued USING btree (job_class);


--
-- Name: que_scheduler_audit_enqueued_job_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX que_scheduler_audit_enqueued_job_id ON public.que_scheduler_audit_enqueued USING btree (job_id);


--
-- Name: que_scheduler_job_in_que_jobs_unique_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX que_scheduler_job_in_que_jobs_unique_index ON public.que_jobs USING btree (job_class) WHERE (job_class = 'Que::Scheduler::SchedulerJob'::text);


--
-- Name: que_jobs que_job_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER que_job_notify AFTER INSERT ON public.que_jobs FOR EACH ROW EXECUTE FUNCTION public.que_job_notify();


--
-- Name: que_jobs que_scheduler_prevent_job_deletion_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE CONSTRAINT TRIGGER que_scheduler_prevent_job_deletion_trigger AFTER DELETE OR UPDATE ON public.que_jobs DEFERRABLE INITIALLY DEFERRED FOR EACH ROW EXECUTE FUNCTION public.que_scheduler_prevent_job_deletion();


--
-- Name: que_jobs que_state_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER que_state_notify AFTER INSERT OR DELETE OR UPDATE ON public.que_jobs FOR EACH ROW EXECUTE FUNCTION public.que_state_notify();


--
-- Name: assignments fk_assignments_lti_deployments; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.assignments
    ADD CONSTRAINT fk_assignments_lti_deployments FOREIGN KEY (lti_deployment_id) REFERENCES public.lti_deployments(id);


--
-- Name: tags fk_rails_08dd3a10dd; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT fk_rails_08dd3a10dd FOREIGN KEY (tag_type_id) REFERENCES public.tag_types(id) ON DELETE CASCADE;


--
-- Name: update_and_publish_score_statuses fk_rails_0db8ecbd4f; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.update_and_publish_score_statuses
    ADD CONSTRAINT fk_rails_0db8ecbd4f FOREIGN KEY (publish_assignment_status_id) REFERENCES public.publish_assignment_statuses(id) ON DELETE CASCADE;


--
-- Name: response_score_overrides fk_rails_0e485744e0; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.response_score_overrides
    ADD CONSTRAINT fk_rails_0e485744e0 FOREIGN KEY (attempt_id) REFERENCES public.attempts(id) ON DELETE CASCADE;


--
-- Name: submit_all_attempts_statuses fk_rails_52060d416a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submit_all_attempts_statuses
    ADD CONSTRAINT fk_rails_52060d416a FOREIGN KEY (assignment_id) REFERENCES public.assignments(id) ON DELETE CASCADE;


--
-- Name: qti_import_conversion_errors fk_rails_583772d8e5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.qti_import_conversion_errors
    ADD CONSTRAINT fk_rails_583772d8e5 FOREIGN KEY (learnosity_import_id) REFERENCES public.learnosity_imports(id) ON DELETE CASCADE;


--
-- Name: ims_import_statuses fk_rails_5deeb262e7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_import_statuses
    ADD CONSTRAINT fk_rails_5deeb262e7 FOREIGN KEY (ims_import_id) REFERENCES public.ims_imports(id) ON DELETE CASCADE;


--
-- Name: canvas_content_export_conversion_errors fk_rails_7f74435535; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_content_export_conversion_errors
    ADD CONSTRAINT fk_rails_7f74435535 FOREIGN KEY (canvas_content_export_id) REFERENCES public.canvas_content_exports(id) ON DELETE CASCADE;


--
-- Name: score_assignment_statuses fk_rails_7f96a22b41; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.score_assignment_statuses
    ADD CONSTRAINT fk_rails_7f96a22b41 FOREIGN KEY (assignment_id) REFERENCES public.assignments(id) ON DELETE CASCADE;


--
-- Name: publish_assignment_statuses fk_rails_93b78a617c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.publish_assignment_statuses
    ADD CONSTRAINT fk_rails_93b78a617c FOREIGN KEY (assignment_id) REFERENCES public.assignments(id) ON DELETE CASCADE;


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: overrides fk_rails_9ea8def08b; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.overrides
    ADD CONSTRAINT fk_rails_9ea8def08b FOREIGN KEY (assignment_id) REFERENCES public.assignments(id);


--
-- Name: update_and_publish_score_statuses fk_rails_ab99166d0c; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.update_and_publish_score_statuses
    ADD CONSTRAINT fk_rails_ab99166d0c FOREIGN KEY (assignment_user_id) REFERENCES public.assignment_users(id) ON DELETE CASCADE;


--
-- Name: update_scores_job_statuses fk_rails_c2b1188048; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.update_scores_job_statuses
    ADD CONSTRAINT fk_rails_c2b1188048 FOREIGN KEY (attempt_id) REFERENCES public.attempts(id) ON DELETE CASCADE;


--
-- Name: active_storage_attachments fk_rails_c3b3935057; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_attachments
    ADD CONSTRAINT fk_rails_c3b3935057 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


--
-- Name: lti_deployments fk_rails_d5b56eb24a; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lti_deployments
    ADD CONSTRAINT fk_rails_d5b56eb24a FOREIGN KEY (lti_install_id) REFERENCES public.lti_installs(id);


--
-- Name: find_tagged_items_statuses fk_rails_e20272d2d1; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.find_tagged_items_statuses
    ADD CONSTRAINT fk_rails_e20272d2d1 FOREIGN KEY (assignment_id) REFERENCES public.assignments(id) ON DELETE CASCADE;


--
-- Name: que_scheduler_audit_enqueued que_scheduler_audit_enqueued_scheduler_job_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_scheduler_audit_enqueued
    ADD CONSTRAINT que_scheduler_audit_enqueued_scheduler_job_id_fkey FOREIGN KEY (scheduler_job_id) REFERENCES public.que_scheduler_audit(scheduler_job_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20120209004849'),
('20161026230713'),
('20161027182508'),
('20170105051107'),
('20170111234331'),
('20170113211333'),
('20170114001933'),
('20170120234606'),
('20170125022543'),
('20170206172615'),
('20170309132554'),
('20170406181303'),
('20170419195150'),
('20170420011243'),
('20170420164409'),
('20170420222813'),
('20170420222855'),
('20170421220319'),
('20170428214611'),
('20170503011153'),
('20170523025529'),
('20170612172246'),
('20170613231518'),
('20170616160044'),
('20170621170109'),
('20170621211045'),
('20170623152036'),
('20170626201247'),
('20170626203903'),
('20170626221405'),
('20170627142629'),
('20170627214040'),
('20170627222359'),
('20170628193501'),
('20170629220739'),
('20170630061813'),
('20170630134054'),
('20170630170049'),
('20170630204733'),
('20170702205431'),
('20170705132718'),
('20170705190836'),
('20170705214532'),
('20170706192404'),
('20170710214130'),
('20170711175226'),
('20170711214648'),
('20170711215536'),
('20170717215050'),
('20170717224318'),
('20170718002121'),
('20170718015801'),
('20170718152700'),
('20170719021223'),
('20170731160737'),
('20170731200436'),
('20170802152411'),
('20170802225912'),
('20170807171059'),
('20170808145111'),
('20170808162633'),
('20170809165616'),
('20170810155349'),
('20170822222807'),
('20170825205534'),
('20170828223652'),
('20170915142046'),
('20170920214732'),
('20170921201330'),
('20170921202325'),
('20170926191503'),
('20170926200235'),
('20171003155408'),
('20171003181935'),
('20171004160616'),
('20171005190127'),
('20171006150200'),
('20171117203730'),
('20171202182406'),
('20171206054757'),
('20171206213343'),
('20171208002043'),
('20171219231941'),
('20171221212930'),
('20171222061659'),
('20171230212533'),
('20180102021519'),
('20180103193828'),
('20180112192746'),
('20180126222725'),
('20180201222026'),
('20180201235220'),
('20180209234904'),
('20180210000041'),
('20180214173330'),
('20180221033545'),
('20180222001133'),
('20180228170527'),
('20180306224135'),
('20180307231016'),
('20180316171218'),
('20180319182402'),
('20180402175229'),
('20180426214200'),
('20180508152147'),
('20180509151518'),
('20180510042729'),
('20180514141013'),
('20180516023654'),
('20180522201717'),
('20180523203418'),
('20180524014630'),
('20180606000638'),
('20180625163227'),
('20180711194512'),
('20180713155616'),
('20180716154917'),
('20180814160546'),
('20180814232905'),
('20180816183619'),
('20180817015306'),
('20180829182245'),
('20180905172346'),
('20180906022846'),
('20180910171738'),
('20180912013413'),
('20180916005751'),
('20180917210412'),
('20180918182237'),
('20180919171601'),
('20180925154650'),
('20180927173955'),
('20180928202230'),
('20181005022231'),
('20181008210328'),
('20181016213257'),
('20181025214226'),
('20181101174900'),
('20181105204441'),
('20181109155030'),
('20181109160508'),
('20181119181741'),
('20181121195703'),
('20181126215126'),
('20181127204956'),
('20181213194425'),
('20181215012806'),
('20181217224005'),
('20181221154626'),
('20181229171455'),
('20190131215126'),
('20190212234929'),
('20190219201006'),
('20190221190234'),
('20190225224639'),
('20190225230626'),
('20190306162917'),
('20190311184508'),
('20190312173237'),
('20190313033308'),
('20190313224833'),
('20190315201905'),
('20190319205918'),
('20190320012453'),
('20190320233646'),
('20190423223157'),
('20190426124528'),
('20190506225808'),
('20190509211458'),
('20190515212102'),
('20190517170314'),
('20190518190335'),
('20190523160910'),
('20190523205324'),
('20190528182949'),
('20190603162353'),
('20190607162408'),
('20190627223838'),
('20190627224209'),
('20190708174519'),
('20190718044615'),
('20190722231123'),
('20190725201716'),
('20190801201027'),
('20190802155245'),
('20190806150431'),
('20190826170643'),
('20190828184846'),
('20190911015015'),
('20191109215441'),
('20191126044547'),
('20191203001402'),
('20191203232259'),
('20191206230035'),
('20191209234708'),
('20200114211459'),
('20200123004429'),
('20200125223051'),
('20200127230659'),
('20200206215952'),
('20200217212540'),
('20200219210631'),
('20200226194920'),
('20200316224133'),
('20200317205433'),
('20200416005613'),
('20200508010237'),
('20200513202735'),
('20200520003148'),
('20200520155957'),
('20200617154813'),
('20200624153201'),
('20200803212243'),
('20200805232314'),
('20200812184007'),
('20200820210310'),
('20200828151856'),
('20200901222644'),
('20200903173409'),
('20200903213046'),
('20200904164607'),
('20200911050058'),
('20200914162257'),
('20200914195556'),
('20200915154048'),
('20200917205101'),
('20200921193634'),
('20200921225517'),
('20200922171432'),
('20200923144807'),
('20201001004844'),
('20201002174017'),
('20201005184717'),
('20201006041028'),
('20201007184432'),
('20201010033528'),
('20201013213623'),
('20201105185322'),
('20201116115701'),
('20201117170231'),
('20201118154826'),
('20201119141419'),
('20201119162541'),
('20201210170626'),
('20201222172253'),
('20210122151315'),
('20210210195029'),
('20210311155014'),
('20210414152648'),
('20210501034609'),
('20210506132721'),
('20210507213652'),
('20210510161432'),
('20210511143956'),
('20210713152544'),
('20210806192201'),
('20210806204435'),
('20210909142104'),
('20210928170802'),
('20211018160113'),
('20211021145303'),
('20211026172842'),
('20220106014956'),
('20220121162024'),
('20220121170405'),
('20220328234804'),
('20220329023856');


