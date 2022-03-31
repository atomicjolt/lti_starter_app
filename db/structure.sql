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

ALTER TABLE IF EXISTS ONLY public.lti_deployments DROP CONSTRAINT IF EXISTS fk_rails_d5b56eb24a;
ALTER TABLE IF EXISTS ONLY public.active_storage_attachments DROP CONSTRAINT IF EXISTS fk_rails_c3b3935057;
ALTER TABLE IF EXISTS ONLY public.active_storage_variant_records DROP CONSTRAINT IF EXISTS fk_rails_993965df05;
DROP TRIGGER IF EXISTS que_state_notify ON public.que_jobs;
DROP TRIGGER IF EXISTS que_job_notify ON public.que_jobs;
DROP INDEX IF EXISTS public.que_poll_idx_with_job_schema_version;
DROP INDEX IF EXISTS public.que_poll_idx;
DROP INDEX IF EXISTS public.que_jobs_data_gin_idx;
DROP INDEX IF EXISTS public.que_jobs_args_gin_idx;
DROP INDEX IF EXISTS public.index_users_on_reset_password_token;
DROP INDEX IF EXISTS public.index_users_on_lti_user_id;
DROP INDEX IF EXISTS public.index_users_on_lms_user_id_and_lti_user_id;
DROP INDEX IF EXISTS public.index_users_on_legacy_lti_user_id;
DROP INDEX IF EXISTS public.index_users_on_invited_by_id;
DROP INDEX IF EXISTS public.index_users_on_invited_by;
DROP INDEX IF EXISTS public.index_users_on_invitations_count;
DROP INDEX IF EXISTS public.index_users_on_invitation_token;
DROP INDEX IF EXISTS public.index_users_on_email;
DROP INDEX IF EXISTS public.index_sites_on_url;
DROP INDEX IF EXISTS public.index_permissions_on_role_id_and_user_id_and_context_id;
DROP INDEX IF EXISTS public.index_permissions_on_role_id_and_user_id;
DROP INDEX IF EXISTS public.index_permissions_on_context_id;
DROP INDEX IF EXISTS public.index_open_id_states_on_nonce;
DROP INDEX IF EXISTS public.index_oauth_states_on_state;
DROP INDEX IF EXISTS public.index_nonces_on_nonce;
DROP INDEX IF EXISTS public.index_lti_launches_on_token_and_context_id;
DROP INDEX IF EXISTS public.index_lti_launches_on_resource_link_id;
DROP INDEX IF EXISTS public.index_lti_launches_on_context_id;
DROP INDEX IF EXISTS public.index_lti_installs_on_iss;
DROP INDEX IF EXISTS public.index_lti_installs_on_client_id_and_iss;
DROP INDEX IF EXISTS public.index_lti_installs_on_client_id;
DROP INDEX IF EXISTS public.index_lti_installs_on_application_id_and_iss;
DROP INDEX IF EXISTS public.index_lti_installs_on_application_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_lti_install_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_deployment_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_d_id_and_ai_id;
DROP INDEX IF EXISTS public.index_lti_deployments_on_application_instance_id;
DROP INDEX IF EXISTS public.index_jwks_on_kid;
DROP INDEX IF EXISTS public.index_jwks_on_application_id;
DROP INDEX IF EXISTS public.index_ims_exports_on_token;
DROP INDEX IF EXISTS public.index_canvas_courses_on_lms_course_id;
DROP INDEX IF EXISTS public.index_bundles_on_key;
DROP INDEX IF EXISTS public.index_bundle_instances_on_id_token;
DROP INDEX IF EXISTS public.index_authentications_on_user_id;
DROP INDEX IF EXISTS public.index_authentications_on_uid_and_provider_and_provider_url;
DROP INDEX IF EXISTS public.index_authentications_on_provider_and_uid;
DROP INDEX IF EXISTS public.index_authentications_on_lti_user_id;
DROP INDEX IF EXISTS public.index_applications_on_key;
DROP INDEX IF EXISTS public.index_application_instances_on_site_id;
DROP INDEX IF EXISTS public.index_application_instances_on_lti_key;
DROP INDEX IF EXISTS public.index_application_instances_on_application_id;
DROP INDEX IF EXISTS public.index_application_bundles_on_application_id_and_bundle_id;
DROP INDEX IF EXISTS public.index_active_storage_variant_records_uniqueness;
DROP INDEX IF EXISTS public.index_active_storage_blobs_on_key;
DROP INDEX IF EXISTS public.index_active_storage_attachments_uniqueness;
DROP INDEX IF EXISTS public.index_active_storage_attachments_on_blob_id;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.sites DROP CONSTRAINT IF EXISTS sites_pkey;
ALTER TABLE IF EXISTS ONLY public.schema_migrations DROP CONSTRAINT IF EXISTS schema_migrations_pkey;
ALTER TABLE IF EXISTS ONLY public.roles DROP CONSTRAINT IF EXISTS roles_pkey;
ALTER TABLE IF EXISTS ONLY public.request_user_statistics DROP CONSTRAINT IF EXISTS request_user_statistics_pkey;
ALTER TABLE IF EXISTS ONLY public.request_statistics DROP CONSTRAINT IF EXISTS request_statistics_pkey;
ALTER TABLE IF EXISTS ONLY public.que_values DROP CONSTRAINT IF EXISTS que_values_pkey;
ALTER TABLE IF EXISTS ONLY public.que_lockers DROP CONSTRAINT IF EXISTS que_lockers_pkey;
ALTER TABLE IF EXISTS ONLY public.que_jobs DROP CONSTRAINT IF EXISTS que_jobs_pkey;
ALTER TABLE IF EXISTS ONLY public.permissions DROP CONSTRAINT IF EXISTS permissions_pkey;
ALTER TABLE IF EXISTS ONLY public.open_id_states DROP CONSTRAINT IF EXISTS open_id_states_pkey;
ALTER TABLE IF EXISTS ONLY public.oauth_states DROP CONSTRAINT IF EXISTS oauth_states_pkey;
ALTER TABLE IF EXISTS ONLY public.nonces DROP CONSTRAINT IF EXISTS nonces_pkey;
ALTER TABLE IF EXISTS ONLY public.lti_launches DROP CONSTRAINT IF EXISTS lti_launches_pkey;
ALTER TABLE IF EXISTS ONLY public.lti_installs DROP CONSTRAINT IF EXISTS lti_installs_pkey;
ALTER TABLE IF EXISTS ONLY public.lti_deployments DROP CONSTRAINT IF EXISTS lti_deployments_pkey;
ALTER TABLE IF EXISTS ONLY public.jwks DROP CONSTRAINT IF EXISTS jwks_pkey;
ALTER TABLE IF EXISTS ONLY public.ims_imports DROP CONSTRAINT IF EXISTS ims_imports_pkey;
ALTER TABLE IF EXISTS ONLY public.ims_exports DROP CONSTRAINT IF EXISTS ims_exports_pkey;
ALTER TABLE IF EXISTS ONLY public.canvas_courses DROP CONSTRAINT IF EXISTS canvas_courses_pkey;
ALTER TABLE IF EXISTS ONLY public.bundles DROP CONSTRAINT IF EXISTS bundles_pkey;
ALTER TABLE IF EXISTS ONLY public.bundle_instances DROP CONSTRAINT IF EXISTS bundle_instances_pkey;
ALTER TABLE IF EXISTS ONLY public.authentications DROP CONSTRAINT IF EXISTS authentications_pkey;
ALTER TABLE IF EXISTS ONLY public.ar_internal_metadata DROP CONSTRAINT IF EXISTS ar_internal_metadata_pkey;
ALTER TABLE IF EXISTS ONLY public.applications DROP CONSTRAINT IF EXISTS applications_pkey;
ALTER TABLE IF EXISTS ONLY public.application_instances DROP CONSTRAINT IF EXISTS application_instances_pkey;
ALTER TABLE IF EXISTS ONLY public.application_bundles DROP CONSTRAINT IF EXISTS application_bundles_pkey;
ALTER TABLE IF EXISTS ONLY public.active_storage_variant_records DROP CONSTRAINT IF EXISTS active_storage_variant_records_pkey;
ALTER TABLE IF EXISTS ONLY public.active_storage_blobs DROP CONSTRAINT IF EXISTS active_storage_blobs_pkey;
ALTER TABLE IF EXISTS ONLY public.active_storage_attachments DROP CONSTRAINT IF EXISTS active_storage_attachments_pkey;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sites ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.roles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.que_jobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.permissions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.open_id_states ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.oauth_states ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.nonces ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lti_launches ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lti_installs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.lti_deployments ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.jwks ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ims_imports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.ims_exports ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.canvas_courses ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bundles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.bundle_instances ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.authentications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.applications ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.application_instances ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.application_bundles ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.active_storage_variant_records ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.active_storage_blobs ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.active_storage_attachments ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.sites_id_seq;
DROP TABLE IF EXISTS public.sites;
DROP TABLE IF EXISTS public.schema_migrations;
DROP SEQUENCE IF EXISTS public.roles_id_seq;
DROP TABLE IF EXISTS public.roles;
DROP TABLE IF EXISTS public.request_user_statistics;
DROP TABLE IF EXISTS public.request_statistics;
DROP TABLE IF EXISTS public.que_values;
DROP TABLE IF EXISTS public.que_lockers;
DROP SEQUENCE IF EXISTS public.que_jobs_id_seq;
DROP SEQUENCE IF EXISTS public.permissions_id_seq;
DROP TABLE IF EXISTS public.permissions;
DROP SEQUENCE IF EXISTS public.open_id_states_id_seq;
DROP TABLE IF EXISTS public.open_id_states;
DROP SEQUENCE IF EXISTS public.oauth_states_id_seq;
DROP TABLE IF EXISTS public.oauth_states;
DROP SEQUENCE IF EXISTS public.nonces_id_seq;
DROP TABLE IF EXISTS public.nonces;
DROP SEQUENCE IF EXISTS public.lti_launches_id_seq;
DROP TABLE IF EXISTS public.lti_launches;
DROP SEQUENCE IF EXISTS public.lti_installs_id_seq;
DROP TABLE IF EXISTS public.lti_installs;
DROP SEQUENCE IF EXISTS public.lti_deployments_id_seq;
DROP TABLE IF EXISTS public.lti_deployments;
DROP SEQUENCE IF EXISTS public.jwks_id_seq;
DROP TABLE IF EXISTS public.jwks;
DROP SEQUENCE IF EXISTS public.ims_imports_id_seq;
DROP TABLE IF EXISTS public.ims_imports;
DROP SEQUENCE IF EXISTS public.ims_exports_id_seq;
DROP TABLE IF EXISTS public.ims_exports;
DROP SEQUENCE IF EXISTS public.canvas_courses_id_seq;
DROP TABLE IF EXISTS public.canvas_courses;
DROP SEQUENCE IF EXISTS public.bundles_id_seq;
DROP TABLE IF EXISTS public.bundles;
DROP SEQUENCE IF EXISTS public.bundle_instances_id_seq;
DROP TABLE IF EXISTS public.bundle_instances;
DROP SEQUENCE IF EXISTS public.authentications_id_seq;
DROP TABLE IF EXISTS public.authentications;
DROP TABLE IF EXISTS public.ar_internal_metadata;
DROP SEQUENCE IF EXISTS public.applications_id_seq;
DROP TABLE IF EXISTS public.applications;
DROP SEQUENCE IF EXISTS public.application_instances_id_seq;
DROP TABLE IF EXISTS public.application_instances;
DROP SEQUENCE IF EXISTS public.application_bundles_id_seq;
DROP TABLE IF EXISTS public.application_bundles;
DROP SEQUENCE IF EXISTS public.active_storage_variant_records_id_seq;
DROP TABLE IF EXISTS public.active_storage_variant_records;
DROP SEQUENCE IF EXISTS public.active_storage_blobs_id_seq;
DROP TABLE IF EXISTS public.active_storage_blobs;
DROP SEQUENCE IF EXISTS public.active_storage_attachments_id_seq;
DROP TABLE IF EXISTS public.active_storage_attachments;
DROP FUNCTION IF EXISTS public.que_state_notify();
DROP FUNCTION IF EXISTS public.que_job_notify();
DROP FUNCTION IF EXISTS public.que_determine_job_state(job public.que_jobs);
DROP TABLE IF EXISTS public.que_jobs;
DROP FUNCTION IF EXISTS public.que_validate_tags(tags_array jsonb);
DROP SCHEMA IF EXISTS public;
--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- CREATE SCHEMA public;


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
    rollbar_enabled boolean DEFAULT true,
    use_scoped_developer_key boolean DEFAULT false NOT NULL,
    nickname character varying,
    primary_contact character varying
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
    key character varying,
    oauth_precedence character varying DEFAULT 'global,user,application_instance,course'::character varying,
    anonymous boolean DEFAULT false,
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
-- Name: canvas_courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.canvas_courses (
    id bigint NOT NULL,
    lms_course_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
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
-- Name: ims_imports; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ims_imports (
    id bigint NOT NULL,
    status character varying DEFAULT 'initialized'::character varying NOT NULL,
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
    payload jsonb
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
-- Name: canvas_courses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_courses ALTER COLUMN id SET DEFAULT nextval('public.canvas_courses_id_seq'::regclass);


--
-- Name: ims_exports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_exports ALTER COLUMN id SET DEFAULT nextval('public.ims_exports_id_seq'::regclass);


--
-- Name: ims_imports id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_imports ALTER COLUMN id SET DEFAULT nextval('public.ims_imports_id_seq'::regclass);


--
-- Name: jwks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jwks ALTER COLUMN id SET DEFAULT nextval('public.jwks_id_seq'::regclass);


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
-- Name: nonces id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.nonces ALTER COLUMN id SET DEFAULT nextval('public.nonces_id_seq'::regclass);


--
-- Name: oauth_states id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.oauth_states ALTER COLUMN id SET DEFAULT nextval('public.oauth_states_id_seq'::regclass);


--
-- Name: open_id_states id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_id_states ALTER COLUMN id SET DEFAULT nextval('public.open_id_states_id_seq'::regclass);


--
-- Name: permissions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions ALTER COLUMN id SET DEFAULT nextval('public.permissions_id_seq'::regclass);


--
-- Name: que_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.que_jobs ALTER COLUMN id SET DEFAULT nextval('public.que_jobs_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: sites id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites ALTER COLUMN id SET DEFAULT nextval('public.sites_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


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
-- Name: canvas_courses canvas_courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.canvas_courses
    ADD CONSTRAINT canvas_courses_pkey PRIMARY KEY (id);


--
-- Name: ims_exports ims_exports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_exports
    ADD CONSTRAINT ims_exports_pkey PRIMARY KEY (id);


--
-- Name: ims_imports ims_imports_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ims_imports
    ADD CONSTRAINT ims_imports_pkey PRIMARY KEY (id);


--
-- Name: jwks jwks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jwks
    ADD CONSTRAINT jwks_pkey PRIMARY KEY (id);


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
-- Name: open_id_states open_id_states_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.open_id_states
    ADD CONSTRAINT open_id_states_pkey PRIMARY KEY (id);


--
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


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
-- Name: sites sites_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sites
    ADD CONSTRAINT sites_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


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
-- Name: index_canvas_courses_on_lms_course_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_canvas_courses_on_lms_course_id ON public.canvas_courses USING btree (lms_course_id);


--
-- Name: index_ims_exports_on_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_ims_exports_on_token ON public.ims_exports USING btree (token);


--
-- Name: index_jwks_on_application_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jwks_on_application_id ON public.jwks USING btree (application_id);


--
-- Name: index_jwks_on_kid; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_jwks_on_kid ON public.jwks USING btree (kid);


--
-- Name: index_lti_deployments_on_application_instance_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_lti_deployments_on_application_instance_id ON public.lti_deployments USING btree (application_instance_id);


--
-- Name: index_lti_deployments_on_d_id_and_ai_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_lti_deployments_on_d_id_and_ai_id ON public.lti_deployments USING btree (deployment_id, application_instance_id);


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
-- Name: index_nonces_on_nonce; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_nonces_on_nonce ON public.nonces USING btree (nonce);


--
-- Name: index_oauth_states_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_oauth_states_on_state ON public.oauth_states USING btree (state);


--
-- Name: index_open_id_states_on_nonce; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_open_id_states_on_nonce ON public.open_id_states USING btree (nonce);


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
-- Name: index_sites_on_url; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_sites_on_url ON public.sites USING btree (url);


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
-- Name: que_jobs que_job_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER que_job_notify AFTER INSERT ON public.que_jobs FOR EACH ROW EXECUTE FUNCTION public.que_job_notify();


--
-- Name: que_jobs que_state_notify; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER que_state_notify AFTER INSERT OR DELETE OR UPDATE ON public.que_jobs FOR EACH ROW EXECUTE FUNCTION public.que_state_notify();


--
-- Name: active_storage_variant_records fk_rails_993965df05; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.active_storage_variant_records
    ADD CONSTRAINT fk_rails_993965df05 FOREIGN KEY (blob_id) REFERENCES public.active_storage_blobs(id);


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
('20170627142629'),
('20170629220739'),
('20170705132718'),
('20170706192404'),
('20170711215536'),
('20170731160737'),
('20170807171059'),
('20170808145111'),
('20170915142046'),
('20170920214732'),
('20170921201330'),
('20170921202325'),
('20170926191503'),
('20170926200235'),
('20171003155408'),
('20171003181935'),
('20171117203730'),
('20171206054757'),
('20180201222026'),
('20180201235220'),
('20180209234904'),
('20180426214200'),
('20180522201717'),
('20181127204956'),
('20190219201006'),
('20190313033308'),
('20190319205918'),
('20190320012453'),
('20190320233646'),
('20190518190335'),
('20190523160910'),
('20190603162353'),
('20190627223838'),
('20190627224209'),
('20190708174519'),
('20190725201716'),
('20190801201027'),
('20190911015015'),
('20200125223051'),
('20200127230659'),
('20200219210631'),
('20200226194920'),
('20200624153201'),
('20200914195556'),
('20210210195029'),
('20210414152648'),
('20210501034609'),
('20210507213652'),
('20210510161432'),
('20210806204435'),
('20220106014956'),
('20220121162024'),
('20220121170405'),
('20220328234804'),
('20220329023856');


