--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.13 (Homebrew)

-- Started on 2025-07-23 19:15:12 IST

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

--
-- TOC entry 23 (class 2615 OID 16679)
-- Name: _realtime; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA _realtime;


ALTER SCHEMA _realtime OWNER TO postgres;

--
-- TOC entry 22 (class 2615 OID 16450)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- TOC entry 17 (class 2615 OID 16391)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 20 (class 2615 OID 16611)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- TOC entry 19 (class 2615 OID 16600)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- TOC entry 7 (class 3079 OID 16680)
-- Name: pg_net; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_net WITH SCHEMA extensions;


--
-- TOC entry 4373 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION pg_net; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_net IS 'Async HTTP';


--
-- TOC entry 12 (class 2615 OID 16386)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 14 (class 2615 OID 16592)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- TOC entry 21 (class 2615 OID 16498)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- TOC entry 11 (class 2615 OID 16724)
-- Name: supabase_functions; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA supabase_functions;


ALTER SCHEMA supabase_functions OWNER TO supabase_admin;

--
-- TOC entry 15 (class 2615 OID 18112)
-- Name: supabase_migrations; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA supabase_migrations;


ALTER SCHEMA supabase_migrations OWNER TO postgres;

--
-- TOC entry 16 (class 2615 OID 16638)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- TOC entry 6 (class 3079 OID 16666)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4380 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 4 (class 3079 OID 16558)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4381 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 3 (class 3079 OID 16403)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4382 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 16639)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4383 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 2 (class 3079 OID 16392)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4384 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1177 (class 1247 OID 17892)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1201 (class 1247 OID 18033)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1174 (class 1247 OID 17886)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1171 (class 1247 OID 17881)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1207 (class 1247 OID 18075)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1228 (class 1247 OID 18186)
-- Name: fitness_goal; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.fitness_goal AS ENUM (
    'gain_muscle',
    'lose_weight',
    'calisthenics',
    'bulking',
    'basic_fitness',
    'bodybuilding',
    'heavy_lifting'
);


ALTER TYPE public.fitness_goal OWNER TO postgres;

--
-- TOC entry 1231 (class 1247 OID 18202)
-- Name: subscription_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.subscription_status AS ENUM (
    'active',
    'inactive',
    'cancelled',
    'expired'
);


ALTER TYPE public.subscription_status OWNER TO postgres;

--
-- TOC entry 1234 (class 1247 OID 18212)
-- Name: training_type; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.training_type AS ENUM (
    'strength',
    'cardio',
    'yoga',
    'pilates',
    'crossfit',
    'martial_arts',
    'swimming',
    'cycling'
);


ALTER TYPE public.training_type OWNER TO postgres;

--
-- TOC entry 1237 (class 1247 OID 18230)
-- Name: user_role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.user_role AS ENUM (
    'gym_admin',
    'gym_user'
);


ALTER TYPE public.user_role OWNER TO postgres;

--
-- TOC entry 1129 (class 1247 OID 17506)
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- TOC entry 1120 (class 1247 OID 17467)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- TOC entry 1123 (class 1247 OID 17481)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- TOC entry 1135 (class 1247 OID 17548)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- TOC entry 1132 (class 1247 OID 17519)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- TOC entry 327 (class 1255 OID 16496)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4385 (class 0 OID 0)
-- Dependencies: 327
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 417 (class 1255 OID 17863)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 326 (class 1255 OID 16495)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4388 (class 0 OID 0)
-- Dependencies: 326
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 325 (class 1255 OID 16494)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4390 (class 0 OID 0)
-- Dependencies: 325
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 387 (class 1255 OID 16553)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO supabase_admin;

--
-- TOC entry 4406 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 358 (class 1255 OID 16605)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- TOC entry 4408 (class 0 OID 0)
-- Dependencies: 358
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 398 (class 1255 OID 16555)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

    ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
    ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

    REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
    REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

    GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO supabase_admin;

--
-- TOC entry 4410 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 362 (class 1255 OID 16596)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- TOC entry 355 (class 1255 OID 16597)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- TOC entry 357 (class 1255 OID 16607)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- TOC entry 4439 (class 0 OID 0)
-- Dependencies: 357
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 304 (class 1255 OID 16387)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- TOC entry 353 (class 1255 OID 18235)
-- Name: handle_new_user(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.handle_new_user() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Insert into profiles table
    INSERT INTO public.profiles (id, email, full_name, user_role)
    VALUES (
        new.id,
        new.email,
        COALESCE(new.raw_user_meta_data->>'full_name', ''),
        COALESCE((new.raw_user_meta_data->>'user_role')::user_role, 'gym_user'::user_role)
    );
    
    -- If user is a gym_user, also create gym_user_profile
    IF COALESCE((new.raw_user_meta_data->>'user_role')::user_role, 'gym_user'::user_role) = 'gym_user'::user_role THEN
        INSERT INTO public.gym_user_profiles (id)
        VALUES (new.id);
    END IF;
    
    RETURN new;
EXCEPTION
    WHEN OTHERS THEN
        -- Log the error but don't block user creation
        RAISE LOG 'Error in handle_new_user trigger: %', SQLERRM;
        RETURN new;
END;
$$;


ALTER FUNCTION public.handle_new_user() OWNER TO postgres;

--
-- TOC entry 351 (class 1255 OID 18172)
-- Name: update_user_body_measurements_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_user_body_measurements_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_user_body_measurements_updated_at() OWNER TO postgres;

--
-- TOC entry 424 (class 1255 OID 18134)
-- Name: update_user_goals_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_user_goals_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_user_goals_updated_at() OWNER TO postgres;

--
-- TOC entry 350 (class 1255 OID 18153)
-- Name: update_user_wearables_log_updated_at(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_user_wearables_log_updated_at() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_user_wearables_log_updated_at() OWNER TO postgres;

--
-- TOC entry 414 (class 1255 OID 17541)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 422 (class 1255 OID 17619)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- TOC entry 413 (class 1255 OID 17553)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- TOC entry 407 (class 1255 OID 17503)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- TOC entry 418 (class 1255 OID 17498)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- TOC entry 416 (class 1255 OID 17549)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- TOC entry 415 (class 1255 OID 17560)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- TOC entry 406 (class 1255 OID 17497)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- TOC entry 421 (class 1255 OID 17618)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- TOC entry 419 (class 1255 OID 17495)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- TOC entry 411 (class 1255 OID 17530)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- TOC entry 420 (class 1255 OID 17612)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 402 (class 1255 OID 17795)
-- Name: add_prefixes(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.add_prefixes(_bucket_id text, _name text) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
DECLARE
    prefixes text[];
BEGIN
    prefixes := "storage"."get_prefixes"("_name");

    IF array_length(prefixes, 1) > 0 THEN
        INSERT INTO storage.prefixes (name, bucket_id)
        SELECT UNNEST(prefixes) as name, "_bucket_id" ON CONFLICT DO NOTHING;
    END IF;
END;
$$;


ALTER FUNCTION storage.add_prefixes(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 426 (class 1255 OID 17721)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 399 (class 1255 OID 17796)
-- Name: delete_prefix(text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix(_bucket_id text, _name text) RETURNS boolean
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    -- Check if we can delete the prefix
    IF EXISTS(
        SELECT FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name") + 1
          AND "prefixes"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    )
    OR EXISTS(
        SELECT FROM "storage"."objects"
        WHERE "objects"."bucket_id" = "_bucket_id"
          AND "storage"."get_level"("objects"."name") = "storage"."get_level"("_name") + 1
          AND "objects"."name" COLLATE "C" LIKE "_name" || '/%'
        LIMIT 1
    ) THEN
    -- There are sub-objects, skip deletion
    RETURN false;
    ELSE
        DELETE FROM "storage"."prefixes"
        WHERE "prefixes"."bucket_id" = "_bucket_id"
          AND level = "storage"."get_level"("_name")
          AND "prefixes"."name" = "_name";
        RETURN true;
    END IF;
END;
$$;


ALTER FUNCTION storage.delete_prefix(_bucket_id text, _name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 404 (class 1255 OID 17799)
-- Name: delete_prefix_hierarchy_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.delete_prefix_hierarchy_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    prefix text;
BEGIN
    prefix := "storage"."get_prefix"(OLD."name");

    IF coalesce(prefix, '') != '' THEN
        PERFORM "storage"."delete_prefix"(OLD."bucket_id", prefix);
    END IF;

    RETURN OLD;
END;
$$;


ALTER FUNCTION storage.delete_prefix_hierarchy_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 412 (class 1255 OID 17814)
-- Name: enforce_bucket_name_length(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.enforce_bucket_name_length() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
begin
    if length(new.name) > 100 then
        raise exception 'bucket name "%" is too long (% characters). Max is 100.', new.name, length(new.name);
    end if;
    return new;
end;
$$;


ALTER FUNCTION storage.enforce_bucket_name_length() OWNER TO supabase_storage_admin;

--
-- TOC entry 408 (class 1255 OID 17695)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
    _filename text;
BEGIN
    SELECT string_to_array(name, '/') INTO _parts;
    SELECT _parts[array_length(_parts,1)] INTO _filename;
    RETURN reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 423 (class 1255 OID 17694)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 436 (class 1255 OID 17693)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    _parts text[];
BEGIN
    -- Split on "/" to get path segments
    SELECT string_to_array(name, '/') INTO _parts;
    -- Return everything except the last segment
    RETURN _parts[1 : array_length(_parts,1) - 1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 430 (class 1255 OID 17777)
-- Name: get_level(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_level(name text) RETURNS integer
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
SELECT array_length(string_to_array("name", '/'), 1);
$$;


ALTER FUNCTION storage.get_level(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 431 (class 1255 OID 17793)
-- Name: get_prefix(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefix(name text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
SELECT
    CASE WHEN strpos("name", '/') > 0 THEN
             regexp_replace("name", '[\/]{1}[^\/]+\/?$', '')
         ELSE
             ''
        END;
$_$;


ALTER FUNCTION storage.get_prefix(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 432 (class 1255 OID 17794)
-- Name: get_prefixes(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_prefixes(name text) RETURNS text[]
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
DECLARE
    parts text[];
    prefixes text[];
    prefix text;
BEGIN
    -- Split the name into parts by '/'
    parts := string_to_array("name", '/');
    prefixes := '{}';

    -- Construct the prefixes, stopping one level below the last part
    FOR i IN 1..array_length(parts, 1) - 1 LOOP
            prefix := array_to_string(parts[1:i], '/');
            prefixes := array_append(prefixes, prefix);
    END LOOP;

    RETURN prefixes;
END;
$$;


ALTER FUNCTION storage.get_prefixes(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 409 (class 1255 OID 17812)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::bigint) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 428 (class 1255 OID 17760)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 427 (class 1255 OID 17723)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 403 (class 1255 OID 17798)
-- Name: objects_insert_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_insert_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    NEW.level := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_insert_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 410 (class 1255 OID 17813)
-- Name: objects_update_prefix_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.objects_update_prefix_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    old_prefixes TEXT[];
BEGIN
    -- Ensure this is an update operation and the name has changed
    IF TG_OP = 'UPDATE' AND (NEW."name" <> OLD."name" OR NEW."bucket_id" <> OLD."bucket_id") THEN
        -- Retrieve old prefixes
        old_prefixes := "storage"."get_prefixes"(OLD."name");

        -- Remove old prefixes that are only used by this object
        WITH all_prefixes as (
            SELECT unnest(old_prefixes) as prefix
        ),
        can_delete_prefixes as (
             SELECT prefix
             FROM all_prefixes
             WHERE NOT EXISTS (
                 SELECT 1 FROM "storage"."objects"
                 WHERE "bucket_id" = OLD."bucket_id"
                   AND "name" <> OLD."name"
                   AND "name" LIKE (prefix || '%')
             )
         )
        DELETE FROM "storage"."prefixes" WHERE name IN (SELECT prefix FROM can_delete_prefixes);

        -- Add new prefixes
        PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    END IF;
    -- Set the new level
    NEW."level" := "storage"."get_level"(NEW."name");

    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.objects_update_prefix_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 429 (class 1255 OID 17776)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 400 (class 1255 OID 17797)
-- Name: prefixes_insert_trigger(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.prefixes_insert_trigger() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    PERFORM "storage"."add_prefixes"(NEW."bucket_id", NEW."name");
    RETURN NEW;
END;
$$;


ALTER FUNCTION storage.prefixes_insert_trigger() OWNER TO supabase_storage_admin;

--
-- TOC entry 435 (class 1255 OID 17710)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql
    AS $$
declare
    can_bypass_rls BOOLEAN;
begin
    SELECT rolbypassrls
    INTO can_bypass_rls
    FROM pg_roles
    WHERE rolname = coalesce(nullif(current_setting('role', true), 'none'), current_user);

    IF can_bypass_rls THEN
        RETURN QUERY SELECT * FROM storage.search_v1_optimised(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    ELSE
        RETURN QUERY SELECT * FROM storage.search_legacy_v1(prefix, bucketname, limits, levels, offsets, search, sortcolumn, sortorder);
    END IF;
end;
$$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 434 (class 1255 OID 17810)
-- Name: search_legacy_v1(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select path_tokens[$1] as folder
           from storage.objects
             where objects.name ilike $2 || $3 || ''%''
               and bucket_id = $4
               and array_length(objects.path_tokens, 1) <> $1
           group by folder
           order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_legacy_v1(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 433 (class 1255 OID 17809)
-- Name: search_v1_optimised(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
    v_order_by text;
    v_sort_order text;
begin
    case
        when sortcolumn = 'name' then
            v_order_by = 'name';
        when sortcolumn = 'updated_at' then
            v_order_by = 'updated_at';
        when sortcolumn = 'created_at' then
            v_order_by = 'created_at';
        when sortcolumn = 'last_accessed_at' then
            v_order_by = 'last_accessed_at';
        else
            v_order_by = 'name';
        end case;

    case
        when sortorder = 'asc' then
            v_sort_order = 'asc';
        when sortorder = 'desc' then
            v_sort_order = 'desc';
        else
            v_sort_order = 'asc';
        end case;

    v_order_by = v_order_by || ' ' || v_sort_order;

    return query execute
        'with folders as (
           select (string_to_array(name, ''/''))[level] as name
           from storage.prefixes
             where lower(prefixes.name) like lower($2 || $3) || ''%''
               and bucket_id = $4
               and level = $1
           order by name ' || v_sort_order || '
     )
     (select name,
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[level] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where lower(objects.name) like lower($2 || $3) || ''%''
       and bucket_id = $4
       and level = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search_v1_optimised(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 405 (class 1255 OID 17804)
-- Name: search_v2(text, text, integer, integer, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer DEFAULT 100, levels integer DEFAULT 1, start_after text DEFAULT ''::text) RETURNS TABLE(key text, name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
BEGIN
    RETURN query EXECUTE
        $sql$
        SELECT * FROM (
            (
                SELECT
                    split_part(name, '/', $4) AS key,
                    name || '/' AS name,
                    NULL::uuid AS id,
                    NULL::timestamptz AS updated_at,
                    NULL::timestamptz AS created_at,
                    NULL::jsonb AS metadata
                FROM storage.prefixes
                WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
                ORDER BY prefixes.name COLLATE "C" LIMIT $3
            )
            UNION ALL
            (SELECT split_part(name, '/', $4) AS key,
                name,
                id,
                updated_at,
                created_at,
                metadata
            FROM storage.objects
            WHERE name COLLATE "C" LIKE $1 || '%'
                AND bucket_id = $2
                AND level = $4
                AND name COLLATE "C" > $5
            ORDER BY name COLLATE "C" LIMIT $3)
        ) obj
        ORDER BY name COLLATE "C" LIMIT $3;
        $sql$
        USING prefix, bucket_name, limits, levels, start_after;
END;
$_$;


ALTER FUNCTION storage.search_v2(prefix text, bucket_name text, limits integer, levels integer, start_after text) OWNER TO supabase_storage_admin;

--
-- TOC entry 425 (class 1255 OID 17711)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- TOC entry 401 (class 1255 OID 16748)
-- Name: http_request(); Type: FUNCTION; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE FUNCTION supabase_functions.http_request() RETURNS trigger
    LANGUAGE plpgsql SECURITY DEFINER
    SET search_path TO 'supabase_functions'
    AS $$
  DECLARE
    request_id bigint;
    payload jsonb;
    url text := TG_ARGV[0]::text;
    method text := TG_ARGV[1]::text;
    headers jsonb DEFAULT '{}'::jsonb;
    params jsonb DEFAULT '{}'::jsonb;
    timeout_ms integer DEFAULT 1000;
  BEGIN
    IF url IS NULL OR url = 'null' THEN
      RAISE EXCEPTION 'url argument is missing';
    END IF;

    IF method IS NULL OR method = 'null' THEN
      RAISE EXCEPTION 'method argument is missing';
    END IF;

    IF TG_ARGV[2] IS NULL OR TG_ARGV[2] = 'null' THEN
      headers = '{"Content-Type": "application/json"}'::jsonb;
    ELSE
      headers = TG_ARGV[2]::jsonb;
    END IF;

    IF TG_ARGV[3] IS NULL OR TG_ARGV[3] = 'null' THEN
      params = '{}'::jsonb;
    ELSE
      params = TG_ARGV[3]::jsonb;
    END IF;

    IF TG_ARGV[4] IS NULL OR TG_ARGV[4] = 'null' THEN
      timeout_ms = 1000;
    ELSE
      timeout_ms = TG_ARGV[4]::integer;
    END IF;

    CASE
      WHEN method = 'GET' THEN
        SELECT http_get INTO request_id FROM net.http_get(
          url,
          params,
          headers,
          timeout_ms
        );
      WHEN method = 'POST' THEN
        payload = jsonb_build_object(
          'old_record', OLD,
          'record', NEW,
          'type', TG_OP,
          'table', TG_TABLE_NAME,
          'schema', TG_TABLE_SCHEMA
        );

        SELECT http_post INTO request_id FROM net.http_post(
          url,
          payload,
          params,
          headers,
          timeout_ms
        );
      ELSE
        RAISE EXCEPTION 'method argument % is invalid', method;
    END CASE;

    INSERT INTO supabase_functions.hooks
      (hook_table_id, hook_name, request_id)
    VALUES
      (TG_RELID, TG_NAME, request_id);

    RETURN NEW;
  END
$$;


ALTER FUNCTION supabase_functions.http_request() OWNER TO supabase_functions_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 256 (class 1259 OID 17342)
-- Name: extensions; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.extensions (
    id uuid NOT NULL,
    type text,
    settings jsonb,
    tenant_external_id text,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE _realtime.extensions OWNER TO supabase_admin;

--
-- TOC entry 254 (class 1259 OID 17328)
-- Name: schema_migrations; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE _realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 255 (class 1259 OID 17333)
-- Name: tenants; Type: TABLE; Schema: _realtime; Owner: supabase_admin
--

CREATE TABLE _realtime.tenants (
    id uuid NOT NULL,
    name text,
    external_id text,
    jwt_secret text,
    max_concurrent_users integer DEFAULT 200 NOT NULL,
    inserted_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    max_events_per_second integer DEFAULT 100 NOT NULL,
    postgres_cdc_default text DEFAULT 'postgres_cdc_rls'::text,
    max_bytes_per_second integer DEFAULT 100000 NOT NULL,
    max_channels_per_client integer DEFAULT 100 NOT NULL,
    max_joins_per_second integer DEFAULT 500 NOT NULL,
    suspend boolean DEFAULT false,
    jwt_jwks jsonb,
    notify_private_alpha boolean DEFAULT false,
    private_only boolean DEFAULT false NOT NULL,
    migrations_ran integer DEFAULT 0,
    broadcast_adapter character varying(255) DEFAULT 'phoenix'::character varying
);


ALTER TABLE _realtime.tenants OWNER TO supabase_admin;

--
-- TOC entry 236 (class 1259 OID 16481)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4475 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 281 (class 1259 OID 18037)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4477 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 272 (class 1259 OID 17835)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4479 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4480 (class 0 OID 0)
-- Dependencies: 272
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 235 (class 1259 OID 16474)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4482 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 276 (class 1259 OID 17924)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4484 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 275 (class 1259 OID 17912)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4486 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 274 (class 1259 OID 17899)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4488 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 282 (class 1259 OID 18087)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 234 (class 1259 OID 16463)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4491 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 233 (class 1259 OID 16462)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4493 (class 0 OID 0)
-- Dependencies: 233
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 279 (class 1259 OID 17966)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4495 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 280 (class 1259 OID 17984)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4497 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 237 (class 1259 OID 16489)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4499 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 273 (class 1259 OID 17865)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 273
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 278 (class 1259 OID 17951)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 277 (class 1259 OID 17942)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 277
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 232 (class 1259 OID 16451)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 288 (class 1259 OID 18236)
-- Name: ai_exercises_cache; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ai_exercises_cache (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    goal_category text NOT NULL,
    exercise_name text NOT NULL,
    exercise_data jsonb NOT NULL,
    generated_at timestamp with time zone DEFAULT now() NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.ai_exercises_cache OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 18174)
-- Name: category_exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.category_exercises (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    category_id text NOT NULL,
    exercise_name text NOT NULL,
    exercise_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.category_exercises OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 18244)
-- Name: exercises; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.exercises (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    muscle_groups text[],
    equipment_needed text[],
    difficulty_level text,
    instructions text,
    tips text,
    image_url text,
    video_url text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.exercises OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 18251)
-- Name: gym_equipment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gym_equipment (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    gym_id uuid NOT NULL,
    name text NOT NULL,
    quantity integer DEFAULT 1 NOT NULL,
    condition text,
    description text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.gym_equipment OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 18259)
-- Name: gym_subscriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gym_subscriptions (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    gym_id uuid NOT NULL,
    plan_id uuid NOT NULL,
    start_date date NOT NULL,
    end_date date NOT NULL,
    status public.subscription_status DEFAULT 'active'::public.subscription_status NOT NULL,
    trainer_id uuid,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.gym_subscriptions OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 18265)
-- Name: gym_user_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gym_user_profiles (
    id uuid NOT NULL,
    weight numeric(5,2),
    height numeric(5,2),
    bmi numeric(4,2),
    fitness_goals public.fitness_goal[],
    current_gym_id uuid,
    fitness_level text,
    medical_conditions text[],
    preferred_training_types public.training_type[],
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.gym_user_profiles OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 18272)
-- Name: gyms; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gyms (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    admin_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    area_sqft integer,
    address text NOT NULL,
    city text NOT NULL,
    state text NOT NULL,
    postal_code text,
    phone text,
    email text,
    website text,
    operating_hours jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.gyms OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 18280)
-- Name: nutrition; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nutrition (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    category text NOT NULL,
    calories_per_100g integer,
    protein_per_100g numeric(5,2),
    carbs_per_100g numeric(5,2),
    fat_per_100g numeric(5,2),
    fiber_per_100g numeric(5,2),
    vitamins jsonb,
    minerals jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.nutrition OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 18287)
-- Name: personal_trainers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.personal_trainers (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    gym_id uuid NOT NULL,
    name text NOT NULL,
    experience_years integer,
    specializations text[],
    hourly_rate numeric(10,2),
    bio text,
    certifications text[],
    available_hours jsonb,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.personal_trainers OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 18294)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    name text NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    category text NOT NULL,
    brand text,
    image_url text,
    in_stock boolean DEFAULT true,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 18302)
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid NOT NULL,
    email text NOT NULL,
    full_name text,
    user_role public.user_role DEFAULT 'gym_user'::public.user_role NOT NULL,
    phone text,
    address text,
    city text,
    state text,
    postal_code text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 18310)
-- Name: subscription_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.subscription_plans (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    gym_id uuid NOT NULL,
    name text NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    duration_months integer NOT NULL,
    features text[],
    trainer_sessions_included integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.subscription_plans OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 18155)
-- Name: user_body_measurements; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_body_measurements (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    date date NOT NULL,
    weight numeric,
    body_fat numeric,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_body_measurements OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 18318)
-- Name: user_exercise_history; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_exercise_history (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    exercise_id uuid,
    exercise_name text NOT NULL,
    goal_category text NOT NULL,
    viewed_at timestamp with time zone DEFAULT now() NOT NULL,
    performed boolean DEFAULT false,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_exercise_history OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 18327)
-- Name: user_exercise_preferences; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_exercise_preferences (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    preferred_goal_categories text[] DEFAULT '{}'::text[],
    favorite_exercises text[] DEFAULT '{}'::text[],
    equipment_available text[] DEFAULT '{}'::text[],
    difficulty_preference text DEFAULT 'intermediate'::text,
    workout_frequency_per_week integer DEFAULT 3,
    session_duration_minutes integer DEFAULT 45,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_exercise_preferences OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 18120)
-- Name: user_goals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_goals (
    user_id uuid NOT NULL,
    weekly_workouts integer,
    weight_goal numeric,
    streak_goal integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_goals OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 18341)
-- Name: user_nutrition_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_nutrition_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    food_id uuid NOT NULL,
    quantity_grams numeric(6,2) NOT NULL,
    meal_type text NOT NULL,
    log_date date DEFAULT CURRENT_DATE NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_nutrition_log OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 18136)
-- Name: user_wearables_log; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_wearables_log (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid,
    date date NOT NULL,
    steps integer,
    sleep numeric,
    heart_rate integer,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.user_wearables_log OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 18511)
-- Name: user_weekly_plans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_weekly_plans (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    week_start date NOT NULL,
    plan_data jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_weekly_plans OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 18349)
-- Name: user_workouts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_workouts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    user_id uuid NOT NULL,
    exercise_id uuid NOT NULL,
    sets integer,
    reps integer,
    weight numeric(5,2),
    duration_minutes integer,
    notes text,
    workout_date date DEFAULT CURRENT_DATE NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.user_workouts OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17622)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 264 (class 1259 OID 17638)
-- Name: messages_2025_07_22; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_22 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_22 OWNER TO supabase_admin;

--
-- TOC entry 265 (class 1259 OID 17649)
-- Name: messages_2025_07_23; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_23 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_23 OWNER TO supabase_admin;

--
-- TOC entry 266 (class 1259 OID 17660)
-- Name: messages_2025_07_24; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_24 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_24 OWNER TO supabase_admin;

--
-- TOC entry 267 (class 1259 OID 17671)
-- Name: messages_2025_07_25; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_25 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_25 OWNER TO supabase_admin;

--
-- TOC entry 268 (class 1259 OID 17682)
-- Name: messages_2025_07_26; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.messages_2025_07_26 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_07_26 OWNER TO supabase_admin;

--
-- TOC entry 257 (class 1259 OID 17461)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- TOC entry 260 (class 1259 OID 17483)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- TOC entry 259 (class 1259 OID 17482)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 238 (class 1259 OID 16502)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 240 (class 1259 OID 16544)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 239 (class 1259 OID 16517)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb,
    level integer
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 271 (class 1259 OID 17778)
-- Name: prefixes; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.prefixes (
    bucket_id text NOT NULL,
    name text NOT NULL COLLATE pg_catalog."C",
    level integer GENERATED ALWAYS AS (storage.get_level(name)) STORED NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE storage.prefixes OWNER TO supabase_storage_admin;

--
-- TOC entry 269 (class 1259 OID 17725)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 270 (class 1259 OID 17739)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 253 (class 1259 OID 16737)
-- Name: hooks; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.hooks (
    id bigint NOT NULL,
    hook_table_id integer NOT NULL,
    hook_name text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    request_id bigint
);


ALTER TABLE supabase_functions.hooks OWNER TO supabase_functions_admin;

--
-- TOC entry 4550 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE hooks; Type: COMMENT; Schema: supabase_functions; Owner: supabase_functions_admin
--

COMMENT ON TABLE supabase_functions.hooks IS 'Supabase Functions Hooks: Audit trail for triggered hooks.';


--
-- TOC entry 252 (class 1259 OID 16736)
-- Name: hooks_id_seq; Type: SEQUENCE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE SEQUENCE supabase_functions.hooks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE supabase_functions.hooks_id_seq OWNER TO supabase_functions_admin;

--
-- TOC entry 4552 (class 0 OID 0)
-- Dependencies: 252
-- Name: hooks_id_seq; Type: SEQUENCE OWNED BY; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER SEQUENCE supabase_functions.hooks_id_seq OWNED BY supabase_functions.hooks.id;


--
-- TOC entry 251 (class 1259 OID 16728)
-- Name: migrations; Type: TABLE; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE TABLE supabase_functions.migrations (
    version text NOT NULL,
    inserted_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE supabase_functions.migrations OWNER TO supabase_functions_admin;

--
-- TOC entry 283 (class 1259 OID 18113)
-- Name: schema_migrations; Type: TABLE; Schema: supabase_migrations; Owner: postgres
--

CREATE TABLE supabase_migrations.schema_migrations (
    version text NOT NULL,
    statements text[],
    name text
);


ALTER TABLE supabase_migrations.schema_migrations OWNER TO postgres;

--
-- TOC entry 3682 (class 0 OID 0)
-- Name: messages_2025_07_22; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_22 FOR VALUES FROM ('2025-07-22 00:00:00') TO ('2025-07-23 00:00:00');


--
-- TOC entry 3683 (class 0 OID 0)
-- Name: messages_2025_07_23; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_23 FOR VALUES FROM ('2025-07-23 00:00:00') TO ('2025-07-24 00:00:00');


--
-- TOC entry 3684 (class 0 OID 0)
-- Name: messages_2025_07_24; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_24 FOR VALUES FROM ('2025-07-24 00:00:00') TO ('2025-07-25 00:00:00');


--
-- TOC entry 3685 (class 0 OID 0)
-- Name: messages_2025_07_25; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_25 FOR VALUES FROM ('2025-07-25 00:00:00') TO ('2025-07-26 00:00:00');


--
-- TOC entry 3686 (class 0 OID 0)
-- Name: messages_2025_07_26; Type: TABLE ATTACH; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_07_26 FOR VALUES FROM ('2025-07-26 00:00:00') TO ('2025-07-27 00:00:00');


--
-- TOC entry 3696 (class 2604 OID 16466)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3715 (class 2604 OID 16740)
-- Name: hooks id; Type: DEFAULT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks ALTER COLUMN id SET DEFAULT nextval('supabase_functions.hooks_id_seq'::regclass);


--
-- TOC entry 4322 (class 0 OID 17342)
-- Dependencies: 256
-- Data for Name: extensions; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.extensions (id, type, settings, tenant_external_id, inserted_at, updated_at) FROM stdin;
1fe02920-be6e-42c5-a22c-fd926e20e1fe	postgres_cdc_rls	{"region": "us-east-1", "db_host": "wGmRcD+aH0n21h8A681jbh9EkH+dYAWReUNSUs627bc=", "db_name": "sWBpZNdjggEPTQVlI52Zfw==", "db_port": "+enMDFi1J/3IrrquHHwUmA==", "db_user": "uxbEq/zz8DXVD53TOI1zmw==", "slot_name": "supabase_realtime_replication_slot", "db_password": "sWBpZNdjggEPTQVlI52Zfw==", "publication": "supabase_realtime", "ssl_enforced": false, "poll_interval_ms": 100, "poll_max_changes": 100, "poll_max_record_bytes": 1048576}	realtime-dev	2025-07-23 12:20:01	2025-07-23 12:20:01
\.


--
-- TOC entry 4320 (class 0 OID 17328)
-- Dependencies: 254
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.schema_migrations (version, inserted_at) FROM stdin;
20210706140551	2025-07-23 10:52:39
20220329161857	2025-07-23 10:52:39
20220410212326	2025-07-23 10:52:39
20220506102948	2025-07-23 10:52:39
20220527210857	2025-07-23 10:52:39
20220815211129	2025-07-23 10:52:39
20220815215024	2025-07-23 10:52:39
20220818141501	2025-07-23 10:52:39
20221018173709	2025-07-23 10:52:39
20221102172703	2025-07-23 10:52:39
20221223010058	2025-07-23 10:52:39
20230110180046	2025-07-23 10:52:39
20230810220907	2025-07-23 10:52:39
20230810220924	2025-07-23 10:52:39
20231024094642	2025-07-23 10:52:39
20240306114423	2025-07-23 10:52:39
20240418082835	2025-07-23 10:52:39
20240625211759	2025-07-23 10:52:39
20240704172020	2025-07-23 10:52:39
20240902173232	2025-07-23 10:52:39
20241106103258	2025-07-23 10:52:39
20250424203323	2025-07-23 10:52:39
20250613072131	2025-07-23 10:52:39
\.


--
-- TOC entry 4321 (class 0 OID 17333)
-- Dependencies: 255
-- Data for Name: tenants; Type: TABLE DATA; Schema: _realtime; Owner: supabase_admin
--

COPY _realtime.tenants (id, name, external_id, jwt_secret, max_concurrent_users, inserted_at, updated_at, max_events_per_second, postgres_cdc_default, max_bytes_per_second, max_channels_per_client, max_joins_per_second, suspend, jwt_jwks, notify_private_alpha, private_only, migrations_ran, broadcast_adapter) FROM stdin;
e2ce735e-0bc0-4d2d-abb0-9fdfce2687ea	realtime-dev	realtime-dev	iNjicxc4+llvc9wovDvqymwfnj9teWMlyOIbJ8Fh6j2WNU8CIJ2ZgjR6MUIKqSmeDmvpsKLsZ9jgXJmQPpwL8w==	200	2025-07-23 12:20:01	2025-07-23 12:20:01	100	postgres_cdc_rls	100000	100	100	f	{"keys": [{"k": "c3VwZXItc2VjcmV0LWp3dC10b2tlbi13aXRoLWF0LWxlYXN0LTMyLWNoYXJhY3RlcnMtbG9uZw", "kty": "oct"}]}	f	f	62	phoenix
\.


--
-- TOC entry 4312 (class 0 OID 16481)
-- Dependencies: 236
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	9685dbf4-7be8-4fd1-8bbe-c5b86352d0a7	{"action":"user_signedup","actor_id":"f14640a2-1619-42cb-8c28-29f49401b92d","actor_name":"sagar seth","actor_username":"sagarseth2835@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}	2025-07-23 10:54:37.99929+00	
00000000-0000-0000-0000-000000000000	d89a0ea6-0e48-4e0b-be64-e9eaa8225ad6	{"action":"login","actor_id":"f14640a2-1619-42cb-8c28-29f49401b92d","actor_name":"sagar seth","actor_username":"sagarseth2835@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 10:54:38.001618+00	
00000000-0000-0000-0000-000000000000	fe96727d-cadc-4608-9dc6-e4d8b1a99cdf	{"action":"token_refreshed","actor_id":"f14640a2-1619-42cb-8c28-29f49401b92d","actor_name":"sagar seth","actor_username":"sagarseth2835@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-23 11:53:02.799739+00	
00000000-0000-0000-0000-000000000000	096325af-9f08-493f-80f4-744ef13f15e8	{"action":"token_revoked","actor_id":"f14640a2-1619-42cb-8c28-29f49401b92d","actor_name":"sagar seth","actor_username":"sagarseth2835@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-23 11:53:02.802839+00	
00000000-0000-0000-0000-000000000000	02ee7deb-cf19-4695-882e-2224decb7b85	{"action":"login","actor_id":"f14640a2-1619-42cb-8c28-29f49401b92d","actor_name":"sagar seth","actor_username":"sagarseth2835@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-07-23 12:29:58.918123+00	
00000000-0000-0000-0000-000000000000	16f60624-fe59-49c0-8f80-a03916494202	{"action":"token_refreshed","actor_id":"f14640a2-1619-42cb-8c28-29f49401b92d","actor_name":"sagar seth","actor_username":"sagarseth2835@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-23 13:29:45.74125+00	
00000000-0000-0000-0000-000000000000	f8dd47a4-923a-44d7-aa7b-a4d54fa63f9b	{"action":"token_revoked","actor_id":"f14640a2-1619-42cb-8c28-29f49401b92d","actor_name":"sagar seth","actor_username":"sagarseth2835@gmail.com","actor_via_sso":false,"log_type":"token"}	2025-07-23 13:29:45.745327+00	
\.


--
-- TOC entry 4343 (class 0 OID 18037)
-- Dependencies: 281
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
\.


--
-- TOC entry 4334 (class 0 OID 17835)
-- Dependencies: 272
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
f14640a2-1619-42cb-8c28-29f49401b92d	f14640a2-1619-42cb-8c28-29f49401b92d	{"sub": "f14640a2-1619-42cb-8c28-29f49401b92d", "email": "sagarseth2835@gmail.com", "full_name": "sagar seth", "user_role": "gym_user", "email_verified": false, "phone_verified": false}	email	2025-07-23 10:54:37.996135+00	2025-07-23 10:54:37.996159+00	2025-07-23 10:54:37.996159+00	ac7c2015-1f2b-4dcd-bd69-8b910c2cc945
\.


--
-- TOC entry 4311 (class 0 OID 16474)
-- Dependencies: 235
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4338 (class 0 OID 17924)
-- Dependencies: 276
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
c34d3bf5-eee7-4c2d-a534-505d24ec2e4d	2025-07-23 10:54:38.003926+00	2025-07-23 10:54:38.003926+00	password	43c0dd40-18bc-46cc-b367-4ea0dc6eb908
56b24ae6-9066-4516-a562-fa53680abf9e	2025-07-23 12:29:58.931309+00	2025-07-23 12:29:58.931309+00	password	ea64ff5b-7c71-438b-8621-07932755238d
\.


--
-- TOC entry 4337 (class 0 OID 17912)
-- Dependencies: 275
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- TOC entry 4336 (class 0 OID 17899)
-- Dependencies: 274
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- TOC entry 4344 (class 0 OID 18087)
-- Dependencies: 282
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4310 (class 0 OID 16463)
-- Dependencies: 234
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	1	vnvcps3fcxc7	f14640a2-1619-42cb-8c28-29f49401b92d	t	2025-07-23 10:54:38.002889+00	2025-07-23 11:53:02.803079+00	\N	c34d3bf5-eee7-4c2d-a534-505d24ec2e4d
00000000-0000-0000-0000-000000000000	2	yrvia5bblv2t	f14640a2-1619-42cb-8c28-29f49401b92d	f	2025-07-23 11:53:02.805952+00	2025-07-23 11:53:02.805952+00	vnvcps3fcxc7	c34d3bf5-eee7-4c2d-a534-505d24ec2e4d
00000000-0000-0000-0000-000000000000	3	ychk2kydxx5k	f14640a2-1619-42cb-8c28-29f49401b92d	t	2025-07-23 12:29:58.925871+00	2025-07-23 13:29:45.745635+00	\N	56b24ae6-9066-4516-a562-fa53680abf9e
00000000-0000-0000-0000-000000000000	4	kfni3hhk7uqi	f14640a2-1619-42cb-8c28-29f49401b92d	f	2025-07-23 13:29:45.760508+00	2025-07-23 13:29:45.760508+00	ychk2kydxx5k	56b24ae6-9066-4516-a562-fa53680abf9e
\.


--
-- TOC entry 4341 (class 0 OID 17966)
-- Dependencies: 279
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- TOC entry 4342 (class 0 OID 17984)
-- Dependencies: 280
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- TOC entry 4313 (class 0 OID 16489)
-- Dependencies: 237
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- TOC entry 4335 (class 0 OID 17865)
-- Dependencies: 273
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
c34d3bf5-eee7-4c2d-a534-505d24ec2e4d	f14640a2-1619-42cb-8c28-29f49401b92d	2025-07-23 10:54:38.001993+00	2025-07-23 11:53:02.811008+00	\N	aal1	\N	2025-07-23 11:53:02.810968	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	142.251.222.106	\N
56b24ae6-9066-4516-a562-fa53680abf9e	f14640a2-1619-42cb-8c28-29f49401b92d	2025-07-23 12:29:58.920869+00	2025-07-23 13:29:45.772956+00	\N	aal1	\N	2025-07-23 13:29:45.772913	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36	142.251.222.106	\N
\.


--
-- TOC entry 4340 (class 0 OID 17951)
-- Dependencies: 278
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4339 (class 0 OID 17942)
-- Dependencies: 277
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4308 (class 0 OID 16451)
-- Dependencies: 232
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	f14640a2-1619-42cb-8c28-29f49401b92d	authenticated	authenticated	sagarseth2835@gmail.com	$2a$10$dObHlelctIwwPnEc1tn04uBrxahmJsOIa0ywOENqfT0LrDKMLZmRm	2025-07-23 10:54:37.999992+00	\N		\N		\N			\N	2025-07-23 12:29:58.920813+00	{"provider": "email", "providers": ["email"]}	{"sub": "f14640a2-1619-42cb-8c28-29f49401b92d", "email": "sagarseth2835@gmail.com", "full_name": "sagar seth", "user_role": "gym_user", "email_verified": true, "phone_verified": false}	\N	2025-07-23 10:54:37.987022+00	2025-07-23 13:29:45.765113+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- TOC entry 4350 (class 0 OID 18236)
-- Dependencies: 288
-- Data for Name: ai_exercises_cache; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ai_exercises_cache (id, goal_category, exercise_name, exercise_data, generated_at, created_at) FROM stdin;
\.


--
-- TOC entry 4349 (class 0 OID 18174)
-- Dependencies: 287
-- Data for Name: category_exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category_exercises (id, category_id, exercise_name, exercise_data, created_at) FROM stdin;
6c38c25e-55ec-4deb-afa2-d085a4065da4	strength-building	Barbell Overhead Press (Batch 2)	{"id": "e4-overhead-press_batch2", "name": "Barbell Overhead Press (Batch 2)", "tips": "Keep your core engaged throughout the movement.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Muscle hypertrophy in shoulders"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a stable base", "Use proper form"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell overhead, fully extending your arms. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Overhead Press", "Use lighter weight"], "muscle_groups": ["Deltoids", "Triceps", "Trapezius"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
0702ca87-063a-4d11-943e-db850ceb89c0	strength-building	Barbell Back Squat (Batch 2)	{"id": "e1-barbell-squat_batch2", "name": "Barbell Back Squat (Batch 2)", "tips": "Focus on controlled movement and maintaining a neutral spine.", "benefits": ["Increased lower body strength", "Improved power", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly"], "instructions": "1. Place barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower your hips as if sitting in a chair, keeping your back straight. 4. Push through your heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squat", "Use lighter weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "knees collapsing inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
28c1f383-239f-4596-b2c2-5e40258a66aa	strength-building	Barbell Back Squat	{"id": "e1-barbell-squat", "name": "Barbell Back Squat", "tips": "Focus on controlled movements and proper form. Engage your core throughout the entire movement.", "benefits": ["Increased lower body strength", "Improved leg muscle hypertrophy", "Enhanced athletic performance"], "category": "strength-building", "image_url": "/images/exercise/barbell_back_squat.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Warm up properly before performing the exercise"], "instructions": "1. Position barbell across upper back, slightly below the traps. 2. Stand with feet shoulder-width apart, toes slightly outwards. 3. Lower your hips as if sitting in a chair, keeping your back straight and chest up. 4. Descend until your thighs are parallel to the ground or slightly below. 5. Push through your heels to return to the starting position.", "progressions": ["Goblet Squat", "Front Squat", "Pause Squats"], "rest_periods": "60-90 seconds", "modifications": ["Box Squats (to practice depth)", "High Bar Squats (easier on lower back)"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up", "Not going deep enough"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 11:47:37.524+00
8dc2d298-d148-48b1-8692-16e89a208de1	strength-building	Dumbbell Bench Press	{"id": "e2-dumbbell-bench-press", "name": "Dumbbell Bench Press", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increased chest strength", "Improved upper body hypertrophy", "Enhanced pushing power"], "category": "strength-building", "image_url": "/images/exercise/dumbbell_shoulder_press.png", "difficulty": "beginner", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable base and controlled movements"], "instructions": "1. Lie on a bench with your feet flat on the floor. 2. Hold dumbbells at chest height, palms facing each other. 3. Lower the dumbbells slowly to your chest, keeping your elbows slightly bent. 4. Push the dumbbells back up to the starting position.", "progressions": ["Barbell Bench Press", "Incline Dumbbell Press"], "rest_periods": "60 seconds", "modifications": ["Incline bench (easier)", "Dumbbell Floor Press (reduces shoulder stress)"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Bouncing the dumbbells off the chest", "Letting elbows flare out"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 11:47:37.532+00
495a00bf-f667-4da4-8c53-c778307d7b80	strength-building	Cable Rows	{"id": "e3-cable-rows", "name": "Cable Rows", "tips": "Focus on the contraction of your back muscles.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle thickness"], "category": "strength-building", "image_url": "/images/exercise/cable_rows.png", "difficulty": "intermediate", "safety_tips": ["Maintain a straight back and controlled movements", "Avoid jerking the weight"], "instructions": "1. Attach a straight bar or rope to the cable machine. 2. Kneel facing the machine, grasping the handle with an overhand grip. 3. Keep your back straight and pull the handle towards your abdomen, squeezing your shoulder blades together. 4. Slowly return to the starting position.", "progressions": ["Weighted Pull-ups", "T-Bar Rows"], "rest_periods": "60-90 seconds", "modifications": ["Seated Cable Rows (easier)"], "muscle_groups": ["Latissimus Dorsi", "Rhomboids", "Trapezius"], "common_mistakes": ["Using momentum", "Arching the back", "Not squeezing the shoulder blades"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 11:47:37.532+00
a7f4d6fa-32e8-4a6a-8b46-83c1bc717a0d	strength-building	Barbell Overhead Press	{"id": "e4-overhead-press", "name": "Barbell Overhead Press", "tips": "Focus on controlled movements and proper form. Engage your core throughout the entire movement.", "benefits": ["Increased shoulder strength", "Improved upper body strength and stability", "Enhanced athletic performance"], "category": "strength-building", "image_url": "/images/exercise/barbell_overhead_press.png", "difficulty": "advanced", "safety_tips": ["Use a spotter, especially with heavier weights", "Maintain a stable base and controlled movements"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell straight overhead, keeping your core engaged and back straight. 3. Slowly lower the barbell back to shoulder height.", "progressions": ["Arnold Press", "Dumbbell Shoulder Press"], "rest_periods": "90-120 seconds", "modifications": ["Seated Overhead Press (easier)"], "muscle_groups": ["Deltoids", "Triceps", "Trapezius"], "common_mistakes": ["Arching the back", "Using momentum", "Not keeping elbows tucked in"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 4-8 reps"}	2025-07-23 11:47:37.532+00
0751a8a2-61f2-47c0-9e1b-ef632eebcdb8	strength-building	Romanian Deadlifts (RDLs)	{"id": "e5-deadlifts", "name": "Romanian Deadlifts (RDLs)", "tips": "Focus on controlled movements and proper form. Engage your core throughout the entire movement.", "benefits": ["Increased hamstring and glute strength", "Improved posterior chain development", "Enhanced overall strength and power"], "category": "strength-building", "image_url": "/images/exercise/barbell_romanian_deadlift_rdl.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Warm up properly before performing the exercise"], "instructions": "1. Stand with feet hip-width apart, holding a barbell in front of your thighs. 2. Hinge at your hips, keeping your back straight and chest up. 3. Lower the barbell towards the ground, keeping a slight bend in your knees. 4. Push through your heels to return to the starting position.", "progressions": ["Conventional Deadlifts", "Sumo Deadlifts"], "rest_periods": "90-120 seconds", "modifications": ["Dumbbell RDLs (easier)", "Single-Leg RDLs (focus on balance and stability)"], "muscle_groups": ["Hamstrings", "Glutes", "Lower Back"], "common_mistakes": ["Rounding the back", "Using momentum", "Not going deep enough"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 11:47:37.532+00
5cbffc61-0b2f-4314-a984-91321909e177	weight-loss	Incline Treadmill Sprints	{"id": "incline-treadmill-sprint", "name": "Incline Treadmill Sprints", "tips": "Maintain a consistent pace during sprints and focus on proper breathing.", "benefits": ["high-intensity interval training (HIIT)", "improves cardiovascular fitness", "burns significant calories"], "category": "weight-loss", "image_url": "/images/exercise/jumping_jacks.png", "difficulty": "intermediate", "safety_tips": ["hold onto the rails only if needed for balance", "listen to your body and stop if necessary"], "instructions": "1. Set treadmill to a moderate incline (e.g., 3-5%). 2. Warm up with 5 minutes of walking at a comfortable pace. 3. Sprint at a high intensity for 30 seconds. 4. Recover with 90 seconds of walking at a slow pace. 5. Repeat steps 3 and 4 for 8-10 intervals.", "progressions": ["increase incline", "increase sprint duration", "decrease recovery time"], "rest_periods": "90 seconds rest between intervals", "modifications": ["reduce incline", "reduce sprint duration", "increase recovery time"], "muscle_groups": ["legs", "glutes", "cardiovascular"], "common_mistakes": ["holding on to the rails", "sprinting too slowly", "not recovering sufficiently"], "equipment_needed": ["treadmill"], "sets_reps_guidance": "8-10 intervals"}	2025-07-23 11:50:24.421+00
ffc95ca8-6bf3-4730-b4fe-bc2ef81c5157	weight-loss	Dumbbell Thrusters	{"id": "dumbbell-thrusters", "name": "Dumbbell Thrusters", "tips": "Focus on controlled movements and engage your core throughout the exercise.", "benefits": ["full-body strength and conditioning", "high calorie burn", "improves coordination"], "category": "weight-loss", "image_url": "/images/exercise/squats.png", "difficulty": "intermediate", "safety_tips": ["maintain proper form to prevent injury", "start with lighter weights and gradually increase"], "instructions": "1. Stand with feet shoulder-width apart, holding dumbbells at your shoulders. 2. Squat down until your thighs are parallel to the ground. 3. Explosively stand up, simultaneously pressing the dumbbells overhead. 4. Lower the dumbbells back to your shoulders and repeat.", "progressions": ["increase weight", "add jump"], "rest_periods": "60 seconds rest between sets", "modifications": ["use lighter dumbbells", "perform the squat and press separately"], "muscle_groups": ["legs", "shoulders", "core"], "common_mistakes": ["using too much weight", "rounding the back during squat", "not fully extending arms overhead"], "equipment_needed": ["light dumbbells"], "sets_reps_guidance": "3 sets of 10-15 repetitions"}	2025-07-23 11:50:24.421+00
4bdd3a3b-0c27-4e16-9810-312b5a370d7d	weight-loss	Advanced Mountain Climbers with Knee Drive	{"id": "mountain-climbers-advanced", "name": "Advanced Mountain Climbers with Knee Drive", "tips": "Focus on quick, controlled movements and maintaining a strong core.", "benefits": ["high-intensity cardio", "core strength", "improved endurance"], "category": "weight-loss", "image_url": "/images/exercise/mountain_climbers.png", "difficulty": "advanced", "safety_tips": ["maintain proper form to prevent injury", "listen to your body and stop if necessary"], "instructions": "1. Start in a high plank position with hands shoulder-width apart and body in a straight line. 2. Bring one knee towards your chest, keeping your core engaged. 3. Quickly switch legs, bringing the other knee towards your chest. 4. Continue alternating legs at a rapid pace, maintaining a strong core and straight back.", "progressions": ["add lateral movements", "increase speed and intensity"], "rest_periods": "60 seconds rest between sets", "modifications": ["perform on knees", "slower pace"], "muscle_groups": ["core", "legs", "shoulders"], "common_mistakes": ["sagging hips", "not engaging core", "slow pace"], "equipment_needed": ["none"], "sets_reps_guidance": "3 sets of 30-60 seconds"}	2025-07-23 11:50:24.421+00
8bbb640b-dcdb-4c67-a916-bb65d899b9b0	weight-loss	Rowing Machine High-Intensity Intervals	{"id": "rowing-machine-interval", "name": "Rowing Machine High-Intensity Intervals", "tips": "Focus on proper rowing technique using legs, core, and back muscles.", "benefits": ["full-body workout", "cardiovascular fitness", "calorie burning"], "category": "weight-loss", "image_url": "/images/exercise/jumping_jacks.png", "difficulty": "beginner", "safety_tips": ["maintain proper form to prevent injury", "listen to your body and stop if necessary"], "instructions": "1. Adjust the rowing machine to your height. 2. Warm up with 5 minutes of easy rowing. 3. Row at a moderate pace for 2 minutes. 4. Increase the intensity and row at a high pace for 30 seconds. 5. Return to a moderate pace for 2 minutes. 6. Repeat steps 4 and 5 for 6-8 intervals.", "progressions": ["increase intensity", "increase interval duration", "decrease rest time"], "rest_periods": "2 minutes rest between intervals", "modifications": ["reduce intensity", "reduce interval duration", "increase rest time"], "muscle_groups": ["back", "legs", "arms", "core"], "common_mistakes": ["incorrect rowing technique", "using too much arm strength", "not engaging legs properly"], "equipment_needed": ["rowing machine"], "sets_reps_guidance": "6-8 intervals"}	2025-07-23 11:50:24.421+00
e3bda4bf-ae03-4421-a479-e4d763a15b33	calisthenics	Bodyweight Squat	{"id": "bodyweight-squat", "name": "Bodyweight Squat", "tips": "Focus on controlled movements and maintaining a neutral spine.", "benefits": ["strengthens legs and glutes", "improves lower body mobility", "functional movement for daily life"], "category": "calisthenics", "image_url": "/images/exercise/squats.png", "difficulty": "beginner", "safety_tips": ["maintain proper form to avoid knee injuries", "stop if you feel pain"], "instructions": "1. Stand with feet shoulder-width apart, toes slightly outward. 2. Keeping your back straight and core engaged, lower your hips as if sitting in a chair. 3. Ensure your knees track over your toes. 4. Push through your heels to return to the starting position.", "progressions": ["pistol squat", "jump squat"], "rest_periods": "60 seconds between sets", "modifications": ["assisted squat using a chair", "reduce depth of squat"], "muscle_groups": ["quadriceps", "glutes", "hamstrings"], "common_mistakes": ["rounding the back", "knees collapsing inward"], "equipment_needed": [], "sets_reps_guidance": "3 sets of 10-15 repetitions"}	2025-07-23 11:52:03.108+00
197c1345-ea04-42fd-9499-26b6ff7fc15b	calisthenics	Australian Pull-Up (Inverted Row)	{"id": "Australian-Pull-up", "name": "Australian Pull-Up (Inverted Row)", "tips": "Focus on squeezing your shoulder blades together at the top.", "benefits": ["builds back and bicep strength", "improves posture", "prepares for full pull-ups"], "category": "calisthenics", "image_url": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["maintain a straight body throughout the exercise", "avoid jerking movements"], "instructions": "1. Lie under a pull-up bar, holding it with an overhand grip, slightly wider than shoulder-width. 2. Keep your body straight, forming a straight line from head to heels. 3. Pull your chest towards the bar, keeping your core engaged. 4. Slowly lower back to the starting position.", "progressions": ["standard pull-up", "weighted pull-ups"], "rest_periods": "90 seconds between sets", "modifications": ["elevate your feet to make it easier", "adjust hand placement"], "muscle_groups": ["back", "biceps", "forearms"], "common_mistakes": ["arching the back", "using momentum"], "equipment_needed": ["pull-up bar"], "sets_reps_guidance": "3 sets of as many repetitions as possible (AMRAP)"}	2025-07-23 11:52:03.108+00
8a7459dc-7f9e-4f16-af52-743abaeacd93	calisthenics	L-Sit	{"id": "L-sit", "name": "L-Sit", "tips": "Progress gradually, focusing on maintaining proper form.", "benefits": ["strengthens core muscles", "improves balance and stability", "builds shoulder strength"], "category": "calisthenics", "image_url": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["engage your core to maintain stability", "avoid sudden movements"], "instructions": "1. Start by holding onto parallel bars or a sturdy wall. 2. Extend your legs straight out in front of you, keeping your body in a straight line from head to heels. 3. Maintain this position, engaging your core and shoulder muscles. 4. Slowly lower your legs back to the ground.", "progressions": ["tuck L-sit", "advanced L-sit variations (straddle, full L-sit)"], "rest_periods": "90 seconds between sets", "modifications": ["using a wall for support", "holding the position for shorter durations"], "muscle_groups": ["core", "shoulders", "hips"], "common_mistakes": ["arching the back", "bending knees"], "equipment_needed": ["parallel bars", "wall"], "sets_reps_guidance": "3 sets, hold for as long as possible (15-30 seconds)"}	2025-07-23 11:52:03.108+00
d5ceae71-a855-4ce7-8811-26baced30d50	bulking	Barbell Back Squat	{"id": "e1-barbell-squat", "name": "Barbell Back Squat", "tips": "Focus on controlled movements and proper form.  Maintain a tight core throughout the movement.", "benefits": ["Builds overall lower body strength and mass", "Improves explosive power", "Enhances core stability"], "category": "bulking", "image_url": "/images/exercise/barbell_back_squat.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Warm up thoroughly before starting"], "instructions": "1. Position the barbell across your upper back, slightly below your traps. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Unrack the barbell and take a step back. 4. Squat down until your thighs are parallel to the ground, keeping your back straight and chest up. 5. Push through your heels to return to the starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "2-3 minutes between sets", "modifications": ["Box Squat (using a box to guide depth)", "High Bar Squat"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings", "Lower Back"], "common_mistakes": ["Rounding the back", "Looking up", "Not going deep enough"], "equipment_needed": ["barbell", "plates", "power rack"], "sets_reps_guidance": "3-5 sets of 6-12 reps"}	2025-07-23 11:52:31.871+00
1610fd73-f44a-41e4-8bf0-e82ac1ffe57d	bulking	Barbell Bench Press	{"id": "e2-bench-press", "name": "Barbell Bench Press", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increases chest size and strength", "Develops upper body pushing power"], "category": "bulking", "image_url": "/images/exercise/chest_press.png", "difficulty": "beginner", "safety_tips": ["Use a spotter, especially with heavier weights", "Maintain a stable base"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Grip the barbell slightly wider than shoulder-width apart. 3. Unrack the barbell and lower it slowly to your chest. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "1-2 minutes between sets", "modifications": ["Dumbbell Bench Press (easier to control)", "Using resistance bands for assistance"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back excessively", "Bouncing the barbell off the chest"], "equipment_needed": ["barbell", "plates", "bench"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 11:52:31.871+00
cdfdd144-f9c6-45b5-91e3-2aa482a07e0b	bulking	Barbell Overhead Press	{"id": "e4-overhead-press", "name": "Barbell Overhead Press", "tips": "Keep your core tight throughout the movement.", "benefits": ["Increases shoulder size and strength", "Improves upper body pushing strength"], "category": "bulking", "image_url": "/images/exercise/barbell_overhead_press.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable base"], "instructions": "1. Stand with feet shoulder-width apart, holding the barbell at shoulder height. 2. Press the barbell straight overhead until your arms are fully extended. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "1-2 minutes between sets", "modifications": ["Dumbbell Overhead Press", "Seated Overhead Press"], "muscle_groups": ["Shoulders (Deltoids)", "Triceps", "Upper Back"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["barbell", "plates"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 11:52:31.871+00
098e8676-f0ce-479b-bc8c-215394e220ee	bulking	Pull-ups	{"id": "e5-pull-ups", "name": "Pull-ups", "tips": "Focus on controlled movements and proper form.  Engage your back muscles throughout the movement.", "benefits": ["Builds back and arm strength and size", "Improves grip strength"], "category": "bulking", "image_url": "/images/exercise/pull_ups_bodyweight.png", "difficulty": "beginner", "safety_tips": ["Ensure a secure grip on the bar", "Start with assisted variations if needed"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width apart. 2. Hang from the bar with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Chin-ups", "Weighted Pull-ups"], "rest_periods": "1-2 minutes between sets", "modifications": ["Assisted Pull-ups (using resistance bands)", "Negative Pull-ups (focus on the lowering phase)"], "muscle_groups": ["Latissimus Dorsi (Back)", "Biceps", "Forearms"], "common_mistakes": ["Swinging", "Not engaging the back muscles"], "equipment_needed": ["pull-up bar"], "sets_reps_guidance": "3 sets of as many reps as possible (AMRAP)"}	2025-07-23 11:52:31.871+00
353d9222-3c5d-4765-b8fd-cfcd8e8d3363	functional	Kettlebell Goblet Squat to Swing	{"id": "kb-swing-101", "name": "Kettlebell Goblet Squat to Swing", "tips": "Focus on hip hinge movement and explosive power from the legs.", "benefits": ["strengthens lower body", "improves hip mobility", "develops power"], "category": "functional", "image_url": "/images/exercise/squats.png", "difficulty": "beginner", "safety_tips": ["maintain a straight back", "control the swing"], "instructions": "1. Hold a kettlebell vertically against your chest. 2. Squat down, keeping your back straight and chest up. 3. Stand up explosively, swinging the kettlebell up to shoulder height. 4. Control the kettlebell's descent and repeat.", "progressions": ["kettlebell swing only", "double kettlebell swing"], "rest_periods": "60 seconds between sets", "modifications": ["lighter kettlebell", "assisted squats"], "muscle_groups": ["quadriceps", "glutes", "hamstrings", "core"], "common_mistakes": ["rounding the back", "not engaging the core", "swinging too high"], "equipment_needed": ["kettlebell"], "sets_reps_guidance": "3 sets of 10-12 repetitions"}	2025-07-23 11:52:55.808+00
fe260ce7-1e98-45d8-9ba2-4dc25cda34d1	functional	Medicine Ball Slam and Tuck Jump	{"id": "medball-slam-power", "name": "Medicine Ball Slam and Tuck Jump", "tips": "Focus on generating maximal force during the slam and explosive power during the jump.", "benefits": ["explosive power", "core strength", "full-body coordination"], "category": "functional", "image_url": "/images/exercise/jumping_jacks.png", "difficulty": "intermediate", "safety_tips": ["ensure adequate space", "land softly", "control the medicine ball's descent"], "instructions": "1. Hold a medicine ball overhead. 2. Slam the ball forcefully to the ground. 3. Immediately perform a tuck jump, bringing your knees towards your chest. 4. Land softly and repeat.", "progressions": ["medicine ball chest pass", "increase medicine ball weight"], "rest_periods": "75 seconds between sets", "modifications": ["lighter medicine ball", "step-out jumps instead of tuck jumps"], "muscle_groups": ["core", "shoulders", "legs", "chest"], "common_mistakes": ["lack of control during the slam", "poor landing technique", "inconsistent jump height"], "equipment_needed": ["medicine ball"], "sets_reps_guidance": "3 sets of 8-10 repetitions"}	2025-07-23 11:52:55.808+00
3a5d0c30-c463-4723-b684-f8ecd79904f6	functional	Resistance Band Row to Assisted Pull-up	{"id": "band-row-pullup", "name": "Resistance Band Row to Assisted Pull-up", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["strengthens back muscles", "improves pulling strength", "develops upper body power"], "category": "functional", "image_url": "/images/exercise/lunges.png", "difficulty": "intermediate", "safety_tips": ["secure the band properly", "maintain proper form"], "instructions": "1. Secure resistance band to a sturdy overhead point. 2. Perform resistance band rows, focusing on squeezing your shoulder blades together. 3. Transition into an assisted pull-up using the band. 4. Slowly lower yourself back down and repeat.", "progressions": ["unassisted pull-ups", "increase band resistance"], "rest_periods": "90 seconds between sets", "modifications": ["lighter resistance band", "negative pull-ups only"], "muscle_groups": ["back", "biceps", "forearms", "lats"], "common_mistakes": ["using momentum", "not engaging the back muscles", "incorrect grip"], "equipment_needed": ["resistance band"], "sets_reps_guidance": "3 sets of as many repetitions as possible (AMRAP)"}	2025-07-23 11:52:55.808+00
7e7117a6-8b69-40bd-8903-3c522148eba8	functional	Pistol Squat (assisted)	{"id": "bodyweight-pistol", "name": "Pistol Squat (assisted)", "tips": "Maintain a stable core and focus on controlled movements. Practice balance drills separately before attempting pistol squats.", "benefits": ["single-leg strength", "balance", "improved mobility"], "category": "functional", "image_url": "/images/exercise/squats.png", "difficulty": "advanced", "safety_tips": ["start with assisted variations", "focus on balance and control", "use a spotter if needed"], "instructions": "1. Stand on one leg, extending the other leg forward. 2. Slowly lower yourself into a squat, keeping your back straight and core engaged. 3. Push through your heel to return to the starting position.  An assistance band can be looped around the back of your shoulders to help with the squat.  Do not use your hands for balance unless absolutely necessary. ", "progressions": ["unassisted pistol squat", "increase reps/sets"], "rest_periods": "120 seconds between sets", "modifications": ["assisted pistol squat with chair", "box squat to pistol transition"], "muscle_groups": ["quadriceps", "glutes", "hamstrings", "core"], "common_mistakes": ["falling over", "using momentum", "not engaging the core"], "equipment_needed": ["resistance band (optional)"], "sets_reps_guidance": "3 sets of 3-5 repetitions per leg"}	2025-07-23 11:52:55.808+00
25fcbce5-63bc-4d8d-b437-5ce88433c6f0	flexibility	Standing Quadriceps Stretch with Strap	{"id": "e2-standing-quad-stretch-strap", "name": "Standing Quadriceps Stretch with Strap", "tips": "Focus on your breathing and relax into the stretch.", "benefits": ["increases quadriceps flexibility", "improves hip mobility", "relieves knee tension"], "category": "flexibility", "image_url": "/images/exercise/plank.png", "difficulty": "intermediate", "safety_tips": ["avoid hyperextending your knee", "don't bounce"], "instructions": "1. Stand tall, feet hip-width apart. Loop a strap around one foot, holding the ends in your hands.\\n2. Gently pull on the strap, bending your knee slightly until you feel a stretch in the front of your thigh. \\n3. Keep your hips square and your core engaged. Maintain the stretch for 60 seconds.\\n4. Repeat on the other leg.", "progressions": ["increase the stretch by bending deeper", "hold the stretch longer"], "rest_periods": "30 seconds between legs", "modifications": ["use a shorter strap", "stand near a wall for balance"], "muscle_groups": ["quadriceps", "hip flexors"], "common_mistakes": ["arching your back", "forcing the stretch", "not keeping hips square"], "equipment_needed": ["yoga mat", "strap"], "sets_reps_guidance": "2 sets, 60 seconds per leg"}	2025-07-23 11:53:25.935+00
f339ea4e-9855-4a73-98b6-6ccdebb64546	flexibility	Pigeon Pose Variation with Block	{"id": "e3-pigeon-pose-variation", "name": "Pigeon Pose Variation with Block", "tips": "Focus on your breath and relax into the stretch.", "benefits": ["increases hip flexibility", "relieves hip tightness", "opens up the hips"], "category": "flexibility", "image_url": "/images/exercise/plank.png", "difficulty": "intermediate", "safety_tips": ["avoid pushing too hard into the stretch", "listen to your body and stop if you feel pain"], "instructions": "1. Start on your hands and knees. Bring your right knee forward behind your right wrist and extend your left leg back. \\n2. Gently lower your hips towards the mat, using a block under your right hip for support if needed. \\n3. Hold for 60 seconds. Repeat on the other side.", "progressions": ["lower your hips further", "hold the stretch longer", "try the pose without the block"], "rest_periods": "30 seconds between sides", "modifications": ["use a taller block", "keep your back leg bent"], "muscle_groups": ["hip flexors", "glutes", "piriformis"], "common_mistakes": ["forcing the stretch", "rounding the back", "not engaging core"], "equipment_needed": ["yoga mat", "block"], "sets_reps_guidance": "2 sets, 60 seconds per side"}	2025-07-23 11:53:25.935+00
53cef395-7115-400e-a576-ebdd10c5388a	strength-building	Barbell Bench Press (Batch 2)	{"id": "e2-bench-press_batch2", "name": "Barbell Bench Press (Batch 2)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increased chest strength", "Improved upper body power", "Muscle hypertrophy in chest and triceps"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Maintain a stable base"], "instructions": "1. Lie supine on a bench with feet flat on the floor. 2. Grip the barbell slightly wider than shoulder-width. 3. Lower the barbell to your chest, keeping your elbows slightly bent. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Use lighter weight"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Bouncing the bar off the chest"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
91b6545e-bd0d-4ef4-8b51-58abe24ab2e9	weight-loss	Explosive Burpee with Jump Squat	{"id": "burpee-variation", "name": "Explosive Burpee with Jump Squat", "tips": "Focus on explosive movements and maintain a controlled descent.", "benefits": ["full-body workout", "high-intensity cardio", "improves power and explosiveness"], "category": "weight-loss", "image_url": "/images/exercise/burpees.png", "difficulty": "intermediate", "safety_tips": ["maintain proper form to prevent injury", "land softly to protect joints"], "instructions": "1. Start in a standing position. 2. Drop into a squat, placing your hands on the floor. 3. Kick your feet back into a plank position. 4. Perform a push-up (optional). 5. Return to the plank. 6. Bring your feet forward to the squat position. 7. Explosively jump upwards, reaching your arms overhead. 8. Land softly and immediately transition into a jump squat by lowering into a squat and jumping again.", "progressions": ["burpee without jump", "burpee with plyometric push-up"], "rest_periods": "60 seconds rest between sets", "modifications": ["step-out burpees (instead of jumping)", "remove push-up"], "muscle_groups": ["legs", "shoulders", "chest", "core"], "common_mistakes": ["inconsistent jump height", "arching back during plank", "not engaging core"], "equipment_needed": ["none"], "sets_reps_guidance": "3 sets of 8-12 repetitions"}	2025-07-23 11:50:24.421+00
0c579560-b5f2-4be7-a0dd-ac543d7a1f9e	calisthenics	Incline Push-Up	{"id": "incline-push-up", "name": "Incline Push-Up", "tips": "Focus on controlled movements and a full range of motion.", "benefits": ["builds upper body strength", "improves chest and shoulder stability", "easier variation for beginners"], "category": "calisthenics", "image_url": "/images/exercise/bench_press.png", "difficulty": "beginner", "safety_tips": ["maintain a straight line from head to heels", "avoid locking out elbows at the top"], "instructions": "1. Place your hands shoulder-width apart on an elevated surface (bench, wall). 2. Position your body straight, forming a straight line from head to heels. 3. Lower your chest towards the surface by bending your elbows. 4. Push back up to the starting position.", "progressions": ["standard push-up", "decline push-up"], "rest_periods": "60 seconds between sets", "modifications": ["kneeling incline push-ups", "wider hand placement"], "muscle_groups": ["chest", "shoulders", "triceps"], "common_mistakes": ["sagging hips", "elbows flaring out"], "equipment_needed": ["bench", "wall"], "sets_reps_guidance": "3 sets of 8-12 repetitions"}	2025-07-23 11:52:03.108+00
3b71e12b-e4ad-4638-a8d4-fbae1f36be51	calisthenics	Handstand Progression (against a wall)	{"id": "handstand-progression", "name": "Handstand Progression (against a wall)", "tips": "Practice regularly and consistently, focusing on proper form and stability.", "benefits": ["builds incredible upper body strength and balance", "improves core stability", "challenging full-body exercise"], "category": "calisthenics", "image_url": "/images/exercise/squats.png", "difficulty": "advanced", "safety_tips": ["start near a wall for safety", "practice gradually to avoid injuries", "use a spotter initially"], "instructions": "1. Face a wall, about 1-2 feet away. 2. Place your hands shoulder-width apart on the ground. 3. Kick up one leg at a time, using momentum to achieve a handstand position with your back against the wall. 4. Maintain the handstand position by engaging your core and shoulder muscles. 5. Slowly lower yourself back down.", "progressions": ["free handstand", "handstand walks"], "rest_periods": "120 seconds between sets", "modifications": ["holding the handstand against the wall for shorter periods", "using a spotter"], "muscle_groups": ["shoulders", "core", "forearms", "wrist"], "common_mistakes": ["arching back", "leaning too far forward or backward", "not engaging core"], "equipment_needed": ["wall"], "sets_reps_guidance": "3 sets, hold for as long as possible (15-30 seconds)"}	2025-07-23 11:52:03.108+00
903196cc-0172-431a-aeb3-5b4c56711b55	flexibility	Corpse Pose (Shavasana) with Deep Breathing	{"id": "e5-corpse-pose-with-deep-breathing", "name": "Corpse Pose (Shavasana) with Deep Breathing", "tips": "Allow yourself to fully surrender to relaxation.  Focus on your breath and let go of any thoughts or worries.", "benefits": ["reduces stress and anxiety", "promotes relaxation", "lowers heart rate"], "category": "relaxation", "image_url": "/images/exercise/plank.png", "difficulty": "beginner", "safety_tips": ["find a quiet space", "ensure you won't be disturbed"], "instructions": "1. Lie on your back with arms relaxed at your sides, palms facing up. Legs slightly apart. \\n2. Close your eyes and focus on your breath. Inhale deeply through your nose, exhale slowly through your mouth. \\n3. Allow your body to completely relax, noticing any tension and letting it go. \\n4. Maintain this pose for 5-10 minutes.", "progressions": ["increase the duration of the pose", "focus on specific body parts to release tension"], "rest_periods": "N/A", "modifications": ["place a pillow under your knees or head for support"], "muscle_groups": ["whole body"], "common_mistakes": ["tensing up", "thinking too much"], "equipment_needed": ["yoga mat"], "sets_reps_guidance": "1 set, 5-10 minutes"}	2025-07-23 11:53:25.935+00
2d45ef40-c4d8-4f7d-bc5f-859bd36abc14	strength-building	Barbell Bent-Over Row (Batch 2)	{"id": "e3-bent-over-row_batch2", "name": "Barbell Bent-Over Row (Batch 2)", "tips": "Focus on squeezing your shoulder blades together at the top.", "benefits": ["Increased back strength", "Improved posture", "Muscle hypertrophy in back muscles"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine", "Use proper form"], "instructions": "1. Bend at the hips with a straight back, holding a barbell. 2. Pull the barbell towards your abdomen, keeping your elbows close to your body. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Pendlay Row", "Chest-Supported Row"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Row", "Use lighter weight"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
3a99b667-6fd7-49e8-884f-9f470fcb8578	bulking	Conventional Deadlift	{"id": "e3-deadlift", "name": "Conventional Deadlift", "tips": "Focus on hip hinge movement. Drive through your heels.", "benefits": ["Builds full-body strength and power", "Increases overall muscle mass"], "category": "bulking", "image_url": "/images/exercise/deadlift.png", "difficulty": "advanced", "safety_tips": ["Use proper lifting straps if needed", "Focus on maintaining a neutral spine"], "instructions": "1. Stand with feet hip-width apart, barbell over midfoot. 2. Bend at the hips and knees, keeping your back straight, and grip the barbell with an overhand grip (slightly wider than shoulder width). 3. Lift the barbell by extending your hips and knees simultaneously, keeping your back straight. 4. Lower the barbell back to the ground with control.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "3-5 minutes between sets", "modifications": ["Trap Bar Deadlift (easier on the back)", "Rack Pulls (starting from a higher position)"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Traps", "Forearms"], "common_mistakes": ["Rounding the back", "Using too much weight", "Not engaging the core"], "equipment_needed": ["barbell", "plates"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 11:52:31.871+00
c9103ec3-173a-49a8-b005-4436d646c8f3	flexibility	Seated Spinal Twist with Block	{"id": "e1-seated-spinal-twist", "name": "Seated Spinal Twist with Block", "tips": "Focus on your breath and use it to deepen the twist.", "benefits": ["improves spinal mobility", "relieves back tension", "increases torso rotation"], "category": "flexibility", "image_url": "/images/exercise/rows.png", "difficulty": "beginner", "safety_tips": ["avoid twisting too forcefully", "listen to your body and stop if you feel pain"], "instructions": "1. Sit on your mat with legs extended. Place a block between your thighs.\\n2. Inhale, lengthen your spine. Exhale, twist to the right, placing your left hand behind you for support and your right hand on the block. \\n3. Keep your spine long and avoid rounding your shoulders.  Maintain the twist for 30 seconds. \\n4. Inhale back to center, exhale and repeat on the other side.", "progressions": ["increase hold time", "remove the block"], "rest_periods": "30 seconds between sides", "modifications": ["bend your knees", "use a smaller block"], "muscle_groups": ["spinal erectors", "obliques", "hip flexors"], "common_mistakes": ["rounding the spine", "forcing the twist", "not engaging core"], "equipment_needed": ["yoga mat", "block"], "sets_reps_guidance": "2 sets, 30 seconds per side"}	2025-07-23 11:53:25.935+00
f09f0522-6a76-4e3c-b6f3-96659987015b	functional	Kettlebell Turkish Get-Up	{"id": "kb-turkish-getup", "name": "Kettlebell Turkish Get-Up", "tips": "Focus on controlled movements and maintaining a stable core throughout the exercise.", "benefits": ["full-body strength and coordination", "improved core stability", "enhanced mobility"], "category": "functional", "image_url": "/images/exercise/deadlift.png", "difficulty": "advanced", "safety_tips": ["start with a light kettlebell", "focus on proper technique", "use a stable surface"], "instructions": "Follow a proper Turkish Get-Up tutorial.  This exercise involves a complex sequence of movements from lying on your back to standing with a kettlebell overhead, maintaining control and balance throughout.", "progressions": ["increase kettlebell weight", "perform with eyes closed (advanced)", "perform with one arm"], "rest_periods": "120 seconds between sets", "modifications": ["lighter kettlebell", "practice individual phases separately"], "muscle_groups": ["entire body", "core", "shoulders", "legs"], "common_mistakes": ["losing balance", "incorrect technique", "using momentum"], "equipment_needed": ["kettlebell"], "sets_reps_guidance": "3 sets of 2-3 repetitions per side"}	2025-07-23 11:52:55.808+00
ee3c9fd4-6119-4762-b8be-350372dee44f	flexibility	Advanced Thoracic Rotation with Strap	{"id": "e4-thoracic-rotation-advanced", "name": "Advanced Thoracic Rotation with Strap", "tips": "Focus on controlled movement and deep breathing.", "benefits": ["improves thoracic spine mobility", "increases shoulder mobility", "relieves upper back stiffness"], "category": "mobility", "image_url": "/images/exercise/crunches.png", "difficulty": "advanced", "safety_tips": ["avoid hyperextending your spine", "listen to your body and stop if you feel pain"], "instructions": "1. Lie on your back with knees bent and feet flat on the floor. Hold the strap, extending your arms overhead.\\n2. Keeping your shoulders flat on the floor, rotate your arms and upper body to one side, allowing the strap to guide the movement. \\n3. Hold for 30 seconds. Return to center and repeat on the other side.", "progressions": ["increase the range of motion", "hold for longer durations"], "rest_periods": "30 seconds between sides", "modifications": ["bend your knees more", "use a shorter strap"], "muscle_groups": ["thoracic spine", "lats", "rotator cuff"], "common_mistakes": ["lifting shoulders off the floor", "forcing the rotation", "not engaging core"], "equipment_needed": ["yoga mat", "strap"], "sets_reps_guidance": "3 sets, 30 seconds per side"}	2025-07-23 11:53:25.935+00
ba12f526-d58f-4c49-9aea-287ab1b84889	strength-building	Barbell Back Squat (Batch 1)	{"id": "e1-barbell-squat_batch1", "name": "Barbell Back Squat (Batch 1)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased lower body strength", "Improved muscle hypertrophy in legs and glutes", "Enhanced athletic performance"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain proper form throughout the movement"], "instructions": "1. Position barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower your hips as if sitting in a chair, keeping your back straight and chest up. 4. Push through your heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["High bar squat", "Box Squat"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "knees collapsing inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
8d9c48b3-264d-4342-9463-5b3d53011898	strength-building	Barbell Bench Press (Batch 1)	{"id": "e2-bench-press_batch1", "name": "Barbell Bench Press (Batch 1)", "tips": "Control the weight throughout the movement.", "benefits": ["Increased chest strength", "Improved muscle hypertrophy in chest, shoulders, and triceps", "Enhanced upper body strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable base"], "instructions": "1. Lie supine on a bench with feet flat on the floor. 2. Grip the barbell slightly wider than shoulder-width. 3. Lower the barbell to your chest, keeping your elbows slightly bent. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Close-Grip Bench Press"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back excessively", "Lowering the bar too low"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
97c97695-104a-4c7f-808c-b2882b73a5e0	strength-building	Barbell Bent-Over Row (Batch 1)	{"id": "e3-bent-over-row_batch1", "name": "Barbell Bent-Over Row (Batch 1)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle hypertrophy in back"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine", "Use a weight you can control"], "instructions": "1. Bend at the hips, keeping your back straight. 2. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 3. Pull the barbell towards your abdomen, keeping your elbows close to your body. 4. Lower the barbell back to the starting position.", "progressions": ["Pendlay Row", "One-Arm Dumbbell Row"], "rest_periods": "60-90 seconds", "modifications": ["Seated Cable Row", "Chest Supported Row"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
7be83483-e9b3-4478-87f7-3928d72906d1	strength-building	Barbell Overhead Press (Batch 1)	{"id": "e4-overhead-press_batch1", "name": "Barbell Overhead Press (Batch 1)", "tips": "Control the weight throughout the movement.", "benefits": ["Increased shoulder strength", "Improved upper body strength", "Enhanced muscle hypertrophy in shoulders and triceps"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable base"], "instructions": "1. Stand with feet shoulder-width apart, holding the barbell at shoulder height. 2. Press the barbell overhead, keeping your core engaged and back straight. 3. Slowly lower the barbell back to shoulder height.", "progressions": ["Arnold Press", "Dumbbell Shoulder Press"], "rest_periods": "60-90 seconds", "modifications": ["Seated Overhead Press", "Push Press"], "muscle_groups": ["Deltoids", "Triceps", "Trapezius"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
55e4ec2a-b885-4da9-9ca5-00897767c4d3	strength-building	Conventional Deadlift (Batch 1)	{"id": "e5-deadlift_batch1", "name": "Conventional Deadlift (Batch 1)", "tips": "Focus on maintaining a neutral spine and engaging your core throughout the movement.", "benefits": ["Increased full-body strength", "Improved power", "Enhanced muscle hypertrophy in posterior chain"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use proper form", "Start with lighter weight"], "instructions": "1. Stand with feet hip-width apart, over the barbell. 2. Bend at the hips and knees, keeping your back straight. 3. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 4. Lift the barbell by extending your hips and knees simultaneously. 5. Lower the barbell back to the ground with control.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "2-3 minutes", "modifications": ["Trap Bar Deadlift", "Rack Pulls"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "Not engaging the core"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:37:47.69+00
37e55e4b-3f47-4e79-96c0-e50dd6e588c9	strength-building	Pull-ups (Batch 1)	{"id": "e6-pull-ups_batch1", "name": "Pull-ups (Batch 1)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased back and bicep strength", "Improved grip strength", "Enhanced muscle hypertrophy in back and biceps"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Use proper grip"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang from the bar with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Chin-ups", "Muscle-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Pull-ups", "Negative Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not fully extending arms"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:37:47.69+00
df1b3bec-02f5-4241-af5b-d22e91c88fa4	strength-building	Dips (Parallel Bars) (Batch 1)	{"id": "e7-dips_batch1", "name": "Dips (Parallel Bars) (Batch 1)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased triceps strength", "Improved chest strength", "Enhanced muscle hypertrophy in triceps and chest"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Use proper grip"], "instructions": "1. Grip the parallel bars with your hands shoulder-width apart. 2. Lower yourself down until your elbows are at a 90-degree angle. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "Archer Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals", "Anterior Deltoids"], "common_mistakes": ["Leaning too far forward", "Not lowering deeply enough"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
41e62d0e-6632-405e-99e0-2793af186dd3	strength-building	Dumbbell Bicep Curl (Batch 1)	{"id": "e8-dumbbell-bicep-curl_batch1", "name": "Dumbbell Bicep Curl (Batch 1)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased bicep strength", "Improved arm size", "Enhanced muscle hypertrophy in biceps"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "Use proper form"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl the dumbbells towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Cable Bicep Curls", "Incline Dumbbell Curls"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Arching the back"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:37:47.69+00
5d39abfb-98d5-4e3b-ab65-36e42cd44087	strength-building	Cable Face Pull (Batch 1)	{"id": "e9-cable-face-pull_batch1", "name": "Cable Face Pull (Batch 1)", "tips": "Focus on squeezing your shoulder blades together at the end of the movement.", "benefits": ["Improved posture", "Increased rear delt strength", "Reduced risk of shoulder injuries"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Avoid pulling too hard"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the cable machine with a slight bend in your knees. 3. Grip the rope with an overhand grip, slightly wider than shoulder-width. 4. Pull the rope towards your face, keeping your elbows high. 5. Slowly return to the starting position.", "progressions": ["Band Face Pulls", "Face Pulls with heavier weight"], "rest_periods": "45-60 seconds", "modifications": ["Using different cable attachments"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Pulling too low", "Not squeezing the shoulder blades"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 15-20 reps"}	2025-07-23 12:37:47.69+00
47645a7a-8815-4b7d-8a1f-5c6767ef7815	strength-building	Leg Press (Batch 1)	{"id": "e10-leg-press_batch1", "name": "Leg Press (Batch 1)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased leg strength", "Improved muscle hypertrophy in legs", "Reduced stress on lower back"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Always use spotter if needed", "Don't lock out the knees"], "instructions": "1. Sit on the leg press machine and adjust the seat so that your knees are slightly bent when your feet are on the platform. 2. Place your feet shoulder-width apart on the platform. 3. Push the platform away from you until your legs are fully extended. 4. Slowly lower the platform back to the starting position.", "progressions": ["Increase weight", "Narrow stance for quads, wider for glutes"], "rest_periods": "60-90 seconds", "modifications": ["Using different foot positions", "Partial reps"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Locking out knees", "Not using full range of motion"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:37:47.69+00
b1ecb50c-ef52-46d2-b141-3f35c3023c30	strength-building	Conventional Deadlift (Batch 2)	{"id": "e5-deadlift_batch2", "name": "Conventional Deadlift (Batch 2)", "tips": "Focus on maintaining a neutral spine and engaging your core.", "benefits": ["Increased full-body strength", "Improved power", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter", "Warm up properly"], "instructions": "1. Stand with feet hip-width apart, over the barbell. 2. Bend at the hips and knees, keeping your back straight. 3. Grip the barbell with an overhand grip. 4. Lift the barbell by extending your hips and knees simultaneously. 5. Slowly lower the barbell back to the starting position.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "120-180 seconds", "modifications": ["Trap Bar Deadlift", "Use lighter weight"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "Not keeping the barbell close to the body"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:37:47.69+00
c8ead782-6746-4cd9-83c7-a5cdbe36634e	strength-building	Pull-ups (Batch 2)	{"id": "e6-pull-ups_batch2", "name": "Pull-ups (Batch 2)", "tips": "Focus on squeezing your shoulder blades together at the top.", "benefits": ["Increased back and arm strength", "Improved grip strength", "Muscle hypertrophy in back and biceps"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Use proper form"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Australian Pull-ups", "Weighted Pull-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Pull-ups", "Negative Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Trapezius"], "common_mistakes": ["Using momentum", "Not fully extending arms at the bottom"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:37:47.69+00
a304c5da-ae5b-48a4-83e5-d0fe987985c2	strength-building	Dips (Parallel Bars) (Batch 2)	{"id": "e7-dips_batch2", "name": "Dips (Parallel Bars) (Batch 2)", "tips": "Focus on keeping your elbows tucked in.", "benefits": ["Increased triceps strength", "Improved chest and shoulder strength", "Muscle hypertrophy in triceps and chest"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Use proper form"], "instructions": "1. Position yourself between the parallel bars, hands shoulder-width apart. 2. Lower yourself down by bending your elbows until your upper arms are parallel to the ground. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "Close-Grip Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals", "Anterior Deltoids"], "common_mistakes": ["Leaning too far forward", "Not lowering deep enough"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
668711bb-a06d-49cd-addd-c971241a7ccb	strength-building	Dumbbell Lunges (Batch 2)	{"id": "e8-dumbbell-lunges_batch2", "name": "Dumbbell Lunges (Batch 2)", "tips": "Focus on keeping your knees aligned with your ankles.", "benefits": ["Increased lower body strength", "Improved balance", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "Use proper form"], "instructions": "1. Hold a dumbbell in each hand. 2. Step forward with one leg, bending both knees to 90 degrees. 3. Push off with your front foot to return to the starting position. 4. Repeat with the other leg.", "progressions": ["Walking Lunges", "Jumping Lunges"], "rest_periods": "45-60 seconds", "modifications": ["Stationary Lunges", "Use lighter weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Leaning too far forward", "Not going deep enough"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps per leg"}	2025-07-23 12:37:47.69+00
b2a5b1a8-e2de-4f60-a662-20471857463b	strength-building	Cable Face Pulls (Batch 2)	{"id": "e9-cable-face-pulls_batch2", "name": "Cable Face Pulls (Batch 2)", "tips": "Focus on squeezing your shoulder blades together at the end of the movement.", "benefits": ["Improved shoulder health", "Increased rear delt strength", "Enhanced posture"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "Use proper form"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the machine with a slight bend in your elbows. 3. Pull the rope towards your face, keeping your elbows high. 4. Slowly return to the starting position.", "progressions": ["Weighted Face Pulls", "Increase Resistance"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter weight", "Use a different attachment"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Pulling with your arms only", "Not retracting your shoulder blades"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 15-20 reps"}	2025-07-23 12:37:47.69+00
4273195a-39b9-42f1-92af-ed297087b61e	strength-building	Incline Dumbbell Press (Batch 2)	{"id": "e10-incline-dumbbell-press_batch2", "name": "Incline Dumbbell Press (Batch 2)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increased upper chest strength", "Improved upper body power", "Muscle hypertrophy in upper chest and shoulders"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter if needed", "Maintain a stable base"], "instructions": "1. Lie supine on an incline bench with dumbbells in each hand. 2. Lower the dumbbells towards your chest, keeping your elbows slightly bent. 3. Press the dumbbells back up to the starting position.", "progressions": ["Incline Dumbbell Press with close grip", "Increase weight"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter dumbbells", "Decrease incline angle"], "muscle_groups": ["Upper Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Letting the dumbbells drop too quickly"], "equipment_needed": ["Dumbbells", "Incline Bench"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
9c4aaade-dedc-474a-8f22-5ef05b866be8	strength-building	Barbell Back Squat (Batch 4)	{"id": "ex1-barbell-squat_batch4", "name": "Barbell Back Squat (Batch 4)", "tips": "Focus on controlled movements and maintaining a neutral spine.", "benefits": ["Increased lower body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain proper form"], "instructions": "1. Stand with feet shoulder-width apart, barbell across upper back. 2. Squat down until thighs are parallel to the ground, keeping back straight. 3. Push through heels to return to standing position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squats", "Using lighter weight"], "muscle_groups": ["Quads", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up", "Not going deep enough"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
ef1e7453-e5f1-4163-9c7d-ca498446136b	strength-building	Barbell Bench Press (Batch 4)	{"id": "ex2-bench-press_batch4", "name": "Barbell Bench Press (Batch 4)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increased chest strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain proper form"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Grip the barbell slightly wider than shoulder-width. 3. Lower the bar to your chest, keeping your elbows slightly bent. 4. Push the bar back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Using lighter weight"], "muscle_groups": ["Chest", "Shoulders", "Triceps"], "common_mistakes": ["Arching the back", "Bouncing the bar off the chest", "Using too much weight"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
965bff9f-cc30-4bcd-8d8c-f7bc5363b9fe	strength-building	Barbell Bent-Over Row (Batch 4)	{"id": "ex3-bent-over-row_batch4", "name": "Barbell Bent-Over Row (Batch 4)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter (optional)", "Warm up properly", "Maintain proper form"], "instructions": "1. Bend at the hips, keeping your back straight. 2. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 3. Pull the barbell towards your chest, keeping your elbows close to your body. 4. Lower the barbell back to the starting position.", "progressions": ["Pendlay Row", "One-Arm Dumbbell Row"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bent-Over Row", "Using lighter weight"], "muscle_groups": ["Back", "Biceps", "Forearms"], "common_mistakes": ["Rounding the back", "Using momentum", "Not pulling the bar close enough to the body"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
57d41af7-6332-4597-afcd-a7144fb10677	strength-building	Overhead Press (Barbell) (Batch 4)	{"id": "ex4-overhead-press_batch4", "name": "Overhead Press (Barbell) (Batch 4)", "tips": "Maintain a stable core throughout the movement.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter (optional)", "Warm up properly", "Maintain proper form"], "instructions": "1. Stand with feet shoulder-width apart, barbell at shoulder height. 2. Press the barbell straight overhead, locking your elbows. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Overhead Press", "Using lighter weight"], "muscle_groups": ["Shoulders", "Triceps"], "common_mistakes": ["Arching the back", "Using momentum", "Not locking out elbows"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
77ebb37f-9d7d-4860-b50a-069054b7eef5	strength-building	Conventional Deadlift (Batch 4)	{"id": "ex5-deadlift_batch4", "name": "Conventional Deadlift (Batch 4)", "tips": "Focus on maintaining a neutral spine throughout the lift.", "benefits": ["Increased full-body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter (optional)", "Warm up properly", "Maintain proper form"], "instructions": "1. Stand with feet hip-width apart, barbell in front of you. 2. Bend down and grip the bar with an overhand grip, slightly wider than shoulder-width. 3. Keeping your back straight, lift the barbell off the ground by extending your hips and knees. 4. Lower the barbell back to the ground with control.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "2-3 minutes", "modifications": ["Trap Bar Deadlift", "Using lighter weight"], "muscle_groups": ["Glutes", "Hamstrings", "Back", "Traps"], "common_mistakes": ["Rounding the back", "Using momentum", "Not engaging the core"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 3-5 reps"}	2025-07-23 12:37:47.69+00
7ed00129-4046-4858-b449-0036feda7cd7	strength-building	Pull-Ups (Batch 4)	{"id": "ex6-pull-ups_batch4", "name": "Pull-Ups (Batch 4)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased back strength", "Improved grip strength", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Warm up properly", "Maintain proper form"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Muscle-ups", "Weighted pull-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted pull-ups (using resistance bands)", "Negative pull-ups"], "muscle_groups": ["Back", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not pulling high enough", "Not lowering slowly"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "As many reps as possible (AMRAP), 3 sets"}	2025-07-23 12:37:47.69+00
c3cd4457-b037-4bc3-83da-32f6fd8e3de8	strength-building	Dips (Parallel Bars) (Batch 4)	{"id": "ex7-dips_batch4", "name": "Dips (Parallel Bars) (Batch 4)", "tips": "Keep your core engaged throughout the movement.", "benefits": ["Increased chest strength", "Improved triceps strength", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Warm up properly", "Maintain proper form"], "instructions": "1. Position yourself between the parallel bars, hands shoulder-width apart. 2. Lower yourself by bending your elbows until your upper arms are parallel to the ground. 3. Push yourself back up to the starting position.", "progressions": ["Weighted dips", "Close-grip dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted dips (using resistance bands)", "Bench dips"], "muscle_groups": ["Chest", "Shoulders", "Triceps"], "common_mistakes": ["Arching the back", "Not going deep enough", "Using momentum"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:37:47.69+00
070df23c-d81a-4647-b7a9-bebd3f97e417	strength-building	Dumbbell Bicep Curl (Batch 4)	{"id": "ex8-dumbbell-bicep-curl_batch4", "name": "Dumbbell Bicep Curl (Batch 4)", "tips": "Focus on squeezing your biceps at the top of the movement.", "benefits": ["Increased biceps strength", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain proper form", "Avoid jerking movements"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl the dumbbells up towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Seated Dumbbell Curls"], "muscle_groups": ["Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Swinging the dumbbells", "Not controlling the lowering phase"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:37:47.69+00
a33fadcb-47d2-495b-9fee-ffd38e0bbf8d	strength-building	Cable Flyes (Batch 4)	{"id": "ex9-cable-flyes_batch4", "name": "Cable Flyes (Batch 4)", "tips": "Focus on a controlled movement and a full range of motion.", "benefits": ["Increased chest strength", "Enhanced muscle growth", "Improved muscle definition"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain proper form", "Avoid jerking movements"], "instructions": "1. Stand in the middle of the cable machine, holding a handle in each hand. 2. Extend your arms out to the sides, keeping a slight bend in your elbows. 3. Bring your arms together in front of you, squeezing your chest. 4. Slowly return to the starting position.", "progressions": ["Decline Cable Flyes", "Incline Cable Flyes"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Using a different grip"], "muscle_groups": ["Chest"], "common_mistakes": ["Using too much weight", "Not controlling the movement", "Arching the back"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:37:47.69+00
4df04e5a-0060-4702-94a2-7d893d02b191	strength-building	Leg Press (Batch 4)	{"id": "ex10-leg-press_batch4", "name": "Leg Press (Batch 4)", "tips": "Focus on a controlled movement and a full range of motion.", "benefits": ["Increased lower body strength", "Enhanced muscle growth", "Improved leg power"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain proper form", "Avoid jerking movements"], "instructions": "1. Sit on the leg press machine, placing your feet shoulder-width apart on the platform. 2. Push the platform away from you, extending your legs. 3. Slowly return the platform to the starting position.", "progressions": ["Plate-loaded Leg Press", "Adding weight"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Adjusting foot placement"], "muscle_groups": ["Quads", "Glutes", "Hamstrings"], "common_mistakes": ["Using too much weight", "Not controlling the movement", "Not fully extending legs"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:37:47.69+00
18a02411-6a0b-4fdc-80a2-968bb1b64abe	weight-loss	Barbell Back Squat (Batch 1)	{"id": "e1-barbell-squat_batch1", "name": "Barbell Back Squat (Batch 1)", "tips": "Focus on controlled movements and proper form.", "benefits": ["Increases lower body strength", "Builds muscle mass in legs and glutes", "Improves overall athleticism"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Warm up properly"], "instructions": "1. Place barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower your hips as if sitting in a chair, keeping your back straight and chest up. 4. Push through your heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squats", "Reducing weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up", "Knees collapsing inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:39:29.553+00
0e317645-ebb0-4a40-b7e7-ad43a79becff	weight-loss	Dumbbell Bench Press (Batch 1)	{"id": "e2-dumbbell-bench-press_batch1", "name": "Dumbbell Bench Press (Batch 1)", "tips": "Control the negative (lowering) portion of the lift.", "benefits": ["Builds chest muscle mass", "Strengthens triceps and shoulders"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable base"], "instructions": "1. Lie on a bench with dumbbells at chest height. 2. Lower the dumbbells slowly to your chest, keeping your elbows slightly bent. 3. Push the dumbbells back up to starting position.", "progressions": ["Barbell Bench Press", "Incline Dumbbell Press"], "rest_periods": "60 seconds", "modifications": ["Using lighter dumbbells", "Performing on incline bench"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Letting elbows flare out"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:39:29.553+00
5bb18bf3-44be-4465-a4b8-d00b60efaaa2	weight-loss	Bent-Over Barbell Rows (Batch 1)	{"id": "e3-bent-over-rows_batch1", "name": "Bent-Over Barbell Rows (Batch 1)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Develops back thickness and strength", "Improves posture"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a flat back", "Focus on controlled movement"], "instructions": "1. Bend at the hips, keeping your back straight. 2. Hold a barbell with an overhand grip, slightly wider than shoulder-width. 3. Pull the barbell towards your abdomen, squeezing your shoulder blades together. 4. Slowly lower the barbell back to starting position.", "progressions": ["Pendlay Rows", "One-Arm Dumbbell Rows"], "rest_periods": "60-90 seconds", "modifications": ["Using lighter weight", "Seated Cable Rows"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:39:29.553+00
3c1156c5-691b-4949-b623-64568edf0e47	weight-loss	Overhead Barbell Press (Batch 1)	{"id": "e4-overhead-press_batch1", "name": "Overhead Barbell Press (Batch 1)", "tips": "Keep your core engaged throughout the movement.", "benefits": ["Increases shoulder strength", "Builds shoulder muscle mass"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable base"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell straight overhead, fully extending your arms. 3. Slowly lower the barbell back to shoulder height.", "progressions": ["Arnold Press", "Dumbbell Shoulder Press"], "rest_periods": "60-90 seconds", "modifications": ["Using lighter weight", "Seated Overhead Press"], "muscle_groups": ["Deltoids", "Triceps", "Trapezius"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:39:29.553+00
77f7b907-6d76-4960-8fdd-cbf6e96454e7	weight-loss	Conventional Deadlift (Batch 1)	{"id": "e5-deadlifts_batch1", "name": "Conventional Deadlift (Batch 1)", "tips": "Maintain a neutral spine throughout the lift.", "benefits": ["Full-body strength and power", "Significant muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter for heavier weights", "Focus on proper form"], "instructions": "1. Stand with feet hip-width apart, barbell over midfoot. 2. Bend at the hips and knees, keeping your back straight. 3. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 4. Lift the barbell by extending your hips and knees simultaneously. 5. Slowly lower the barbell back to the ground.", "progressions": ["Romanian Deadlifts", "Sumo Deadlifts"], "rest_periods": "2-3 minutes", "modifications": ["Using lighter weight", "Rack Pulls"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "Looking up", "Not engaging the legs"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:39:29.553+00
7c7b3168-8046-45cd-ade7-b3b92478a230	weight-loss	Pull-ups (Batch 1)	{"id": "e6-pull-ups_batch1", "name": "Pull-ups (Batch 1)", "tips": "Focus on squeezing your shoulder blades together at the top.", "benefits": ["Builds upper body strength", "Improves grip strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Proper grip"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang from the bar with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Chin-ups", "Australian Pull-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Pull-ups", "Negative Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not engaging the back muscles"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "As many reps as possible (AMRAP), 3 sets"}	2025-07-23 12:39:29.553+00
1f284010-6f01-458b-856f-2a8e8ed7dee3	weight-loss	One-Arm Dumbbell Row (Batch 1)	{"id": "e7-dumbbell-rows_batch1", "name": "One-Arm Dumbbell Row (Batch 1)", "tips": "Focus on the squeeze in your back muscles.", "benefits": ["Builds back strength and thickness", "Improves posture"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a flat back", "Use a controlled movement"], "instructions": "1. Place one knee and hand on a bench, keeping your back straight. 2. Hold a dumbbell in your other hand, letting it hang towards the floor. 3. Pull the dumbbell towards your abdomen, squeezing your shoulder blades together. 4. Slowly lower the dumbbell back to starting position. Repeat on other side.", "progressions": ["Bent-Over Barbell Rows", "T-Bar Rows"], "rest_periods": "60 seconds", "modifications": ["Using lighter weight", "Using a cable machine"], "muscle_groups": ["Latissimus Dorsi", "Rhomboids", "Trapezius"], "common_mistakes": ["Rounding the back", "Using momentum"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps per side"}	2025-07-23 12:39:29.553+00
672a03cf-2243-410d-ac26-e8125fed9d2e	weight-loss	Cable Flyes (Batch 1)	{"id": "e8-cable-flyes_batch1", "name": "Cable Flyes (Batch 1)", "tips": "Focus on the contraction of your chest muscles.", "benefits": ["Develops chest muscle mass and definition", "Targets different areas of the chest depending on angle"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Avoid jerking movements"], "instructions": "1. Attach handles to a cable machine at chest height. 2. Stand facing the machine, holding a handle in each hand. 3. Extend your arms outward, keeping a slight bend in your elbows. 4. Bring your arms together in front of you, squeezing your chest muscles. 5. Slowly return to starting position.", "progressions": ["Decline Cable Flyes", "Incline Cable Flyes"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Reducing range of motion"], "muscle_groups": ["Pectorals"], "common_mistakes": ["Using momentum", "Not fully extending the arms"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:39:29.553+00
d3dc043b-10dc-41f3-92df-3d5531e61c60	weight-loss	Leg Press (Batch 1)	{"id": "e9-leg-press_batch1", "name": "Leg Press (Batch 1)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Builds lower body strength and muscle mass", "Low impact alternative to squats"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Ensure platform is securely in place", "Use controlled movements"], "instructions": "1. Sit on the leg press machine and place your feet shoulder-width apart on the platform. 2. Push the platform away from you, extending your legs. 3. Slowly lower the platform back to starting position.", "progressions": ["Increased weight", "Varying foot placement"], "rest_periods": "60 seconds", "modifications": ["Using lighter weight", "Focusing on specific muscle groups through foot placement"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Using too much weight", "Locking out knees"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:39:29.553+00
aca5adff-c5ec-4f0d-afb8-068950573cee	weight-loss	Barbell Bicep Curls (Batch 1)	{"id": "e10-bicep-curls_batch1", "name": "Barbell Bicep Curls (Batch 1)", "tips": "Focus on the contraction of your biceps.", "benefits": ["Increases biceps size and strength", "Improves grip strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "Avoid jerking movements"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell with an underhand grip. 2. Curl the barbell towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the barbell back to starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Using dumbbells"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Swinging the weights"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:39:29.553+00
26033693-15e0-4da3-b394-118fd878d8fe	weight-loss	Barbell Back Squat (Batch 3)	{"id": "e1_batch3", "name": "Barbell Back Squat (Batch 3)", "tips": "Maintain a neutral spine throughout the movement.", "benefits": ["Builds overall lower body strength", "Increases muscle mass in legs and glutes", "Improves power and explosiveness"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight", "Warm up properly before starting"], "instructions": "1. Position barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Squat down until thighs are parallel to the ground, keeping back straight and chest up. 4. Push through heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Perform box squats"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings", "Lower Back"], "common_mistakes": ["Rounding the back", "Looking up", "Knees collapsing inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:39:29.553+00
8671d082-4336-4697-812d-b3363d08762f	weight-loss	Dumbbell Bench Press (Batch 3)	{"id": "e2_batch3", "name": "Dumbbell Bench Press (Batch 3)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Builds chest muscle mass", "Strengthens triceps and shoulders"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use a spotter if needed", "Control the weight throughout the movement"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Hold dumbbells at chest height, palms facing each other. 3. Lower dumbbells slowly to your chest, keeping elbows slightly bent. 4. Push dumbbells back up to starting position.", "progressions": ["Incline Dumbbell Press", "Decline Dumbbell Press"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter dumbbells", "Perform on an incline bench"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Letting elbows flare out"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:39:29.553+00
c0602473-c45f-4748-91bd-b65e9e51e28b	weight-loss	Pull-ups (Batch 3)	{"id": "e3_batch3", "name": "Pull-ups (Batch 3)", "tips": "Focus on controlled movements and avoid jerking.", "benefits": ["Builds back and bicep strength", "Improves grip strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Ensure a secure grip on the bar", "Don't attempt if you're not strong enough"], "instructions": "1. Grip pull-up bar with an overhand grip, slightly wider than shoulder-width apart. 2. Hang with arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back down to starting position.", "progressions": ["Negative pull-ups", "Assisted pull-ups"], "rest_periods": "60-90 seconds", "modifications": ["Use an assisted pull-up machine", "Perform lat pulldowns"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not fully extending arms at the bottom"], "equipment_needed": ["Pull-up bar"], "sets_reps_guidance": "3 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:39:29.553+00
06399d53-ff6e-4ab3-83b3-f1922581cfa7	weight-loss	Barbell Rows (Batch 3)	{"id": "e4_batch3", "name": "Barbell Rows (Batch 3)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Builds back thickness and strength", "Improves posture"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a straight back", "Use a spotter if needed"], "instructions": "1. Bend at the hips, keeping back straight. 2. Grip barbell with an overhand grip, slightly wider than shoulder-width apart. 3. Pull barbell towards your chest, keeping elbows close to your body. 4. Slowly lower barbell back to starting position.", "progressions": ["Pendlay Rows", "One-arm Dumbbell Rows"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Perform seated cable rows"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids", "Biceps"], "common_mistakes": ["Rounding the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:39:29.553+00
795edbfe-b89f-44b8-a20f-bad716f479ea	weight-loss	Overhead Press (Barbell) (Batch 3)	{"id": "e5_batch3", "name": "Overhead Press (Barbell) (Batch 3)", "tips": "Control the weight throughout the movement.", "benefits": ["Builds shoulder strength and size", "Improves overall upper body strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight", "Maintain a stable base"], "instructions": "1. Stand with feet shoulder-width apart, holding barbell at shoulder height. 2. Press barbell straight overhead, locking out your elbows. 3. Slowly lower barbell back to starting position.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Perform seated overhead press"], "muscle_groups": ["Shoulders (Deltoids)", "Triceps"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:39:29.553+00
a671f8d1-16ba-4c60-82b6-4d6a201ea4da	weight-loss	Dumbbell Bicep Curl (Batch 3)	{"id": "e6_batch3", "name": "Dumbbell Bicep Curl (Batch 3)", "tips": "Squeeze your biceps at the top of the movement.", "benefits": ["Builds bicep muscle mass", "Increases forearm strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Control the weight throughout the movement", "Avoid jerking the weights"], "instructions": "1. Stand with feet shoulder-width apart, holding dumbbells at your sides. 2. Curl dumbbells up towards your shoulders, keeping elbows close to your body. 3. Slowly lower dumbbells back to starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter dumbbells", "Perform seated bicep curls"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Swinging the weights"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:39:29.553+00
01f7d495-0f09-489e-b467-1f3fe3c815bd	weight-loss	Cable Triceps Pushdowns (Batch 3)	{"id": "e7_batch3", "name": "Cable Triceps Pushdowns (Batch 3)", "tips": "Focus on a controlled movement and fully extend your arms.", "benefits": ["Builds triceps muscle mass", "Increases overall arm strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Control the weight throughout the movement", "Avoid jerking the weight"], "instructions": "1. Attach a rope or V-bar attachment to the cable machine. 2. Stand facing the machine, holding the attachment with an overhand grip. 3. Extend your arms downwards, keeping your elbows close to your body. 4. Slowly return to starting position.", "progressions": ["Close-grip bench press", "Overhead triceps extensions"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter weight", "Perform with a straight bar attachment"], "muscle_groups": ["Triceps"], "common_mistakes": ["Using momentum", "Swinging the weight"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:39:29.553+00
d24c8f86-b7c0-4b6e-be5b-cd61164f599d	weight-loss	Romanian Deadlifts (RDLs) (Batch 3)	{"id": "e8_batch3", "name": "Romanian Deadlifts (RDLs) (Batch 3)", "tips": "Focus on controlled movements and avoid using momentum.", "benefits": ["Builds hamstring and glute strength", "Improves hip mobility"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a straight back", "Use a spotter if needed"], "instructions": "1. Stand with feet hip-width apart, holding a barbell in front of your thighs. 2. Hinge at your hips, keeping your back straight and chest up. 3. Lower the barbell towards the ground, keeping a slight bend in your knees. 4. Push through your heels to return to starting position.", "progressions": ["Stiff-legged deadlifts", "Good mornings"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Perform single-leg RDLs"], "muscle_groups": ["Hamstrings", "Glutes", "Lower Back"], "common_mistakes": ["Rounding the back", "Knees collapsing inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:39:29.553+00
7960f608-fd41-45df-bee9-796034b646c5	weight-loss	Deadlifts (Conventional) (Batch 3)	{"id": "e9_batch3", "name": "Deadlifts (Conventional) (Batch 3)", "tips": "Focus on proper form and technique.", "benefits": ["Builds full-body strength", "Increases power and explosiveness"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter, especially with heavy weight", "Warm up thoroughly"], "instructions": "1. Stand with feet hip-width apart, toes slightly outward, barbell in front of you. 2. Bend down and grip the barbell with an overhand grip, slightly wider than shoulder-width apart. 3. Keep your back straight and chest up as you lift the barbell. 4. Stand upright, maintaining a neutral spine. 5. Slowly lower the barbell back to the ground.", "progressions": ["Sumo Deadlifts", "Trap Bar Deadlifts"], "rest_periods": "2-3 minutes", "modifications": ["Use lighter weight", "Perform block pulls"], "muscle_groups": ["Entire Body (Posterior Chain Emphasis)"], "common_mistakes": ["Rounding the back", "Looking up", "Not engaging core"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:39:29.553+00
09255080-5536-4851-8fbe-319c39cabe32	weight-loss	Leg Press (Batch 3)	{"id": "e10_batch3", "name": "Leg Press (Batch 3)", "tips": "Maintain a controlled movement throughout the exercise.", "benefits": ["Builds lower body strength and mass", "Reduces stress on the lower back compared to squats"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Ensure the machine is properly adjusted", "Avoid bouncing the weight"], "instructions": "1. Sit on the leg press machine and place your feet shoulder-width apart on the platform. 2. Push the platform away from you, extending your legs. 3. Slowly return to starting position.", "progressions": ["Increased weight", "Varying foot placement"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter weight", "Perform partial reps"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Using too much weight", "Not fully extending legs"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:39:29.553+00
e31be983-8d04-4d2d-a95c-3dfa9ed38fd4	calisthenics	Barbell Back Squat (Batch 1)	{"id": "e1_batch1", "name": "Barbell Back Squat (Batch 1)", "tips": "Focus on controlled movements and proper form", "benefits": ["Increased lower body strength", "Improved leg size and definition", "Enhanced athletic performance"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Warm up thoroughly before starting"], "instructions": "1. Place barbell across upper back, slightly below shoulders. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower your hips as if sitting in a chair, keeping your back straight and chest up. 4. Push through your heels to return to the starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Perform box squats"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "knees collapsing inward", "heels lifting off the ground"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:41:00.281+00
ebfe8c5d-073b-4ba5-8326-68d12c318a84	calisthenics	Dumbbell Bench Press (Batch 1)	{"id": "e2_batch1", "name": "Dumbbell Bench Press (Batch 1)", "tips": "Squeeze your chest at the top of the movement", "benefits": ["Increased chest strength", "Improved upper body size and definition"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use a spotter if needed", "Maintain a controlled movement"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Hold dumbbells above chest, palms facing each other. 3. Lower dumbbells towards chest, keeping elbows slightly bent. 4. Push dumbbells back to the starting position.", "progressions": ["Incline Dumbbell Press", "Decline Dumbbell Press"], "rest_periods": "60 seconds", "modifications": ["Use lighter dumbbells", "Perform on an incline bench for easier variation"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "lowering dumbbells too low"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:41:00.281+00
16f5d2d3-bc6c-4cf9-80d2-3af1d51c3431	calisthenics	Barbell Bent-Over Row (Batch 1)	{"id": "e3_batch1", "name": "Barbell Bent-Over Row (Batch 1)", "tips": "Focus on controlled movements and proper form", "benefits": ["Increased back strength", "Improved posture", "Enhanced back thickness and width"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine", "Use a spotter if needed"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell with an overhand grip. 2. Bend at the hips, keeping your back straight. 3. Pull the barbell towards your chest, squeezing your shoulder blades together. 4. Slowly lower the barbell back to the starting position.", "progressions": ["Pendlay Row", "Chest Supported Row"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "perform seated cable rows"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:41:00.281+00
5681b8f4-e26c-4f6b-9191-073ddac3bab2	calisthenics	Overhead Press (Barbell) (Batch 1)	{"id": "e4_batch1", "name": "Overhead Press (Barbell) (Batch 1)", "tips": "Keep your core engaged throughout the movement", "benefits": ["Increased shoulder strength", "Improved shoulder size and definition"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter if needed", "Maintain a stable base"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell overhead, extending your arms fully. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "perform seated overhead press"], "muscle_groups": ["Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 6-12 reps"}	2025-07-23 12:41:00.281+00
915f4a48-e1e4-4a48-8295-8d0a8d22a43d	calisthenics	Pull-ups (Batch 1)	{"id": "e5_batch1", "name": "Pull-ups (Batch 1)", "tips": "Focus on a slow, controlled movement", "benefits": ["Increased back and arm strength", "Improved grip strength"], "category": "Calisthenics & Bodyweight", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Maintain a controlled movement", "Don't overexert yourself"], "instructions": "1. Grip a pull-up bar with an overhand grip, slightly wider than shoulder-width apart. 2. Hang with arms fully extended. 3. Pull yourself up until your chin is above the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Negative Pull-ups", "Assisted Pull-ups"], "rest_periods": "90-120 seconds", "modifications": ["Use assisted pull-up machine", "perform lat pulldowns"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Swinging", "using momentum"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "As many reps as possible (AMRAP), 3 sets"}	2025-07-23 12:41:00.281+00
0d382f55-9496-4c37-9c2b-224ab06bd13f	calisthenics	Dumbbell Rows (Batch 1)	{"id": "e6_batch1", "name": "Dumbbell Rows (Batch 1)", "tips": "Focus on controlled movement", "benefits": ["Increased back strength and thickness"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a straight back", "avoid twisting"], "instructions": "1. Place one knee and hand on a bench, keeping your back straight. 2. Hold a dumbbell in the opposite hand. 3. Pull the dumbbell towards your chest, squeezing your shoulder blades together. 4. Slowly lower the dumbbell back to the starting position.", "progressions": ["Barbell Rows", "T-Bar Rows"], "rest_periods": "60 seconds", "modifications": ["Use lighter weight", "perform seated cable rows"], "muscle_groups": ["Latissimus Dorsi", "Rhomboids", "Trapezius"], "common_mistakes": ["Arching the back", "using momentum"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:41:00.281+00
8d3cb8f7-49a3-422c-a87f-8ccddbab3f4b	calisthenics	Cable Flyes (Batch 1)	{"id": "e7_batch1", "name": "Cable Flyes (Batch 1)", "tips": "Focus on a controlled movement and a full range of motion", "benefits": ["Increased chest size and definition"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "avoid jerky movements"], "instructions": "1. Attach a rope or handle to a cable machine. 2. Stand facing the machine, holding the handles with your arms extended. 3. Bring the handles together in front of your chest, squeezing your pectoral muscles. 4. Slowly return to the starting position.", "progressions": ["Decline Cable Flyes", "Incline Cable Flyes"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter weight", "use a wider grip"], "muscle_groups": ["Pectorals"], "common_mistakes": ["Using momentum", "not fully extending arms"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:41:00.281+00
d9d148c6-f3e3-4c5b-ae6a-3e845c97eba2	calisthenics	Leg Press (Batch 1)	{"id": "e8_batch1", "name": "Leg Press (Batch 1)", "tips": "Focus on controlled movement and a full range of motion", "benefits": ["Increased lower body strength and size"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "avoid locking out knees"], "instructions": "1. Sit on the leg press machine and place your feet shoulder-width apart on the platform. 2. Push the platform away from you, extending your legs fully. 3. Slowly return to the starting position.", "progressions": ["Hack Squat", "Leg Extensions"], "rest_periods": "60 seconds", "modifications": ["Use lighter weight", "adjust foot placement"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Using momentum", "locking out knees"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:41:00.281+00
4e99d97f-f78c-497e-9895-bed9bb961900	calisthenics	Dips (Bodyweight) (Batch 1)	{"id": "e9_batch1", "name": "Dips (Bodyweight) (Batch 1)", "tips": "Focus on slow and controlled movement", "benefits": ["Increased triceps and chest strength"], "category": "Calisthenics & Bodyweight", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "avoid locking out elbows"], "instructions": "1. Grip the dip bars with your hands shoulder-width apart. 2. Lower your body by bending your elbows until your upper arms are parallel to the ground. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "Close-Grip Dips"], "rest_periods": "90 seconds", "modifications": ["Assisted dips using resistance band", "incline dips"], "muscle_groups": ["Triceps", "Pectorals"], "common_mistakes": ["Not going deep enough", "using momentum"], "equipment_needed": ["Dip Station"], "sets_reps_guidance": "3 sets of AMRAP"}	2025-07-23 12:41:00.281+00
bb01d8ec-fa38-4f39-95bc-e12d7145c9d4	calisthenics	Deadlifts (Barbell) (Batch 1)	{"id": "e10_batch1", "name": "Deadlifts (Barbell) (Batch 1)", "tips": "Focus on maintaining a neutral spine and engaging your core throughout the movement", "benefits": ["Increased full-body strength", "Improved overall power"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter, especially with heavier weights", "Warm up thoroughly before starting"], "instructions": "1. Stand with feet hip-width apart, barbell in front of you. 2. Bend at your hips and knees, keeping your back straight. 3. Grip the barbell with an overhand grip. 4. Lift the barbell by extending your hips and knees. 5. Slowly lower the barbell back to the starting position.", "progressions": ["Sumo Deadlifts", "Romanian Deadlifts"], "rest_periods": "2-3 minutes", "modifications": ["Use lighter weight", "perform rack pulls"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "not engaging core"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:41:00.281+00
24c9e275-b3c8-4d20-91e7-d24689ad7ac9	calisthenics	Barbell Back Squat (Batch 2)	{"id": "e1_batch2", "name": "Barbell Back Squat (Batch 2)", "tips": "Focus on controlled movement and maintaining proper form.", "benefits": ["Increased lower body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight.", "Warm up thoroughly."], "instructions": "1. Position barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower hips until thighs are parallel to the ground, keeping back straight and chest up. 4. Push through heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "2-3 minutes between sets", "modifications": ["Box Squats (for depth control)", "High Bar Squat (easier on lower back)"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "knees collapsing inward", "heels lifting off the ground"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:41:00.281+00
27a4f8f3-2987-4f7d-ad0e-0b630f72598e	calisthenics	Dumbbell Bench Press (Batch 2)	{"id": "e2_batch2", "name": "Dumbbell Bench Press (Batch 2)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increased chest strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a stable base and avoid jerking the weights."], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Hold dumbbells above chest, palms facing each other. 3. Lower dumbbells to chest, keeping elbows slightly bent. 4. Push dumbbells back up to starting position.", "progressions": ["Incline Dumbbell Press", "Decline Dumbbell Press"], "rest_periods": "60-90 seconds between sets", "modifications": ["Using lighter dumbbells", "Performing on an incline to reduce stress on shoulders"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "letting elbows flare out", "using too much momentum"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:41:00.281+00
dff7d5f3-6aa1-428e-bd89-bb071030b346	calisthenics	Barbell Bent-Over Row (Batch 2)	{"id": "e3_batch2", "name": "Barbell Bent-Over Row (Batch 2)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine.", "Use a spotter for heavier weights."], "instructions": "1. Bend at the hips, keeping back straight. 2. Hold barbell with an overhand grip, slightly wider than shoulder-width. 3. Pull barbell towards chest, keeping elbows close to the body. 4. Slowly lower barbell back to starting position.", "progressions": ["Pendlay Row", "One-arm Dumbbell Row"], "rest_periods": "60-90 seconds between sets", "modifications": ["Using lighter weight", "using a supported row variation"], "muscle_groups": ["Latissimus Dorsi", "Rhomboids", "Trapezius"], "common_mistakes": ["Rounding the back", "using momentum", "not pulling close enough to the body"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:41:00.281+00
ba4855b0-1427-41ac-a423-a42fef200d76	calisthenics	Cable Face Pull (Batch 2)	{"id": "e4_batch2", "name": "Cable Face Pull (Batch 2)", "tips": "Focus on squeezing your shoulder blades together.", "benefits": ["Improved posture", "Increased rear delt strength", "Reduced risk of shoulder injuries"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement throughout."], "instructions": "1. Attach a rope attachment to a cable machine at face height. 2. Stand facing the machine with a slightly wider than shoulder-width stance. 3. Pull the rope towards your face, keeping your elbows high and slightly above shoulder level. 4. Return slowly to starting position.", "progressions": ["Using heavier weight", "One arm cable face pull"], "rest_periods": "45-60 seconds between sets", "modifications": ["Using a lighter weight", "Using a wider grip"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Pulling too low", "not retracting the shoulder blades"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 15-20 reps"}	2025-07-23 12:41:00.281+00
b067d321-f923-461a-8262-fb0cd92de95e	calisthenics	Dumbbell Shoulder Press (Batch 2)	{"id": "e5_batch2", "name": "Dumbbell Shoulder Press (Batch 2)", "tips": "Maintain a controlled tempo throughout the movement.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Avoid locking out elbows at the top.", "Use a spotter if needed."], "instructions": "1. Sit or stand holding a dumbbell in each hand at shoulder height. 2. Press dumbbells upwards until arms are fully extended. 3. Lower dumbbells back to starting position in a controlled manner.", "progressions": ["Arnold Press", "Lateral Raises"], "rest_periods": "60-90 seconds between sets", "modifications": ["Seated variation for stability", "Using lighter dumbbells"], "muscle_groups": ["Deltoids", "Triceps"], "common_mistakes": ["Using momentum", "not controlling the weight on the descent"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:41:00.281+00
85891899-8751-4d0e-9658-01b8c36b71c6	calisthenics	Pull-ups (Batch 2)	{"id": "e6_batch2", "name": "Pull-ups (Batch 2)", "tips": "Focus on controlled movement and maintain a straight body.", "benefits": ["Increased upper body strength", "Improved grip strength", "Enhanced muscle growth"], "category": "Calisthenics & Bodyweight", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Ensure a secure grip.", "Start with easier variations if needed."], "instructions": "1. Grip pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang with arms fully extended. 3. Pull yourself up until chin is above the bar. 4. Slowly lower yourself back to starting position.", "progressions": ["Negative Pull-ups", "Lat Pulldowns"], "rest_periods": "2-3 minutes between sets", "modifications": ["Assisted Pull-ups (using resistance bands)", "Australian Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "not engaging the back muscles"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:41:00.281+00
f1c3f78f-9489-4d32-89fe-35644fe1908b	calisthenics	Deadlifts (conventional) (Batch 2)	{"id": "e7_batch2", "name": "Deadlifts (conventional) (Batch 2)", "tips": "Maintain a tight core and a neutral spine throughout the movement.", "benefits": ["Increased full-body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter, especially with heavy weight. Warm-up thoroughly.  Focus on proper form."], "instructions": "1. Stand with feet hip-width apart, barbell over midfoot. 2. Bend at hips and knees, keeping back straight. 3. Grip barbell with an overhand grip, slightly wider than shoulder-width. 4. Lift barbell by extending hips and knees simultaneously, keeping back straight. 5. Slowly lower barbell back to starting position.", "progressions": ["Sumo Deadlifts", "Romanian Deadlifts"], "rest_periods": "3-5 minutes between sets", "modifications": ["Trap Bar Deadlifts (easier on lower back)", "Rack Pulls (start from a higher position)"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "lifting with the back instead of legs", "not maintaining a neutral spine"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:41:00.281+00
4325e61e-ff1f-48a8-8cf0-e0d80db1db2c	calisthenics	Barbell Overhead Press (Batch 2)	{"id": "e8_batch2", "name": "Barbell Overhead Press (Batch 2)", "tips": "Focus on controlled movement and maintain a straight back.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight.  Maintain a stable base."], "instructions": "1. Stand with feet shoulder-width apart, holding barbell at chest height. 2. Press barbell overhead until arms are fully extended. 3. Slowly lower barbell back to starting position.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "90-120 seconds between sets", "modifications": ["Using lighter weight", "Seated Overhead Press for stability"], "muscle_groups": ["Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "using too much momentum", "not controlling the weight on the descent"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 6-10 reps"}	2025-07-23 12:41:00.281+00
90d3c9d0-2770-4974-8f0d-4efde48ea145	calisthenics	Dumbbell Bicep Curl (Batch 2)	{"id": "e9_batch2", "name": "Dumbbell Bicep Curl (Batch 2)", "tips": "Squeeze your biceps at the top of the movement.", "benefits": ["Increased bicep strength", "Improved arm size", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled tempo throughout the movement."], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl dumbbells towards shoulders, keeping elbows close to the body. 3. Slowly lower dumbbells back to starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "60-90 seconds between sets", "modifications": ["Using lighter dumbbells", "Seated Bicep Curls for stability"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "swinging the weights", "not controlling the weight on the descent"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:41:00.281+00
137bdd19-783c-4a48-8d0b-8d7729be6bd3	calisthenics	Cable Triceps Pushdown (Batch 2)	{"id": "e10_batch2", "name": "Cable Triceps Pushdown (Batch 2)", "tips": "Focus on squeezing your triceps at the bottom of the movement.", "benefits": ["Increased triceps strength", "Improved arm size", "Enhanced muscle growth"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled tempo throughout the movement."], "instructions": "1. Attach a rope or V-bar attachment to a cable machine at a high pulley. 2. Stand facing the machine with feet shoulder-width apart. 3. Grab the attachment and push down until your arms are fully extended. 4. Slowly return to starting position.", "progressions": ["Close-Grip Bench Press", "Overhead Triceps Extensions"], "rest_periods": "60-90 seconds between sets", "modifications": ["Using lighter weight", "Using a different attachment"], "muscle_groups": ["Triceps"], "common_mistakes": ["Using momentum", "not controlling the weight on the ascent", "bending elbows outwards"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:41:00.281+00
ec49c7e9-d68c-46bf-9f40-f3540ece85d3	bulking	Barbell Back Squat (Batch 4)	{"id": "e1-barbell-squat_batch4", "name": "Barbell Back Squat (Batch 4)", "tips": "Maintain a neutral spine throughout the movement.", "benefits": ["Builds lower body strength and mass", "Improves overall athleticism", "Increases core stability"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Warm up properly"], "instructions": "1. Position barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outwards. 3. Squat down until thighs are parallel to the ground, keeping back straight and chest up. 4. Push through heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squat (assisted)", "Use lighter weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up", "Not going deep enough"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:42:02.195+00
6bf2ec14-35f5-48c3-a6b5-77bd519fda35	bulking	Barbell Bench Press (Batch 4)	{"id": "e2-bench-press_batch4", "name": "Barbell Bench Press (Batch 4)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Builds chest strength and mass", "Increases upper body strength"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Maintain a stable base"], "instructions": "1. Lie supine on a bench with feet flat on the floor. 2. Grip barbell slightly wider than shoulder-width. 3. Lower the barbell to your chest, touching lightly. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Use lighter weight"], "muscle_groups": ["Pectorals", "Triceps", "Anterior Deltoids"], "common_mistakes": ["Arching the back excessively", "Bouncing the bar off the chest"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:42:02.195+00
40350901-f409-47d0-86b8-fd28f6e5e3f7	bulking	Barbell Bent-Over Row (Batch 4)	{"id": "e3-bent-over-row_batch4", "name": "Barbell Bent-Over Row (Batch 4)", "tips": "Focus on controlled movements.", "benefits": ["Builds back strength and thickness", "Improves posture"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine", "Use a spotter for heavier weights"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell. 2. Bend at the hips, keeping your back straight. 3. Pull the barbell towards your stomach, squeezing your shoulder blades together. 4. Slowly lower the barbell back to the starting position.", "progressions": ["Pendlay Row", "One-Arm Dumbbell Row"], "rest_periods": "60-90 seconds", "modifications": ["Chest Supported Row", "Use lighter weight"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:42:02.195+00
1a21c48a-b705-4144-a2d6-9a60989d45b3	bulking	Barbell Overhead Press (Batch 4)	{"id": "e4-overhead-press_batch4", "name": "Barbell Overhead Press (Batch 4)", "tips": "Keep your core engaged throughout the movement.", "benefits": ["Builds shoulder strength and size", "Improves overall upper body strength"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable base"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell straight overhead, locking your elbows. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Arnold Press", "Dumbbell Shoulder Press"], "rest_periods": "60-90 seconds", "modifications": ["Seated Overhead Press", "Use lighter weight"], "muscle_groups": ["Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:42:02.195+00
b75b3b74-61b5-463b-a85f-ef7c2ac4b98b	bulking	Conventional Deadlift (Batch 4)	{"id": "e5-deadlift_batch4", "name": "Conventional Deadlift (Batch 4)", "tips": "Maintain a neutral spine throughout the movement.", "benefits": ["Builds full-body strength", "Increases power and explosiveness"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter for heavier weights", "Focus on proper form"], "instructions": "1. Stand with feet hip-width apart, barbell in front of you. 2. Bend down and grip the barbell with an overhand grip, slightly wider than shoulder-width. 3. Keep your back straight and lift the barbell by extending your hips and knees simultaneously. 4. Lower the barbell back to the ground with control.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "120-180 seconds", "modifications": ["Trap Bar Deadlift", "Use lighter weight"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "Not engaging the legs sufficiently"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:42:02.195+00
3519ba6b-cbac-47cb-b9ad-5ca797151e92	bulking	Pull-ups (Batch 4)	{"id": "e6-pull-ups_batch4", "name": "Pull-ups (Batch 4)", "tips": "Focus on controlled movements.", "benefits": ["Builds back and arm strength", "Improves grip strength"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Ensure a secure grip", "Start with easier variations if needed"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Chin-ups", "Muscle-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Pull-ups (using resistance bands)", "Negative Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Trapezius"], "common_mistakes": ["Swinging", "Not fully extending arms"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3-4 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:42:02.195+00
e30700ee-6eeb-46b1-b5ab-228edeb2d52f	bulking	Parallel Bar Dips (Batch 4)	{"id": "e7-dips_batch4", "name": "Parallel Bar Dips (Batch 4)", "tips": "Keep your elbows tucked in.", "benefits": ["Builds triceps and chest strength", "Improves upper body strength"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Ensure stable bars", "Control your descent"], "instructions": "1. Grip the parallel bars with your hands shoulder-width apart. 2. Lower yourself until your elbows are at a 90-degree angle. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "Plyometric Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips (using resistance bands)", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals"], "common_mistakes": ["Leaning too far forward", "Not controlling the descent"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:42:02.195+00
023cbf0a-c4de-4150-a0d9-70bd3faa4702	bulking	Dumbbell Bicep Curl (Batch 4)	{"id": "e8-dumbbell-bicep-curl_batch4", "name": "Dumbbell Bicep Curl (Batch 4)", "tips": "Squeeze your biceps at the top of the movement.", "benefits": ["Builds bicep strength and size", "Improves arm definition"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "Avoid swinging"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl the dumbbells up towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Seated Dumbbell Curls", "Use lighter weight"], "muscle_groups": ["Biceps", "Brachialis"], "common_mistakes": ["Swinging the dumbbells", "Using momentum"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3-4 sets of 10-15 reps"}	2025-07-23 12:42:02.195+00
81f1b534-7ed8-4e93-a51d-17cb118fb560	bulking	Cable Face Pull (Batch 4)	{"id": "e9-cable-face-pull_batch4", "name": "Cable Face Pull (Batch 4)", "tips": "Focus on squeezing your shoulder blades together at the end of the movement.", "benefits": ["Builds rear deltoid strength and size", "Improves posture", "Reduces shoulder impingement risk"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain controlled movement", "Avoid jerking"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the machine with a slight bend in your knees. 3. Pull the rope towards your face, keeping your elbows high. 4. Slowly return to the starting position.", "progressions": ["Band Face Pulls", "Increase weight"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter weight", "Adjust pulley height"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Pulling the rope too low", "Not squeezing the shoulder blades"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3-4 sets of 15-20 reps"}	2025-07-23 12:42:02.195+00
2f4830cf-fc48-4e68-8b2e-a77b6e503e8b	bulking	Leg Press (Batch 4)	{"id": "e10-leg-press_batch4", "name": "Leg Press (Batch 4)", "tips": "Maintain a controlled movement throughout.", "benefits": ["Builds lower body strength and mass", "Good alternative to squats for beginners"], "category": "Bulking & Mass Gain", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Always use a spotter", "Avoid locking your knees"], "instructions": "1. Sit on the leg press machine and position your feet shoulder-width apart on the platform. 2. Push the platform away from you, extending your legs. 3. Slowly return to the starting position.", "progressions": ["Increase weight", "Vary foot placement"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Adjust foot placement"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Locking your knees at the top", "Using too much weight"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3-4 sets of 10-15 reps"}	2025-07-23 12:42:02.195+00
512c54d5-28a5-45b6-a11a-51b71233ddeb	functional	Barbell Back Squat (Batch 3)	{"id": "e1_batch3", "name": "Barbell Back Squat (Batch 3)", "tips": "Focus on controlled movements and deep range of motion.", "benefits": ["Increased lower body strength", "Improved power", "Enhanced muscle hypertrophy"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm-up properly", "Maintain proper form"], "instructions": "1. Position barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower hips as if sitting in a chair, keeping back straight. 4. Push through heels to return to standing.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squat", "Reduced weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up", "Knees collapsing inwards"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:43:46.796+00
53fd79a8-147f-400a-82a9-3e457636f43a	functional	Dumbbell Bench Press (Batch 3)	{"id": "e2_batch3", "name": "Dumbbell Bench Press (Batch 3)", "tips": "Control the movement throughout the entire range of motion.", "benefits": ["Chest muscle development", "Increased upper body strength", "Improved pushing power"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use a spotter for heavier weights", "Maintain proper form", "Avoid dropping dumbbells"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Hold dumbbells at chest height. 3. Lower dumbbells to chest, keeping elbows slightly bent. 4. Push dumbbells back up to starting position.", "progressions": ["Incline Dumbbell Press", "Decline Dumbbell Press"], "rest_periods": "60 seconds", "modifications": ["Using lighter dumbbells", "Performing on an incline"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Letting elbows flare out", "Bouncing the dumbbells"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:43:46.797+00
64618160-89e7-4a2e-9a02-f06b5f09213c	functional	Barbell Bent-Over Row (Batch 3)	{"id": "e3_batch3", "name": "Barbell Bent-Over Row (Batch 3)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle mass"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a flat back", "Use a spotter for heavier weights", "Control the movement"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell. 2. Bend at the hips, keeping back straight. 3. Pull barbell towards your chest, squeezing shoulder blades together. 4. Slowly lower the barbell back to starting position.", "progressions": ["Pendlay Row", "Chest-Supported Row"], "rest_periods": "60-90 seconds", "modifications": ["Using lighter weight", "Single-arm dumbbell row"], "muscle_groups": ["Latissimus Dorsi", "Rhomboids", "Trapezius"], "common_mistakes": ["Rounding the back", "Using momentum", "Not squeezing shoulder blades"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:43:46.797+00
c95363ea-3f31-464c-8b12-6a0ddc823da0	functional	Overhead Press (Barbell) (Batch 3)	{"id": "e4_batch3", "name": "Overhead Press (Barbell) (Batch 3)", "tips": "Control the weight throughout the entire range of motion.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Enhanced shoulder muscle mass"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain proper form", "Avoid jerking the weight"], "instructions": "1. Stand with feet shoulder-width apart, holding barbell at chest level. 2. Press barbell overhead, keeping core engaged and back straight. 3. Slowly lower barbell back to chest level.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Overhead Press", "Seated Overhead Press"], "muscle_groups": ["Shoulders", "Triceps"], "common_mistakes": ["Arching the back", "Using momentum", "Not fully extending the arms"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 6-12 reps"}	2025-07-23 12:43:46.797+00
6e181691-4105-46fa-b68d-d1b77d5eb1fb	functional	Pull-ups (Batch 3)	{"id": "e5_batch3", "name": "Pull-ups (Batch 3)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased back and arm strength", "Improved grip strength", "Enhanced muscle hypertrophy"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Ensure the bar is secure", "Use a spotter if needed", "Control the movement"], "instructions": "1. Grip pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang with arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back down.", "progressions": ["Negative pull-ups", "Assisted pull-ups"], "rest_periods": "90-120 seconds", "modifications": ["Australian pull-ups", "Lat pulldowns"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not fully extending arms", "Kipping"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "As many reps as possible (AMRAP) for 3-4 sets"}	2025-07-23 12:43:46.797+00
ea29b8e4-3a81-4785-b965-943dce6fa18a	functional	Deadlifts (Barbell) (Batch 3)	{"id": "e6_batch3", "name": "Deadlifts (Barbell) (Batch 3)", "tips": "Focus on controlled movements and maintaining a neutral spine.", "benefits": ["Increased full-body strength", "Improved power", "Enhanced muscle hypertrophy"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter for heavier weights", "Maintain proper form", "Warm-up thoroughly"], "instructions": "1. Stand with feet hip-width apart, barbell in front of you. 2. Bend down and grasp the bar with an overhand grip. 3. Keeping your back straight, lift the bar by extending your hips and knees. 4. Slowly lower the bar back to the ground.", "progressions": ["Sumo Deadlifts", "Romanian Deadlifts"], "rest_periods": "120-180 seconds", "modifications": ["Trap Bar Deadlifts", "Reduced weight"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "Using momentum", "Not engaging core"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:43:46.797+00
cee6c825-e845-48b1-9ab4-c64836c9dc44	functional	Dumbbell Lunges (Batch 3)	{"id": "e7_batch3", "name": "Dumbbell Lunges (Batch 3)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased lower body strength", "Improved balance", "Enhanced leg muscle hypertrophy"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain proper form", "Avoid overextending your knees", "Use a stable surface"], "instructions": "1. Hold dumbbells at your sides. 2. Step forward with one leg, bending both knees to 90 degrees. 3. Push off with your front foot to return to starting position. 4. Repeat with the other leg.", "progressions": ["Walking Lunges", "Jumping Lunges"], "rest_periods": "60 seconds", "modifications": ["Stationary Lunges", "Using lighter dumbbells"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Leaning too far forward", "Knees collapsing inwards", "Taking too large of a step"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-12 reps per leg"}	2025-07-23 12:43:46.797+00
bc7d0669-4e06-40d9-917a-0d138010ee8d	functional	Cable Face Pulls (Batch 3)	{"id": "e8_batch3", "name": "Cable Face Pulls (Batch 3)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Improved posture", "Increased shoulder stability", "Enhanced rear delt development"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain proper form", "Avoid jerking the weight", "Control the movement"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the machine, holding the rope with an overhand grip. 3. Pull the rope towards your face, squeezing your shoulder blades together. 4. Slowly return to starting position.", "progressions": ["Face Pulls with resistance band"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Standing further away from the machine"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Using momentum", "Not squeezing shoulder blades", "Pulling too far back"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 15-20 reps"}	2025-07-23 12:43:46.797+00
a051b790-4029-43d7-a2a9-7bbe91e3aaaa	functional	Incline Dumbbell Bicep Curls (Batch 3)	{"id": "e9_batch3", "name": "Incline Dumbbell Bicep Curls (Batch 3)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased bicep strength", "Enhanced bicep size", "Improved grip strength"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain proper form", "Avoid jerking the weight", "Use a controlled movement"], "instructions": "1. Sit on an incline bench, holding dumbbells. 2. Curl dumbbells towards your shoulders, keeping elbows close to your sides. 3. Slowly lower dumbbells back to starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter dumbbells", "Seated bicep curls"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Arching the back", "Not controlling the negative"], "equipment_needed": ["Dumbbells", "Incline Bench"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:43:46.797+00
ef946f51-6d45-4c0f-8dc7-024f4f8a8017	functional	Triceps Pushdowns (Cable) (Batch 3)	{"id": "e10_batch3", "name": "Triceps Pushdowns (Cable) (Batch 3)", "tips": "Focus on controlled movements and full range of motion.", "benefits": ["Increased triceps strength", "Enhanced triceps size", "Improved pushing power"], "category": "Strength Training", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain proper form", "Avoid jerking the weight", "Control the movement"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the machine, holding the rope with an overhand grip. 3. Extend your arms downwards, keeping your elbows close to your sides. 4. Slowly return to starting position.", "progressions": ["Close-Grip Bench Press", "Overhead Triceps Extensions"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Using a straight bar attachment"], "muscle_groups": ["Triceps"], "common_mistakes": ["Using momentum", "Arching the back", "Not fully extending arms"], "equipment_needed": ["Cable Machine", "Rope Attachment"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:43:46.797+00
d1340de9-73eb-47e1-9dd7-2f57a4f75d29	functional	Barbell Back Squat (Batch 4)	{"id": "ex1-barbell-squat_batch4", "name": "Barbell Back Squat (Batch 4)", "tips": "Focus on controlled movements and maintaining a stable core.", "benefits": ["Increased lower body strength", "Improved power", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight", "Maintain proper form throughout the movement"], "instructions": "1. Position barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower hips until thighs are parallel to the ground, maintaining a straight back. 4. Push through heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squat (to practice depth)", "Using lighter weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Knees collapsing inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:43:46.797+00
2b66a24a-9ca9-47b3-9157-1e00fe471a49	functional	Barbell Bench Press (Batch 4)	{"id": "ex2-bench-press_batch4", "name": "Barbell Bench Press (Batch 4)", "tips": "Squeeze chest at the top of the movement.", "benefits": ["Increased chest strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight", "Maintain controlled movements"], "instructions": "1. Lie supine on a bench with feet flat on the floor. 2. Grip barbell slightly wider than shoulder-width. 3. Lower barbell to chest, touching lightly. 4. Push barbell back up to starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Using lighter weight"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching back excessively", "Letting the elbows flare out"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:43:46.797+00
67cb9c72-9244-4197-8e41-21d8f52970b0	functional	Barbell Bent-Over Row (Batch 4)	{"id": "ex3-bent-over-row_batch4", "name": "Barbell Bent-Over Row (Batch 4)", "tips": "Squeeze shoulder blades together at the top of the movement.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle mass"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a straight back", "Use a spotter for heavier weights"], "instructions": "1. Stand with feet shoulder-width apart, holding barbell with an overhand grip. 2. Bend at the hips, maintaining a straight back. 3. Pull barbell towards abdomen, keeping elbows close to the body. 4. Lower barbell back to starting position.", "progressions": ["Pendlay Row", "Chest Supported Row"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bent-Over Row", "Using lighter weight"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum instead of controlled movement"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:43:46.797+00
b8aa4d3a-0439-4118-81c9-e90483dddcec	functional	Barbell Overhead Press (Batch 4)	{"id": "ex4-overhead-press_batch4", "name": "Barbell Overhead Press (Batch 4)", "tips": "Maintain controlled movements throughout the entire range of motion.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter for heavier weights", "Maintain a stable core"], "instructions": "1. Stand with feet shoulder-width apart, holding barbell at shoulder height. 2. Press barbell overhead, fully extending arms. 3. Lower barbell back to shoulder height.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Overhead Press", "Using lighter weight"], "muscle_groups": ["Deltoids", "Triceps", "Trapezius"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:43:46.797+00
5491ba24-43da-41ff-9f80-698c89b735b4	functional	Conventional Deadlift (Batch 4)	{"id": "ex5-deadlift_batch4", "name": "Conventional Deadlift (Batch 4)", "tips": "Focus on maintaining a neutral spine throughout the lift.", "benefits": ["Increased full-body strength", "Improved power", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use proper form", "Use a spotter for heavier weights", "Warm up thoroughly"], "instructions": "1. Stand with feet hip-width apart, barbell in front of you. 2. Bend at the hips and knees, keeping your back straight. 3. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 4. Lift the barbell off the ground by extending your hips and knees simultaneously. 5. Lower the barbell back to the ground by reversing the movement.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "120-180 seconds", "modifications": ["Rack Pulls", "Using lighter weight"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "Not engaging the core"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:43:46.797+00
1d762c8a-6701-437d-9718-3ca9c3b706fe	functional	Pull-ups (Batch 4)	{"id": "ex6-pull-ups_batch4", "name": "Pull-ups (Batch 4)", "tips": "Focus on controlled movements and a full range of motion.", "benefits": ["Increased back and bicep strength", "Improved grip strength", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain proper form", "Ensure a secure grip"], "instructions": "1. Grip pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang with arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Chin-ups", "Muscle-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Pull-ups (using resistance bands)", "Negative Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not fully extending arms at the bottom"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3 sets to failure"}	2025-07-23 12:43:46.797+00
e1d291da-6a46-4b3d-84dd-762a8c41e011	functional	Dips (Parallel Bars) (Batch 4)	{"id": "ex7-dips_batch4", "name": "Dips (Parallel Bars) (Batch 4)", "tips": "Focus on controlled movements and a full range of motion.", "benefits": ["Increased triceps and chest strength", "Improved upper body power", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain proper form", "Control the descent"], "instructions": "1. Grip parallel bars with arms fully extended. 2. Lower your body by bending your elbows. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "Archer Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips (using resistance bands)", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals", "Anterior Deltoids"], "common_mistakes": ["Arching the back", "Not going deep enough"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3 sets to failure"}	2025-07-23 12:43:46.797+00
2056e88c-e6d3-47e9-ab7c-a31157b4890f	functional	Dumbbell Bicep Curl (Batch 4)	{"id": "ex8-dumbbell-bicep-curl_batch4", "name": "Dumbbell Bicep Curl (Batch 4)", "tips": "Focus on squeezing your biceps at the top of the movement.", "benefits": ["Increased bicep strength", "Improved arm size", "Enhanced muscle definition"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain controlled movements", "Avoid swinging the dumbbells"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl the dumbbells towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Seated Bicep Curls", "Using lighter weight"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Swinging the dumbbells"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:43:46.797+00
669b3644-fa0c-4e6a-8146-f9fa7cde9b2a	functional	Cable Flyes (Batch 4)	{"id": "ex9-cable-flyes_batch4", "name": "Cable Flyes (Batch 4)", "tips": "Focus on a controlled movement and a full range of motion.", "benefits": ["Increased chest strength", "Improved muscle definition", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain controlled movements", "Avoid swinging the weights"], "instructions": "1. Stand facing the cable machine, holding a handle in each hand. 2. Extend your arms out to the sides, keeping a slight bend in your elbows. 3. Bring your arms together in front of you, squeezing your chest muscles. 4. Slowly return to the starting position.", "progressions": ["Decline Cable Flyes", "Incline Cable Flyes"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Adjusting the cable height"], "muscle_groups": ["Pectorals"], "common_mistakes": ["Using momentum", "Not fully extending arms"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:43:46.797+00
cd750f1b-44ba-4df2-8bdb-c8cefb143138	functional	Leg Press (Batch 4)	{"id": "ex10-leg-press_batch4", "name": "Leg Press (Batch 4)", "tips": "Focus on a controlled movement and a full range of motion.", "benefits": ["Increased lower body strength", "Improved leg size", "Enhanced muscle hypertrophy"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain controlled movements", "Use a spotter if necessary"], "instructions": "1. Sit on the leg press machine, placing your feet shoulder-width apart on the platform. 2. Push the platform away from you, extending your legs. 3. Slowly return the platform to the starting position.", "progressions": ["Weighted squats", "Bulgarian split squats"], "rest_periods": "60-90 seconds", "modifications": ["Using lighter weight", "Adjusting foot placement"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Using too much weight", "Not fully extending legs"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:43:46.797+00
0a6f8408-4765-4b3c-bcc7-06cd7cf7c65d	strength-building	Barbell Back Squat (Batch 1)	{"id": "ex1-barbell-squat_batch1", "name": "Barbell Back Squat (Batch 1)", "tips": "Maintain a neutral spine throughout the movement. Focus on controlled movements.", "benefits": ["Builds lower body strength and power", "Increases muscle mass in legs and glutes", "Improves overall athleticism"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Use proper form"], "instructions": "1. Place barbell across upper back, slightly below traps. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Squat down until thighs are parallel to the ground, keeping back straight and core engaged. 4. Push through heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Perform box squats"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up instead of forward", "Not going deep enough"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:47:03.043+00
fd57bc20-85fa-43a9-9938-488fa18b8f16	strength-building	Barbell Bench Press (Batch 1)	{"id": "ex2-bench-press_batch1", "name": "Barbell Bench Press (Batch 1)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increases chest size and strength", "Develops upper body power", "Builds triceps mass"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain controlled movement"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Grip the barbell slightly wider than shoulder-width apart. 3. Lower the barbell to your chest, keeping your elbows slightly bent. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Use dumbbell bench press", "Reduce weight"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back excessively", "Letting the bar bounce off the chest", "Not fully extending arms at the top"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:47:03.043+00
16138bae-e8a1-4f2c-916f-3aac9c536d3e	strength-building	Conventional Deadlift (Batch 1)	{"id": "ex3-deadlift_batch1", "name": "Conventional Deadlift (Batch 1)", "tips": "Maintain a neutral spine throughout the lift. Focus on driving through your heels.", "benefits": ["Builds full-body strength and power", "Increases muscle mass in posterior chain", "Improves grip strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter (especially for heavier weights)", "Warm up properly", "Focus on proper form"], "instructions": "1. Stand with feet hip-width apart, barbell over midfoot. 2. Bend at the hips and knees, keeping back straight, grip the bar with an overhand grip (slightly wider than shoulder-width). 3. Lift the bar by extending hips and knees simultaneously, maintaining a straight back. 4. Lower the bar back to the floor with controlled movement.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "2-3 minutes", "modifications": ["Use lighter weight", "Perform rack pulls"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Traps"], "common_mistakes": ["Rounding the back", "Not engaging the core", "Pulling with the arms instead of legs"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:47:03.043+00
e903d387-79ca-4812-bff2-1ee5c8b73f7d	strength-building	Barbell Overhead Press (Batch 1)	{"id": "ex4-overhead-press_batch1", "name": "Barbell Overhead Press (Batch 1)", "tips": "Engage your core throughout the movement.", "benefits": ["Builds shoulder strength and size", "Improves upper body strength", "Increases overall stability"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain controlled movement"], "instructions": "1. Stand with feet shoulder-width apart, holding barbell at chest height. 2. Press the barbell overhead, fully extending your arms. 3. Slowly lower the barbell back to your chest.", "progressions": ["Arnold Press", "Dumbbell Shoulder Press"], "rest_periods": "60-90 seconds", "modifications": ["Use lighter weight", "Perform seated overhead press"], "muscle_groups": ["Shoulders", "Triceps"], "common_mistakes": ["Arching the back", "Using momentum", "Not fully extending arms"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
c7f6b381-c881-488f-9ef2-ff70054d946b	strength-building	Barbell Bent-Over Rows (Batch 1)	{"id": "ex5-bent-over-rows_batch1", "name": "Barbell Bent-Over Rows (Batch 1)", "tips": "Focus on controlled movement and feeling the muscles work.", "benefits": ["Builds back thickness and width", "Improves posture", "Increases pulling strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine", "Use controlled movements"], "instructions": "1. Bend at the hips with a slightly bent knees, keeping your back straight. 2. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 3. Pull the barbell towards your abdomen, keeping your elbows close to your body. 4. Slowly lower the barbell back to the starting position.", "progressions": ["Pendlay Rows", "Chest Supported Rows"], "rest_periods": "60-90 seconds", "modifications": ["Use dumbbells", "Use a cable row machine"], "muscle_groups": ["Latissimus Dorsi (Back)", "Rhomboids", "Trapezius"], "common_mistakes": ["Rounding the back", "Using momentum", "Not squeezing the shoulder blades together"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
a1ef59dd-07ae-425f-9d77-4895b065bb91	strength-building	Pull-ups (Batch 1)	{"id": "ex6-pull-ups_batch1", "name": "Pull-ups (Batch 1)", "tips": "Focus on controlled movement and feeling the muscles work.", "benefits": ["Builds back strength and size", "Improves grip strength", "Develops overall upper body strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter if needed", "Warm up properly"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang from the bar with your arms fully extended. 3. Pull yourself up until your chin is above the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Negative Pull-ups", "Assisted Pull-ups"], "rest_periods": "90-120 seconds", "modifications": ["Use an assisted pull-up machine", "Perform lat pulldowns"], "muscle_groups": ["Latissimus Dorsi (Back)", "Biceps", "Forearms"], "common_mistakes": ["Swinging", "Not engaging the back muscles", "Not fully extending arms at the bottom"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3 sets to failure"}	2025-07-23 12:47:03.043+00
8473d444-5a88-4265-8e42-614c1e5d505e	strength-building	Dips (Parallel Bars) (Batch 1)	{"id": "ex7-dips_batch1", "name": "Dips (Parallel Bars) (Batch 1)", "tips": "Focus on controlled movement and feeling the muscles work.", "benefits": ["Builds triceps strength and size", "Develops chest and shoulder muscles", "Improves upper body strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use controlled movements", "Don't bounce at the bottom"], "instructions": "1. Grip the parallel bars with your hands shoulder-width apart. 2. Lower yourself down until your elbows are at a 90-degree angle. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "Close-Grip Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals", "Anterior Deltoids"], "common_mistakes": ["Leaning forward too much", "Not going deep enough", "Using momentum"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
f261a77f-5ac2-4af5-b81b-d6b083e2b7d6	strength-building	Dumbbell Bicep Curls (Batch 1)	{"id": "ex8-dumbbell-bicep-curls_batch1", "name": "Dumbbell Bicep Curls (Batch 1)", "tips": "Focus on controlled movement and feeling the muscles work.", "benefits": ["Builds bicep size and strength", "Improves arm definition", "Increases grip strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use controlled movements", "Avoid jerking the weights"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl the dumbbells up towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Use lighter weight", "Use a seated position"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Swinging the dumbbells", "Not fully extending arms at the bottom"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
8642fa09-a09d-4cd0-a0f8-fd59bfd432ac	strength-building	Cable Face Pulls (Batch 1)	{"id": "ex9-cable-face-pulls_batch1", "name": "Cable Face Pulls (Batch 1)", "tips": "Focus on feeling the muscles work in your rear deltoids.", "benefits": ["Improves posture", "Strengthens rear deltoids", "Prevents shoulder injuries"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use controlled movements", "Avoid jerking the weight"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the cable machine with a slight bend in your knees. 3. Grip the rope with an overhand grip, slightly wider than shoulder-width. 4. Pull the rope towards your face, keeping your elbows high. 5. Slowly return to the starting position.", "progressions": ["Increase weight", "Use a thicker rope"], "rest_periods": "45-60 seconds", "modifications": ["Use a lighter weight", "Use a single-handle attachment"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Pulling with the arms instead of the back", "Not squeezing the shoulder blades together", "Using too much weight"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 15-20 reps"}	2025-07-23 12:47:03.043+00
13cb2caf-c8b5-40d6-8000-b06467cad7e8	strength-building	Leg Press (Batch 1)	{"id": "ex10-leg-press_batch1", "name": "Leg Press (Batch 1)", "tips": "Focus on controlled movement and feeling the muscles work.", "benefits": ["Builds leg strength and size", "Lowers the risk of injury compared to free weight squats", "Great for building overall lower body mass"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Always use a spotter when performing heavy leg presses", "Use controlled movements"], "instructions": "1. Sit on the leg press machine and place your feet shoulder-width apart on the platform. 2. Push the platform away from you until your legs are fully extended. 3. Slowly return to the starting position.", "progressions": ["Increase weight", "Use a narrower stance"], "rest_periods": "60-90 seconds", "modifications": ["Use a lighter weight", "Use a wider stance"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Using too much weight", "Not fully extending legs", "Not engaging the glutes"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3-4 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
2e1c5785-c49a-4f88-a95d-de4a71096b55	strength-building	Barbell Back Squat (Batch 2)	{"id": "e1-barbell-squat_batch2", "name": "Barbell Back Squat (Batch 2)", "tips": "Focus on controlled movements and deep breathing.", "benefits": ["Increased lower body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain proper form"], "instructions": "1. Position the barbell across your upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower your hips as if sitting in a chair, keeping your back straight and chest up. 4. Push through your heels to return to the starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squat", "Using lighter weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up", "Knees caving inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:47:03.043+00
e9b22f41-be1a-404b-b62b-382d1064a41d	strength-building	Barbell Bench Press (Batch 2)	{"id": "e2-bench-press_batch2", "name": "Barbell Bench Press (Batch 2)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increased chest strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain proper form"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Grip the barbell slightly wider than shoulder-width. 3. Lower the barbell to your chest, keeping your elbows slightly bent. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Using lighter weight"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Bouncing the barbell off the chest", "Using excessive weight"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:47:03.043+00
bf1fd926-62a2-470e-b1fb-233d973594e7	strength-building	Barbell Bent-Over Row (Batch 2)	{"id": "e3-bent-over-row_batch2", "name": "Barbell Bent-Over Row (Batch 2)", "tips": "Focus on a controlled movement and full range of motion.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a flat back", "Use proper grip", "Control the weight"], "instructions": "1. Bend at the hips with a straight back, holding a barbell. 2. Pull the barbell towards your abdomen, keeping your elbows close to your body. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Pendlay Row", "Chest Supported Row"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Row", "Using lighter weight"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum", "Not squeezing the shoulder blades"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
f3fd2434-d285-4cb5-83fb-923c0f145dd8	strength-building	Barbell Overhead Press (Batch 2)	{"id": "e4-overhead-press_batch2", "name": "Barbell Overhead Press (Batch 2)", "tips": "Keep your core engaged throughout the movement.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain proper form"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell at shoulder height. 2. Press the barbell overhead, fully extending your arms. 3. Slowly lower the barbell back to the starting position.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Shoulder Press", "Using lighter weight"], "muscle_groups": ["Deltoids", "Triceps", "Trapezius"], "common_mistakes": ["Arching the back", "Using momentum", "Not locking out your elbows"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
f1fe69b5-b4cf-4ca3-95db-00e4beec46c6	strength-building	Conventional Deadlift (Batch 2)	{"id": "e5-deadlift_batch2", "name": "Conventional Deadlift (Batch 2)", "tips": "Focus on a controlled movement and full range of motion.", "benefits": ["Increased full-body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use a spotter", "Warm up properly", "Maintain proper form"], "instructions": "1. Stand with feet hip-width apart, holding a barbell. 2. Bend at the hips and knees, keeping your back straight. 3. Grip the barbell with an overhand grip. 4. Lift the barbell by extending your hips and knees simultaneously. 5. Slowly lower the barbell back to the starting position.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "120-180 seconds", "modifications": ["Trap Bar Deadlift", "Using lighter weight"], "muscle_groups": ["Glutes", "Hamstrings", "Lower Back", "Trapezius"], "common_mistakes": ["Rounding the back", "Using momentum", "Not engaging the core"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:47:03.043+00
d6b96d13-8f1b-4292-b706-e17a65f1af37	strength-building	Pull-ups (Batch 2)	{"id": "e6-pull-ups_batch2", "name": "Pull-ups (Batch 2)", "tips": "Focus on a controlled movement and full range of motion.", "benefits": ["Increased back strength", "Improved grip strength", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Ensure a secure grip", "Warm up properly"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang from the bar with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Muscle-ups", "Weighted Pull-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Pull-ups", "Negative Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not fully extending your arms", "Not engaging your back muscles"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3-4 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:47:03.043+00
e6aef04d-3088-4a4c-95c4-3c3d9e861dd0	strength-building	Dips (Parallel Bars) (Batch 2)	{"id": "e7-dips_batch2", "name": "Dips (Parallel Bars) (Batch 2)", "tips": "Focus on a controlled movement and full range of motion.", "benefits": ["Increased triceps strength", "Improved chest strength", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a stable position", "Control the movement"], "instructions": "1. Position yourself between the parallel bars, gripping the bars with your hands shoulder-width apart. 2. Lower your body by bending your elbows until your upper arms are parallel to the floor. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "One-arm Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals", "Anterior Deltoids"], "common_mistakes": ["Arching the back", "Not fully extending your arms", "Using momentum"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
2809efa9-0841-4ef0-8012-e57d90d1c9ea	strength-building	Dumbbell Bicep Curls (Batch 2)	{"id": "e8-dumbbell-bicep-curls_batch2", "name": "Dumbbell Bicep Curls (Batch 2)", "tips": "Focus on a controlled movement and full range of motion.", "benefits": ["Increased biceps strength", "Improved arm definition", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain proper form", "Avoid swinging the weights"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl the dumbbells towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Seated Dumbbell Curls", "Using lighter weight"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Arching the back", "Not controlling the weight"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
962176cd-eecc-4c9a-8268-b2db66f4efce	strength-building	Cable Face Pulls (Batch 2)	{"id": "e9-cable-face-pulls_batch2", "name": "Cable Face Pulls (Batch 2)", "tips": "Focus on a controlled movement and full range of motion.", "benefits": ["Improved shoulder health", "Increased rear delt strength", "Enhanced posture"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain proper form", "Control the weight"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the machine with a slightly wider than shoulder-width stance. 3. Pull the rope towards your face, keeping your elbows high and slightly flared out. 4. Slowly return to the starting position.", "progressions": ["Face Pulls with resistance bands", "Weighted Face Pulls"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Closer grip"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Pulling too low", "Using momentum", "Not squeezing the shoulder blades"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 15-20 reps"}	2025-07-23 12:47:03.043+00
858359d5-6373-4c73-a0e9-be1fd483b2d8	strength-building	Leg Press (Batch 2)	{"id": "e10-leg-press_batch2", "name": "Leg Press (Batch 2)", "tips": "Focus on a controlled movement and full range of motion.", "benefits": ["Increased lower body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use proper form", "Avoid locking out your knees"], "instructions": "1. Sit on the leg press machine and position your feet shoulder-width apart on the platform. 2. Push the platform away from you by extending your legs. 3. Slowly return to the starting position.", "progressions": ["Plate-loaded Leg Press", "Incline Leg Press"], "rest_periods": "60-90 seconds", "modifications": ["Using lighter weight", "Adjusting foot placement"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Using too much weight", "Not fully extending your legs", "Locking out your knees"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
5f9cc416-f8c8-47a2-8c9c-ac0c4ee7f789	strength-building	Barbell Back Squat (Batch 3)	{"id": "e1-barbell-squat_batch3", "name": "Barbell Back Squat (Batch 3)", "tips": "Focus on controlled movements and maintaining proper form.", "benefits": ["Builds lower body strength and power", "Increases muscle mass in legs and glutes", "Improves overall athleticism"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight", "Warm-up thoroughly before starting"], "instructions": "1. Position barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Squat down until thighs are parallel to the ground, keeping back straight and chest up. 4. Push through heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squats (for depth control)", "Using lighter weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Looking up", "Not going deep enough"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:47:03.043+00
9e08b2fc-721f-4d69-b1f1-66e26a73373d	strength-building	Barbell Bench Press (Batch 3)	{"id": "e2-bench-press_batch3", "name": "Barbell Bench Press (Batch 3)", "tips": "Focus on squeezing your chest at the top of the movement.", "benefits": ["Develops chest strength and size", "Increases upper body power", "Builds triceps muscle mass"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavy weight", "Maintain a stable and controlled movement"], "instructions": "1. Lie on a bench with feet flat on the floor. 2. Grip barbell slightly wider than shoulder-width. 3. Lower the barbell to your chest, keeping your elbows slightly bent. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Using lighter weight"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back excessively", "Not lowering the bar fully", "Using too much weight"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3-4 sets of 6-12 reps"}	2025-07-23 12:47:03.043+00
8bc6c0b2-8121-419a-876f-ffd077ab0c7e	strength-building	Barbell Bent-Over Row (Batch 3)	{"id": "e3-bent-over-row_batch3", "name": "Barbell Bent-Over Row (Batch 3)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Develops back strength and thickness", "Improves posture", "Increases pulling power"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a straight back", "Use proper form to avoid injury"], "instructions": "1. Stand with feet shoulder-width apart, holding a barbell. 2. Bend at the hips, keeping your back straight. 3. Pull the barbell towards your abdomen, keeping your elbows close to your body. 4. Slowly lower the barbell back to the starting position.", "progressions": ["Pendlay Row", "Chest Supported Row"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Row", "Using lighter weight"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum", "Not engaging the back muscles"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
4df18c06-82f5-460e-9c1a-57a603be8298	strength-building	Dumbbell Overhead Press (Batch 3)	{"id": "e4-overhead-press_batch3", "name": "Dumbbell Overhead Press (Batch 3)", "tips": "Maintain a stable core throughout the movement.", "benefits": ["Builds shoulder strength and size", "Improves overall upper body strength", "Increases stability"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use a spotter if needed", "Control the weight at all times"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Press the dumbbells overhead, keeping your elbows slightly bent. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Barbell Overhead Press", "Arnold Press"], "rest_periods": "60 seconds", "modifications": ["Seated Overhead Press", "Using lighter weight"], "muscle_groups": ["Deltoids", "Triceps"], "common_mistakes": ["Using too much weight", "Arching the back", "Not controlling the descent"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
f80d8a45-1b9c-4f23-8fab-bf6bdfaf9c92	strength-building	Romanian Deadlift (Batch 3)	{"id": "e5-deadlift_batch3", "name": "Romanian Deadlift (Batch 3)", "tips": "Focus on controlled movements and maintaining proper form.", "benefits": ["Develops posterior chain strength", "Increases hamstring and glute size", "Improves overall strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine", "Use a spotter if needed"], "instructions": "1. Stand with feet hip-width apart, holding a barbell in front of you. 2. Hinge at your hips, keeping your back straight. 3. Lower the barbell towards the ground, keeping a slight bend in your knees. 4. Push through your heels to return to the starting position.", "progressions": ["Conventional Deadlift", "Sumo Deadlift"], "rest_periods": "90-120 seconds", "modifications": ["Dumbbell Romanian Deadlift", "Using lighter weight"], "muscle_groups": ["Hamstrings", "Glutes", "Lower Back"], "common_mistakes": ["Rounding the back", "Using momentum", "Not engaging the glutes"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3-4 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
42b5c865-f608-49f7-82fe-c78a8c9dc9cd	strength-building	Pull-ups (Batch 3)	{"id": "e6-pull-ups_batch3", "name": "Pull-ups (Batch 3)", "tips": "Focus on controlled movements and maintaining proper form.", "benefits": ["Develops back and arm strength", "Improves grip strength", "Increases overall body strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Start with assisted pull-ups if needed", "Control the descent"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Negative Pull-ups", "Assisted Pull-ups"], "rest_periods": "60-90 seconds", "modifications": ["Lat Pulldowns (machine)", "Australian Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Swinging", "Not fully extending arms", "Using momentum"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:47:03.043+00
76f113a5-0140-4608-a804-2c01e66d396d	strength-building	Dips (Batch 3)	{"id": "e7-dips_batch3", "name": "Dips (Batch 3)", "tips": "Focus on controlled movements and maintaining proper form.", "benefits": ["Builds triceps and chest strength", "Increases upper body pushing power", "Improves overall body strength"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Control the descent", "Maintain a stable core"], "instructions": "1. Position yourself on a dip station with hands gripping the bars, slightly wider than shoulder-width. 2. Lower yourself down until your elbows are at a 90-degree angle. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "Close-Grip Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals", "Anterior Deltoids"], "common_mistakes": ["Leaning too far forward", "Not going deep enough", "Using momentum"], "equipment_needed": ["Dip Station"], "sets_reps_guidance": "3 sets of AMRAP"}	2025-07-23 12:47:03.043+00
7721da79-d1b6-407c-938d-24e27075eb75	strength-building	Cable Rows (Batch 3)	{"id": "e8-cable-rows_batch3", "name": "Cable Rows (Batch 3)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Develops back strength and thickness", "Improves posture", "Increases pulling power"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a straight back", "Avoid jerky movements"], "instructions": "1. Sit at the cable machine with feet flat on the floor. 2. Grip the cable handle with an overhand grip. 3. Pull the handle towards your abdomen, keeping your back straight. 4. Slowly return to the starting position.", "progressions": ["One-Arm Cable Rows", "Close-Grip Cable Rows"], "rest_periods": "60 seconds", "modifications": ["Using lighter weight", "Adjusting the seat height"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum", "Not engaging the back muscles"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
dbe360f7-7d5e-43c7-b54e-34680a6b295f	strength-building	Leg Press (Batch 3)	{"id": "e9-leg-press_batch3", "name": "Leg Press (Batch 3)", "tips": "Maintain a controlled movement throughout the exercise.", "benefits": ["Builds lower body strength and power", "Increases muscle mass in legs and glutes", "Improves overall athleticism"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Always use proper form", "Avoid locking out your knees"], "instructions": "1. Sit on the leg press machine with your back against the backrest. 2. Place your feet shoulder-width apart on the platform. 3. Push the platform away from you, extending your legs. 4. Slowly return to the starting position.", "progressions": ["Increase weight", "Vary foot placement"], "rest_periods": "60 seconds", "modifications": ["Use lighter weight", "Adjust foot placement"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Using too much weight", "Not fully extending legs", "Locking out knees"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
a94f46a4-776d-46b5-b9a9-fc5f9816a7ab	strength-building	Dumbbell Lateral Raises (Batch 3)	{"id": "e10-lateral-raises_batch3", "name": "Dumbbell Lateral Raises (Batch 3)", "tips": "Focus on squeezing your shoulder muscles at the top of the movement.", "benefits": ["Develops shoulder width and definition", "Improves shoulder stability", "Increases overall upper body aesthetics"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Use a controlled movement", "Avoid swinging the weights"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Raise your arms to the sides, keeping a slight bend in your elbows. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Cable Lateral Raises", "Arnold Press"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Seated Lateral Raises"], "muscle_groups": ["Lateral Deltoids", "Anterior Deltoids"], "common_mistakes": ["Using too much weight", "Swinging the arms", "Not controlling the descent"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 12-15 reps"}	2025-07-23 12:47:03.043+00
cdf5e233-3714-469d-bea4-1c64899b2573	strength-building	Barbell Back Squat (Batch 4)	{"id": "e1-barbell-squat_batch4", "name": "Barbell Back Squat (Batch 4)", "tips": "Focus on controlled movements and proper form.", "benefits": ["Increased lower body strength", "Improved athletic performance", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Maintain a stable core throughout the movement"], "instructions": "1. Place barbell across upper back. 2. Stand with feet shoulder-width apart, toes slightly outward. 3. Lower your hips as if sitting in a chair, keeping your back straight. 4. Push through your heels to return to starting position.", "progressions": ["Goblet Squat", "Front Squat"], "rest_periods": "60-90 seconds", "modifications": ["Box Squat", "Using lighter weight"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Rounding the back", "Knees collapsing inward"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
1d11a8ab-5a88-498b-99b0-81be53ce78f0	strength-building	Barbell Bench Press (Batch 4)	{"id": "e2-bench-press_batch4", "name": "Barbell Bench Press (Batch 4)", "tips": "Squeeze your chest at the top of the movement.", "benefits": ["Increased chest strength", "Improved upper body power", "Enhanced muscle mass"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Maintain a stable core throughout the movement"], "instructions": "1. Lie supine on a bench with feet flat on the floor. 2. Grip the barbell slightly wider than shoulder-width. 3. Lower the barbell to your chest, keeping your elbows slightly bent. 4. Push the barbell back up to the starting position.", "progressions": ["Incline Bench Press", "Decline Bench Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Bench Press", "Using lighter weight"], "muscle_groups": ["Pectorals", "Anterior Deltoids", "Triceps"], "common_mistakes": ["Arching the back", "Letting the barbell bounce off the chest"], "equipment_needed": ["Barbell", "Bench"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
8a5efb84-d656-4819-ac74-b534eb33219b	strength-building	Bent-Over Barbell Row (Batch 4)	{"id": "e3-bent-over-row_batch4", "name": "Bent-Over Barbell Row (Batch 4)", "tips": "Squeeze your shoulder blades together at the top of the movement.", "benefits": ["Increased back strength", "Improved posture", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a neutral spine", "Avoid jerking the weight"], "instructions": "1. Bend at the hips, keeping your back straight. 2. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 3. Pull the barbell towards your abdomen, keeping your elbows close to your body. 4. Lower the barbell back to the starting position.", "progressions": ["Pull-ups", "Pendlay Row"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Rows", "Using lighter weight"], "muscle_groups": ["Latissimus Dorsi", "Trapezius", "Rhomboids"], "common_mistakes": ["Rounding the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
181ffdf3-1b44-4db4-8ec4-e83998af9d9e	strength-building	Overhead Barbell Press (Batch 4)	{"id": "e4-overhead-press_batch4", "name": "Overhead Barbell Press (Batch 4)", "tips": "Control the descent of the barbell.", "benefits": ["Increased shoulder strength", "Improved upper body power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Use a spotter, especially with heavier weights", "Maintain a stable core throughout the movement"], "instructions": "1. Stand with feet shoulder-width apart, holding the barbell at chest height. 2. Press the barbell overhead, keeping your core engaged. 3. Slowly lower the barbell back to your chest.", "progressions": ["Arnold Press", "Push Press"], "rest_periods": "60-90 seconds", "modifications": ["Dumbbell Shoulder Press", "Using lighter weight"], "muscle_groups": ["Shoulders", "Triceps"], "common_mistakes": ["Arching the back", "Using momentum"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
e85d68c2-b88f-4566-a3ac-37fd34ad47e7	strength-building	Conventional Deadlift (Batch 4)	{"id": "e5-deadlift_batch4", "name": "Conventional Deadlift (Batch 4)", "tips": "Focus on maintaining a neutral spine throughout the lift.", "benefits": ["Full body strength", "Improved power", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "advanced", "safety_tips": ["Use proper lifting technique", "Warm-up thoroughly"], "instructions": "1. Stand with feet hip-width apart, barbell over midfoot. 2. Bend at the hips and knees, maintaining a straight back. 3. Grip the barbell with an overhand grip, slightly wider than shoulder-width. 4. Lift the barbell by extending your hips and knees simultaneously. 5. Lower the barbell back to the floor with control.", "progressions": ["Sumo Deadlift", "Romanian Deadlift"], "rest_periods": "120-180 seconds", "modifications": ["Trap Bar Deadlift", "Using lighter weight"], "muscle_groups": ["Posterior Chain (Glutes, Hamstrings, Lower Back)"], "common_mistakes": ["Rounding the back", "Lifting with the back"], "equipment_needed": ["Barbell"], "sets_reps_guidance": "1-3 sets of 1-5 reps"}	2025-07-23 12:47:03.043+00
6c379b3a-6a51-4564-b45a-680495e4f082	strength-building	Pull-ups (Batch 4)	{"id": "e6-pull-ups_batch4", "name": "Pull-ups (Batch 4)", "tips": "Focus on squeezing your shoulder blades together at the top of the movement.", "benefits": ["Increased back and arm strength", "Improved grip strength", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Avoid jerking the body"], "instructions": "1. Grip the pull-up bar with an overhand grip, slightly wider than shoulder-width. 2. Hang from the bar with your arms fully extended. 3. Pull yourself up until your chin is over the bar. 4. Slowly lower yourself back to the starting position.", "progressions": ["Muscle-ups", "Weighted Pull-ups"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Pull-ups", "Negative Pull-ups"], "muscle_groups": ["Latissimus Dorsi", "Biceps", "Forearms"], "common_mistakes": ["Using momentum", "Not fully extending arms"], "equipment_needed": ["Pull-up Bar"], "sets_reps_guidance": "3 sets of as many reps as possible (AMRAP)"}	2025-07-23 12:47:03.043+00
649c6619-6406-4919-b4a1-cc43dfccfc28	strength-building	Parallel Bar Dips (Batch 4)	{"id": "e7-dips_batch4", "name": "Parallel Bar Dips (Batch 4)", "tips": "Focus on controlling the descent and keeping your elbows tucked in.", "benefits": ["Increased triceps strength", "Improved chest and shoulder strength", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Avoid jerking the body"], "instructions": "1. Grip the parallel bars with your hands shoulder-width apart. 2. Lower yourself by bending your elbows until your upper arms are parallel to the ground. 3. Push yourself back up to the starting position.", "progressions": ["Weighted Dips", "One-arm Dips"], "rest_periods": "60-90 seconds", "modifications": ["Assisted Dips", "Bench Dips"], "muscle_groups": ["Triceps", "Pectorals", "Anterior Deltoids"], "common_mistakes": ["Leaning too far forward", "Not lowering sufficiently"], "equipment_needed": ["Parallel Bars"], "sets_reps_guidance": "3 sets of 8-12 reps"}	2025-07-23 12:47:03.043+00
50285233-0f6c-4659-81e1-7fb472ef8bf5	strength-building	Dumbbell Bicep Curls (Batch 4)	{"id": "e8-dumbbell-bicep-curls_batch4", "name": "Dumbbell Bicep Curls (Batch 4)", "tips": "Squeeze your biceps at the top of the movement.", "benefits": ["Increased bicep strength", "Improved arm size", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "Avoid jerking the dumbbells"], "instructions": "1. Stand with feet shoulder-width apart, holding a dumbbell in each hand. 2. Curl the dumbbells towards your shoulders, keeping your elbows close to your sides. 3. Slowly lower the dumbbells back to the starting position.", "progressions": ["Hammer Curls", "Concentration Curls"], "rest_periods": "45-60 seconds", "modifications": ["Seated Bicep Curls", "Using lighter weight"], "muscle_groups": ["Biceps", "Brachialis", "Brachioradialis"], "common_mistakes": ["Using momentum", "Swinging the dumbbells"], "equipment_needed": ["Dumbbells"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
c4c17d84-288a-4978-98a3-3f3fb4e904d8	strength-building	Cable Face Pulls (Batch 4)	{"id": "e9-cable-face-pulls_batch4", "name": "Cable Face Pulls (Batch 4)", "tips": "Focus on squeezing your shoulder blades together at the end of the movement.", "benefits": ["Improved shoulder health", "Increased upper back strength", "Enhanced posture"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "intermediate", "safety_tips": ["Maintain a controlled movement", "Avoid jerking the rope"], "instructions": "1. Attach a rope attachment to a high cable pulley. 2. Stand facing the machine with a slight bend in your knees. 3. Pull the rope towards your face, keeping your elbows high. 4. Slowly return to the starting position.", "progressions": ["Band Face Pulls"], "rest_periods": "45-60 seconds", "modifications": ["Using lighter weight", "Using a different attachment"], "muscle_groups": ["Rear Deltoids", "Trapezius", "Rhomboids"], "common_mistakes": ["Pulling with your arms instead of your back", "Not squeezing your shoulder blades together"], "equipment_needed": ["Cable Machine"], "sets_reps_guidance": "3 sets of 15-20 reps"}	2025-07-23 12:47:03.043+00
499a4225-84b8-42d4-a93d-1bdfa6ba00cd	strength-building	Leg Press (Batch 4)	{"id": "e10-leg-press_batch4", "name": "Leg Press (Batch 4)", "tips": "Focus on squeezing your glutes at the top of the movement.", "benefits": ["Increased lower body strength", "Improved leg size", "Enhanced muscle growth"], "category": "Strength Training & Muscle Building", "imageUrl": "/images/exercise/push_ups.png", "difficulty": "beginner", "safety_tips": ["Maintain a controlled movement", "Avoid jerking the platform"], "instructions": "1. Sit on the leg press machine and place your feet shoulder-width apart on the platform. 2. Push the platform away from you by extending your legs. 3. Slowly return the platform to the starting position.", "progressions": ["Hack Squat", "Bulgarian Split Squat"], "rest_periods": "60-90 seconds", "modifications": ["Using lighter weight", "Adjusting foot placement"], "muscle_groups": ["Quadriceps", "Glutes", "Hamstrings"], "common_mistakes": ["Locking your knees", "Using too much weight"], "equipment_needed": ["Leg Press Machine"], "sets_reps_guidance": "3 sets of 10-15 reps"}	2025-07-23 12:47:03.043+00
\.


--
-- TOC entry 4351 (class 0 OID 18244)
-- Dependencies: 289
-- Data for Name: exercises; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.exercises (id, name, category, muscle_groups, equipment_needed, difficulty_level, instructions, tips, image_url, video_url, created_at) FROM stdin;
\.


--
-- TOC entry 4352 (class 0 OID 18251)
-- Dependencies: 290
-- Data for Name: gym_equipment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gym_equipment (id, gym_id, name, quantity, condition, description, created_at) FROM stdin;
\.


--
-- TOC entry 4353 (class 0 OID 18259)
-- Dependencies: 291
-- Data for Name: gym_subscriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gym_subscriptions (id, user_id, gym_id, plan_id, start_date, end_date, status, trainer_id, created_at) FROM stdin;
\.


--
-- TOC entry 4354 (class 0 OID 18265)
-- Dependencies: 292
-- Data for Name: gym_user_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gym_user_profiles (id, weight, height, bmi, fitness_goals, current_gym_id, fitness_level, medical_conditions, preferred_training_types, created_at, updated_at) FROM stdin;
f14640a2-1619-42cb-8c28-29f49401b92d	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-23 10:54:57.284013+00	2025-07-23 10:54:57.284013+00
\.


--
-- TOC entry 4355 (class 0 OID 18272)
-- Dependencies: 293
-- Data for Name: gyms; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gyms (id, admin_id, name, description, area_sqft, address, city, state, postal_code, phone, email, website, operating_hours, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4356 (class 0 OID 18280)
-- Dependencies: 294
-- Data for Name: nutrition; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nutrition (id, name, category, calories_per_100g, protein_per_100g, carbs_per_100g, fat_per_100g, fiber_per_100g, vitamins, minerals, created_at) FROM stdin;
\.


--
-- TOC entry 4357 (class 0 OID 18287)
-- Dependencies: 295
-- Data for Name: personal_trainers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.personal_trainers (id, gym_id, name, experience_years, specializations, hourly_rate, bio, certifications, available_hours, created_at) FROM stdin;
\.


--
-- TOC entry 4358 (class 0 OID 18294)
-- Dependencies: 296
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, name, description, price, category, brand, image_url, in_stock, created_at) FROM stdin;
\.


--
-- TOC entry 4359 (class 0 OID 18302)
-- Dependencies: 297
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, email, full_name, user_role, phone, address, city, state, postal_code, created_at, updated_at) FROM stdin;
f14640a2-1619-42cb-8c28-29f49401b92d	sagarseth2835@gmail.com	\N	gym_user	\N	\N	\N	\N	\N	2025-07-23 10:54:38.103355+00	2025-07-23 10:54:38.103355+00
\.


--
-- TOC entry 4360 (class 0 OID 18310)
-- Dependencies: 298
-- Data for Name: subscription_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.subscription_plans (id, gym_id, name, description, price, duration_months, features, trainer_sessions_included, created_at) FROM stdin;
\.


--
-- TOC entry 4348 (class 0 OID 18155)
-- Dependencies: 286
-- Data for Name: user_body_measurements; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_body_measurements (id, user_id, date, weight, body_fat, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4361 (class 0 OID 18318)
-- Dependencies: 299
-- Data for Name: user_exercise_history; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_exercise_history (id, user_id, exercise_id, exercise_name, goal_category, viewed_at, performed, notes, created_at) FROM stdin;
\.


--
-- TOC entry 4362 (class 0 OID 18327)
-- Dependencies: 300
-- Data for Name: user_exercise_preferences; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_exercise_preferences (id, user_id, preferred_goal_categories, favorite_exercises, equipment_available, difficulty_preference, workout_frequency_per_week, session_duration_minutes, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4346 (class 0 OID 18120)
-- Dependencies: 284
-- Data for Name: user_goals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_goals (user_id, weekly_workouts, weight_goal, streak_goal, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4363 (class 0 OID 18341)
-- Dependencies: 301
-- Data for Name: user_nutrition_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_nutrition_log (id, user_id, food_id, quantity_grams, meal_type, log_date, created_at) FROM stdin;
\.


--
-- TOC entry 4347 (class 0 OID 18136)
-- Dependencies: 285
-- Data for Name: user_wearables_log; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_wearables_log (id, user_id, date, steps, sleep, heart_rate, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4365 (class 0 OID 18511)
-- Dependencies: 303
-- Data for Name: user_weekly_plans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_weekly_plans (id, user_id, week_start, plan_data, created_at, updated_at) FROM stdin;
7492ab6f-0a09-44df-8767-3f503562f942	f14640a2-1619-42cb-8c28-29f49401b92d	2025-07-21	{"exercisePlan": {"friday": {"type": "Back + Biceps", "duration": "45-60 min", "exercises": [{"name": "lat close grip", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/lat_close_grip.png"}, {"name": "lat machine", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/lat_machine.png"}, {"name": "hyperextension", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/hyperextension.png"}, {"name": "biceps curl barbel", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/biceps_curl_barbel.png"}, {"name": "biceps machine", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/biceps_machine.png"}, {"name": "barbel sides", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/barbel_sides.png"}, {"name": "dumbel sides", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/dumbel_sides.png"}, {"name": "side plank", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/side_plank.png"}]}, "monday": {"type": "Chest + Tricep", "duration": "45-60 min", "exercises": [{"name": "chest press", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/chest_press.png"}, {"name": "chest press incline", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/chest_press_incline.png"}, {"name": "shoulder press", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/shoulder_press.png"}, {"name": "lateral raise", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/lateral_raise.png"}, {"name": "tricep pushdown", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/tricep_pushdown.png"}, {"name": "overhead extension", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/overhead_extension.png"}, {"name": "crunches", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/crunches.png"}, {"name": "leg raise", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_raise.png"}, {"name": "plank", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/plank.png"}]}, "sunday": {"type": "Rest", "duration": "", "exercises": []}, "tuesday": {"type": "Back + Bicep", "duration": "45-60 min", "exercises": [{"name": "Lat pull down", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/lat_pull_down.png"}, {"name": "Mid rowing", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/mid_rowing.png"}, {"name": "hyperextension", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/hyperextension.png"}, {"name": "biceps curl", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/biceps_curl.png"}, {"name": "Hammer curl", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/hammer_curl.png"}, {"name": "barbell sides", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/barbell_sides.png"}, {"name": "dumbel sides", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/dumbel_sides.png"}, {"name": "side plank", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/side_plank.png"}]}, "saturday": {"type": "Leg", "duration": "45-60 min", "exercises": [{"name": "sumo squat", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/sumo_squat.png"}, {"name": "barbel squat", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/barbel_squat.png"}, {"name": "leg press", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_press.png"}, {"name": "leg curl", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_curl.png"}, {"name": "leg extension", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_extension.png"}, {"name": "calves standing", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/calves_standing.png"}, {"name": "eliptical", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/eliptical.png"}, {"name": "cycling", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/cycling.png"}]}, "thursday": {"type": "Chest + Tricep", "duration": "45-60 min", "exercises": [{"name": "chest press decline", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/chest_press_decline.png"}, {"name": "pec fly", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/pec_fly.png"}, {"name": "front raise", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/front_raise.png"}, {"name": "rear delt", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/rear_delt.png"}, {"name": "single head extension", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/single_head_extension.png"}, {"name": "triceps machine", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/triceps_machine.png"}, {"name": "crunches", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/crunches.png"}, {"name": "leg raise", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_raise.png"}, {"name": "plank", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/plank.png"}]}, "wednesday": {"type": "Leg", "duration": "45-60 min", "exercises": [{"name": "barbel squat", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/barbel_squat.png"}, {"name": "leg press", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_press.png"}, {"name": "front squat", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/front_squat.png"}, {"name": "leg extension", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_extension.png"}, {"name": "leg curl", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/leg_curl.png"}, {"name": "calves seated", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/calves_seated.png"}, {"name": "eliptical", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/eliptical.png"}, {"name": "cycling", "reps": "10-15", "rest": "60s", "sets": 3, "imageUrl": "/images/exercise/cycling.png"}]}}}	2025-07-23 11:00:40.917788+00	2025-07-23 11:00:40.917788+00
\.


--
-- TOC entry 4364 (class 0 OID 18349)
-- Dependencies: 302
-- Data for Name: user_workouts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_workouts (id, user_id, exercise_id, sets, reps, weight, duration_minutes, notes, workout_date, created_at) FROM stdin;
\.


--
-- TOC entry 4326 (class 0 OID 17638)
-- Dependencies: 264
-- Data for Name: messages_2025_07_22; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_22 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4327 (class 0 OID 17649)
-- Dependencies: 265
-- Data for Name: messages_2025_07_23; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_23 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4328 (class 0 OID 17660)
-- Dependencies: 266
-- Data for Name: messages_2025_07_24; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_24 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4329 (class 0 OID 17671)
-- Dependencies: 267
-- Data for Name: messages_2025_07_25; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_25 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4330 (class 0 OID 17682)
-- Dependencies: 268
-- Data for Name: messages_2025_07_26; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.messages_2025_07_26 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;
\.


--
-- TOC entry 4323 (class 0 OID 17461)
-- Dependencies: 257
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-07-23 10:52:40
20211116045059	2025-07-23 10:52:40
20211116050929	2025-07-23 10:52:40
20211116051442	2025-07-23 10:52:40
20211116212300	2025-07-23 10:52:40
20211116213355	2025-07-23 10:52:40
20211116213934	2025-07-23 10:52:40
20211116214523	2025-07-23 10:52:40
20211122062447	2025-07-23 10:52:40
20211124070109	2025-07-23 10:52:40
20211202204204	2025-07-23 10:52:40
20211202204605	2025-07-23 10:52:40
20211210212804	2025-07-23 10:52:40
20211228014915	2025-07-23 10:52:40
20220107221237	2025-07-23 10:52:40
20220228202821	2025-07-23 10:52:40
20220312004840	2025-07-23 10:52:40
20220603231003	2025-07-23 10:52:40
20220603232444	2025-07-23 10:52:40
20220615214548	2025-07-23 10:52:40
20220712093339	2025-07-23 10:52:40
20220908172859	2025-07-23 10:52:40
20220916233421	2025-07-23 10:52:40
20230119133233	2025-07-23 10:52:40
20230128025114	2025-07-23 10:52:40
20230128025212	2025-07-23 10:52:40
20230227211149	2025-07-23 10:52:40
20230228184745	2025-07-23 10:52:40
20230308225145	2025-07-23 10:52:40
20230328144023	2025-07-23 10:52:40
20231018144023	2025-07-23 10:52:40
20231204144023	2025-07-23 10:52:40
20231204144024	2025-07-23 10:52:40
20231204144025	2025-07-23 10:52:40
20240108234812	2025-07-23 10:52:40
20240109165339	2025-07-23 10:52:40
20240227174441	2025-07-23 10:52:40
20240311171622	2025-07-23 10:52:40
20240321100241	2025-07-23 10:52:40
20240401105812	2025-07-23 10:52:40
20240418121054	2025-07-23 10:52:40
20240523004032	2025-07-23 10:52:40
20240618124746	2025-07-23 10:52:40
20240801235015	2025-07-23 10:52:40
20240805133720	2025-07-23 10:52:40
20240827160934	2025-07-23 10:52:40
20240919163303	2025-07-23 10:52:40
20240919163305	2025-07-23 10:52:40
20241019105805	2025-07-23 10:52:40
20241030150047	2025-07-23 10:52:40
20241108114728	2025-07-23 10:52:40
20241121104152	2025-07-23 10:52:40
20241130184212	2025-07-23 10:52:40
20241220035512	2025-07-23 10:52:40
20241220123912	2025-07-23 10:52:40
20241224161212	2025-07-23 10:52:40
20250107150512	2025-07-23 10:52:40
20250110162412	2025-07-23 10:52:40
20250123174212	2025-07-23 10:52:40
20250128220012	2025-07-23 10:52:40
20250506224012	2025-07-23 10:52:40
20250523164012	2025-07-23 10:52:40
\.


--
-- TOC entry 4325 (class 0 OID 17483)
-- Dependencies: 260
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- TOC entry 4314 (class 0 OID 16502)
-- Dependencies: 238
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
\.


--
-- TOC entry 4316 (class 0 OID 16544)
-- Dependencies: 240
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-07-23 10:52:42.266376
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-07-23 10:52:42.268818
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-07-23 10:52:42.26974
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-07-23 10:52:42.276884
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-07-23 10:52:42.28634
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-07-23 10:52:42.287474
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-07-23 10:52:42.289703
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-07-23 10:52:42.291984
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-07-23 10:52:42.293363
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-07-23 10:52:42.295657
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-07-23 10:52:42.297028
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-07-23 10:52:42.29908
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-07-23 10:52:42.300928
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-07-23 10:52:42.303724
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-07-23 10:52:42.306629
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-07-23 10:52:42.317175
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-07-23 10:52:42.319309
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-07-23 10:52:42.320289
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-07-23 10:52:42.32126
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-07-23 10:52:42.322592
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-07-23 10:52:42.323584
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-07-23 10:52:42.325953
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-07-23 10:52:42.336331
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-07-23 10:52:42.345189
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-07-23 10:52:42.346952
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-07-23 10:52:42.348111
26	objects-prefixes	ef3f7871121cdc47a65308e6702519e853422ae2	2025-07-23 10:52:42.349126
27	search-v2	33b8f2a7ae53105f028e13e9fcda9dc4f356b4a2	2025-07-23 10:52:42.354932
28	object-bucket-name-sorting	ba85ec41b62c6a30a3f136788227ee47f311c436	2025-07-23 10:52:42.360683
29	create-prefixes	a7b1a22c0dc3ab630e3055bfec7ce7d2045c5b7b	2025-07-23 10:52:42.362195
30	update-object-levels	6c6f6cc9430d570f26284a24cf7b210599032db7	2025-07-23 10:52:42.363152
31	objects-level-index	33f1fef7ec7fea08bb892222f4f0f5d79bab5eb8	2025-07-23 10:52:42.364867
32	backward-compatible-index-on-objects	2d51eeb437a96868b36fcdfb1ddefdf13bef1647	2025-07-23 10:52:42.366758
33	backward-compatible-index-on-prefixes	fe473390e1b8c407434c0e470655945b110507bf	2025-07-23 10:52:42.368541
34	optimize-search-function-v1	82b0e469a00e8ebce495e29bfa70a0797f7ebd2c	2025-07-23 10:52:42.368797
35	add-insert-trigger-prefixes	63bb9fd05deb3dc5e9fa66c83e82b152f0caf589	2025-07-23 10:52:42.370671
36	optimise-existing-functions	81cf92eb0c36612865a18016a38496c530443899	2025-07-23 10:52:42.371494
37	add-bucket-name-length-trigger	3944135b4e3e8b22d6d4cbb568fe3b0b51df15c1	2025-07-23 10:52:42.374059
\.


--
-- TOC entry 4315 (class 0 OID 16517)
-- Dependencies: 239
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata, level) FROM stdin;
\.


--
-- TOC entry 4333 (class 0 OID 17778)
-- Dependencies: 271
-- Data for Name: prefixes; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.prefixes (bucket_id, name, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4331 (class 0 OID 17725)
-- Dependencies: 269
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- TOC entry 4332 (class 0 OID 17739)
-- Dependencies: 270
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- TOC entry 4319 (class 0 OID 16737)
-- Dependencies: 253
-- Data for Name: hooks; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.hooks (id, hook_table_id, hook_name, created_at, request_id) FROM stdin;
\.


--
-- TOC entry 4317 (class 0 OID 16728)
-- Dependencies: 251
-- Data for Name: migrations; Type: TABLE DATA; Schema: supabase_functions; Owner: supabase_functions_admin
--

COPY supabase_functions.migrations (version, inserted_at) FROM stdin;
initial	2025-07-23 10:52:28.873301+00
20210809183423_update_grants	2025-07-23 10:52:28.873301+00
\.


--
-- TOC entry 4345 (class 0 OID 18113)
-- Dependencies: 283
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: supabase_migrations; Owner: postgres
--

COPY supabase_migrations.schema_migrations (version, statements, name) FROM stdin;
20240621120000	{"-- Create user_goals table\nCREATE TABLE IF NOT EXISTS user_goals (\n  user_id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,\n  weekly_workouts integer,\n  weight_goal numeric,\n  streak_goal integer,\n  created_at timestamptz DEFAULT now(),\n  updated_at timestamptz DEFAULT now()\n)","-- Trigger to update updated_at on row update\nCREATE OR REPLACE FUNCTION update_user_goals_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = now();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","DROP TRIGGER IF EXISTS set_user_goals_updated_at ON user_goals","CREATE TRIGGER set_user_goals_updated_at\nBEFORE UPDATE ON user_goals\nFOR EACH ROW EXECUTE FUNCTION update_user_goals_updated_at()"}	create_user_goals
20240621121000	{"-- Create user_wearables_log table\nCREATE TABLE IF NOT EXISTS user_wearables_log (\n  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,\n  date date NOT NULL,\n  steps integer,\n  sleep numeric, -- hours\n  heart_rate integer, -- bpm\n  created_at timestamptz DEFAULT now(),\n  updated_at timestamptz DEFAULT now(),\n  UNIQUE (user_id, date)\n)","-- Trigger to update updated_at on row update\nCREATE OR REPLACE FUNCTION update_user_wearables_log_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = now();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","DROP TRIGGER IF EXISTS set_user_wearables_log_updated_at ON user_wearables_log","CREATE TRIGGER set_user_wearables_log_updated_at\nBEFORE UPDATE ON user_wearables_log\nFOR EACH ROW EXECUTE FUNCTION update_user_wearables_log_updated_at()"}	create_user_wearables_log
20240621122000	{"-- Create user_body_measurements table\nCREATE TABLE IF NOT EXISTS user_body_measurements (\n  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),\n  user_id uuid REFERENCES auth.users(id) ON DELETE CASCADE,\n  date date NOT NULL,\n  weight numeric, -- kg\n  body_fat numeric, -- percent\n  created_at timestamptz DEFAULT now(),\n  updated_at timestamptz DEFAULT now(),\n  UNIQUE (user_id, date)\n)","-- Trigger to update updated_at on row update\nCREATE OR REPLACE FUNCTION update_user_body_measurements_updated_at()\nRETURNS TRIGGER AS $$\nBEGIN\n  NEW.updated_at = now();\n  RETURN NEW;\nEND;\n$$ LANGUAGE plpgsql","DROP TRIGGER IF EXISTS set_user_body_measurements_updated_at ON user_body_measurements","CREATE TRIGGER set_user_body_measurements_updated_at\nBEFORE UPDATE ON user_body_measurements\nFOR EACH ROW EXECUTE FUNCTION update_user_body_measurements_updated_at()"}	create_user_body_measurements
20250101000000	{"-- Create category_exercises table for storing AI-generated exercises by category\nCREATE TABLE IF NOT EXISTS \\"public\\".\\"category_exercises\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"category_id\\" \\"text\\" NOT NULL,\n    \\"exercise_name\\" \\"text\\" NOT NULL,\n    \\"exercise_data\\" \\"jsonb\\" NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL,\n    CONSTRAINT \\"category_exercises_pkey\\" PRIMARY KEY (\\"id\\")\n)","-- Add indexes for better performance\nCREATE INDEX IF NOT EXISTS \\"category_exercises_category_id_idx\\" ON \\"public\\".\\"category_exercises\\" (\\"category_id\\")","CREATE INDEX IF NOT EXISTS \\"category_exercises_created_at_idx\\" ON \\"public\\".\\"category_exercises\\" (\\"created_at\\")","-- Disable RLS for batch operations (can be enabled later for production)\nALTER TABLE \\"public\\".\\"category_exercises\\" DISABLE ROW LEVEL SECURITY"}	create_category_exercises
20250613123307	{"SET statement_timeout = 0","SET lock_timeout = 0","SET idle_in_transaction_session_timeout = 0","SET client_encoding = 'UTF8'","SET standard_conforming_strings = on","SELECT pg_catalog.set_config('search_path', '', false)","SET check_function_bodies = false","SET xmloption = content","SET client_min_messages = warning","SET row_security = off","COMMENT ON SCHEMA \\"public\\" IS 'standard public schema'","CREATE EXTENSION IF NOT EXISTS \\"pg_graphql\\" WITH SCHEMA \\"graphql\\"","CREATE EXTENSION IF NOT EXISTS \\"pg_stat_statements\\" WITH SCHEMA \\"extensions\\"","CREATE EXTENSION IF NOT EXISTS \\"pgcrypto\\" WITH SCHEMA \\"extensions\\"","CREATE EXTENSION IF NOT EXISTS \\"supabase_vault\\" WITH SCHEMA \\"vault\\"","CREATE EXTENSION IF NOT EXISTS \\"uuid-ossp\\" WITH SCHEMA \\"extensions\\"","CREATE TYPE \\"public\\".\\"fitness_goal\\" AS ENUM (\n    'gain_muscle',\n    'lose_weight',\n    'calisthenics',\n    'bulking',\n    'basic_fitness',\n    'bodybuilding',\n    'heavy_lifting'\n)","ALTER TYPE \\"public\\".\\"fitness_goal\\" OWNER TO \\"postgres\\"","CREATE TYPE \\"public\\".\\"subscription_status\\" AS ENUM (\n    'active',\n    'inactive',\n    'cancelled',\n    'expired'\n)","ALTER TYPE \\"public\\".\\"subscription_status\\" OWNER TO \\"postgres\\"","CREATE TYPE \\"public\\".\\"training_type\\" AS ENUM (\n    'strength',\n    'cardio',\n    'yoga',\n    'pilates',\n    'crossfit',\n    'martial_arts',\n    'swimming',\n    'cycling'\n)","ALTER TYPE \\"public\\".\\"training_type\\" OWNER TO \\"postgres\\"","CREATE TYPE \\"public\\".\\"user_role\\" AS ENUM (\n    'gym_admin',\n    'gym_user'\n)","ALTER TYPE \\"public\\".\\"user_role\\" OWNER TO \\"postgres\\"","CREATE OR REPLACE FUNCTION \\"public\\".\\"handle_new_user\\"() RETURNS \\"trigger\\"\n    LANGUAGE \\"plpgsql\\" SECURITY DEFINER\n    AS $$\nBEGIN\n    -- Insert into profiles table\n    INSERT INTO public.profiles (id, email, full_name, user_role)\n    VALUES (\n        new.id,\n        new.email,\n        COALESCE(new.raw_user_meta_data->>'full_name', ''),\n        COALESCE((new.raw_user_meta_data->>'user_role')::user_role, 'gym_user'::user_role)\n    );\n    \n    -- If user is a gym_user, also create gym_user_profile\n    IF COALESCE((new.raw_user_meta_data->>'user_role')::user_role, 'gym_user'::user_role) = 'gym_user'::user_role THEN\n        INSERT INTO public.gym_user_profiles (id)\n        VALUES (new.id);\n    END IF;\n    \n    RETURN new;\nEXCEPTION\n    WHEN OTHERS THEN\n        -- Log the error but don't block user creation\n        RAISE LOG 'Error in handle_new_user trigger: %', SQLERRM;\n        RETURN new;\nEND;\n$$","ALTER FUNCTION \\"public\\".\\"handle_new_user\\"() OWNER TO \\"postgres\\"","SET default_tablespace = ''","SET default_table_access_method = \\"heap\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"ai_exercises_cache\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"goal_category\\" \\"text\\" NOT NULL,\n    \\"exercise_name\\" \\"text\\" NOT NULL,\n    \\"exercise_data\\" \\"jsonb\\" NOT NULL,\n    \\"generated_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"ai_exercises_cache\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"exercises\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"category\\" \\"text\\" NOT NULL,\n    \\"muscle_groups\\" \\"text\\"[],\n    \\"equipment_needed\\" \\"text\\"[],\n    \\"difficulty_level\\" \\"text\\",\n    \\"instructions\\" \\"text\\",\n    \\"tips\\" \\"text\\",\n    \\"image_url\\" \\"text\\",\n    \\"video_url\\" \\"text\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"exercises\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"gym_equipment\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"gym_id\\" \\"uuid\\" NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"quantity\\" integer DEFAULT 1 NOT NULL,\n    \\"condition\\" \\"text\\",\n    \\"description\\" \\"text\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"gym_equipment\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"gym_subscriptions\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"user_id\\" \\"uuid\\" NOT NULL,\n    \\"gym_id\\" \\"uuid\\" NOT NULL,\n    \\"plan_id\\" \\"uuid\\" NOT NULL,\n    \\"start_date\\" \\"date\\" NOT NULL,\n    \\"end_date\\" \\"date\\" NOT NULL,\n    \\"status\\" \\"public\\".\\"subscription_status\\" DEFAULT 'active'::\\"public\\".\\"subscription_status\\" NOT NULL,\n    \\"trainer_id\\" \\"uuid\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"gym_subscriptions\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"gym_user_profiles\\" (\n    \\"id\\" \\"uuid\\" NOT NULL,\n    \\"weight\\" numeric(5,2),\n    \\"height\\" numeric(5,2),\n    \\"bmi\\" numeric(4,2),\n    \\"fitness_goals\\" \\"public\\".\\"fitness_goal\\"[],\n    \\"current_gym_id\\" \\"uuid\\",\n    \\"fitness_level\\" \\"text\\",\n    \\"medical_conditions\\" \\"text\\"[],\n    \\"preferred_training_types\\" \\"public\\".\\"training_type\\"[],\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL,\n    \\"updated_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"gym_user_profiles\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"gyms\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"admin_id\\" \\"uuid\\" NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"description\\" \\"text\\",\n    \\"area_sqft\\" integer,\n    \\"address\\" \\"text\\" NOT NULL,\n    \\"city\\" \\"text\\" NOT NULL,\n    \\"state\\" \\"text\\" NOT NULL,\n    \\"postal_code\\" \\"text\\",\n    \\"phone\\" \\"text\\",\n    \\"email\\" \\"text\\",\n    \\"website\\" \\"text\\",\n    \\"operating_hours\\" \\"jsonb\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL,\n    \\"updated_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"gyms\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"nutrition\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"category\\" \\"text\\" NOT NULL,\n    \\"calories_per_100g\\" integer,\n    \\"protein_per_100g\\" numeric(5,2),\n    \\"carbs_per_100g\\" numeric(5,2),\n    \\"fat_per_100g\\" numeric(5,2),\n    \\"fiber_per_100g\\" numeric(5,2),\n    \\"vitamins\\" \\"jsonb\\",\n    \\"minerals\\" \\"jsonb\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"nutrition\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"personal_trainers\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"gym_id\\" \\"uuid\\" NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"experience_years\\" integer,\n    \\"specializations\\" \\"text\\"[],\n    \\"hourly_rate\\" numeric(10,2),\n    \\"bio\\" \\"text\\",\n    \\"certifications\\" \\"text\\"[],\n    \\"available_hours\\" \\"jsonb\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"personal_trainers\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"products\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"description\\" \\"text\\",\n    \\"price\\" numeric(10,2) NOT NULL,\n    \\"category\\" \\"text\\" NOT NULL,\n    \\"brand\\" \\"text\\",\n    \\"image_url\\" \\"text\\",\n    \\"in_stock\\" boolean DEFAULT true,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"products\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"profiles\\" (\n    \\"id\\" \\"uuid\\" NOT NULL,\n    \\"email\\" \\"text\\" NOT NULL,\n    \\"full_name\\" \\"text\\",\n    \\"user_role\\" \\"public\\".\\"user_role\\" DEFAULT 'gym_user'::\\"public\\".\\"user_role\\" NOT NULL,\n    \\"phone\\" \\"text\\",\n    \\"address\\" \\"text\\",\n    \\"city\\" \\"text\\",\n    \\"state\\" \\"text\\",\n    \\"postal_code\\" \\"text\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL,\n    \\"updated_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"profiles\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"subscription_plans\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"gym_id\\" \\"uuid\\" NOT NULL,\n    \\"name\\" \\"text\\" NOT NULL,\n    \\"description\\" \\"text\\",\n    \\"price\\" numeric(10,2) NOT NULL,\n    \\"duration_months\\" integer NOT NULL,\n    \\"features\\" \\"text\\"[],\n    \\"trainer_sessions_included\\" integer DEFAULT 0,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"subscription_plans\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"user_exercise_history\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"user_id\\" \\"uuid\\" NOT NULL,\n    \\"exercise_id\\" \\"uuid\\",\n    \\"exercise_name\\" \\"text\\" NOT NULL,\n    \\"goal_category\\" \\"text\\" NOT NULL,\n    \\"viewed_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL,\n    \\"performed\\" boolean DEFAULT false,\n    \\"notes\\" \\"text\\",\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"user_exercise_history\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"user_exercise_preferences\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"user_id\\" \\"uuid\\" NOT NULL,\n    \\"preferred_goal_categories\\" \\"text\\"[] DEFAULT '{}'::\\"text\\"[],\n    \\"favorite_exercises\\" \\"text\\"[] DEFAULT '{}'::\\"text\\"[],\n    \\"equipment_available\\" \\"text\\"[] DEFAULT '{}'::\\"text\\"[],\n    \\"difficulty_preference\\" \\"text\\" DEFAULT 'intermediate'::\\"text\\",\n    \\"workout_frequency_per_week\\" integer DEFAULT 3,\n    \\"session_duration_minutes\\" integer DEFAULT 45,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL,\n    \\"updated_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"user_exercise_preferences\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"user_nutrition_log\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"user_id\\" \\"uuid\\" NOT NULL,\n    \\"food_id\\" \\"uuid\\" NOT NULL,\n    \\"quantity_grams\\" numeric(6,2) NOT NULL,\n    \\"meal_type\\" \\"text\\" NOT NULL,\n    \\"log_date\\" \\"date\\" DEFAULT CURRENT_DATE NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"user_nutrition_log\\" OWNER TO \\"postgres\\"","CREATE TABLE IF NOT EXISTS \\"public\\".\\"user_workouts\\" (\n    \\"id\\" \\"uuid\\" DEFAULT \\"gen_random_uuid\\"() NOT NULL,\n    \\"user_id\\" \\"uuid\\" NOT NULL,\n    \\"exercise_id\\" \\"uuid\\" NOT NULL,\n    \\"sets\\" integer,\n    \\"reps\\" integer,\n    \\"weight\\" numeric(5,2),\n    \\"duration_minutes\\" integer,\n    \\"notes\\" \\"text\\",\n    \\"workout_date\\" \\"date\\" DEFAULT CURRENT_DATE NOT NULL,\n    \\"created_at\\" timestamp with time zone DEFAULT \\"now\\"() NOT NULL\n)","ALTER TABLE \\"public\\".\\"user_workouts\\" OWNER TO \\"postgres\\"","ALTER TABLE ONLY \\"public\\".\\"ai_exercises_cache\\"\n    ADD CONSTRAINT \\"ai_exercises_cache_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"exercises\\"\n    ADD CONSTRAINT \\"exercises_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"gym_equipment\\"\n    ADD CONSTRAINT \\"gym_equipment_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"gym_subscriptions\\"\n    ADD CONSTRAINT \\"gym_subscriptions_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"gym_user_profiles\\"\n    ADD CONSTRAINT \\"gym_user_profiles_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"gyms\\"\n    ADD CONSTRAINT \\"gyms_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"nutrition\\"\n    ADD CONSTRAINT \\"nutrition_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"personal_trainers\\"\n    ADD CONSTRAINT \\"personal_trainers_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"products\\"\n    ADD CONSTRAINT \\"products_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"profiles\\"\n    ADD CONSTRAINT \\"profiles_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"subscription_plans\\"\n    ADD CONSTRAINT \\"subscription_plans_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"user_exercise_history\\"\n    ADD CONSTRAINT \\"user_exercise_history_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"user_exercise_preferences\\"\n    ADD CONSTRAINT \\"user_exercise_preferences_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"user_exercise_preferences\\"\n    ADD CONSTRAINT \\"user_exercise_preferences_user_id_key\\" UNIQUE (\\"user_id\\")","ALTER TABLE ONLY \\"public\\".\\"user_nutrition_log\\"\n    ADD CONSTRAINT \\"user_nutrition_log_pkey\\" PRIMARY KEY (\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"user_workouts\\"\n    ADD CONSTRAINT \\"user_workouts_pkey\\" PRIMARY KEY (\\"id\\")","CREATE INDEX \\"idx_ai_exercises_cache_goal_category\\" ON \\"public\\".\\"ai_exercises_cache\\" USING \\"btree\\" (\\"goal_category\\")","CREATE INDEX \\"idx_user_exercise_history_goal_category\\" ON \\"public\\".\\"user_exercise_history\\" USING \\"btree\\" (\\"goal_category\\")","CREATE INDEX \\"idx_user_exercise_history_user_id\\" ON \\"public\\".\\"user_exercise_history\\" USING \\"btree\\" (\\"user_id\\")","CREATE INDEX \\"idx_user_exercise_preferences_user_id\\" ON \\"public\\".\\"user_exercise_preferences\\" USING \\"btree\\" (\\"user_id\\")","ALTER TABLE ONLY \\"public\\".\\"gym_equipment\\"\n    ADD CONSTRAINT \\"gym_equipment_gym_id_fkey\\" FOREIGN KEY (\\"gym_id\\") REFERENCES \\"public\\".\\"gyms\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"gym_subscriptions\\"\n    ADD CONSTRAINT \\"gym_subscriptions_gym_id_fkey\\" FOREIGN KEY (\\"gym_id\\") REFERENCES \\"public\\".\\"gyms\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"gym_subscriptions\\"\n    ADD CONSTRAINT \\"gym_subscriptions_plan_id_fkey\\" FOREIGN KEY (\\"plan_id\\") REFERENCES \\"public\\".\\"subscription_plans\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"gym_subscriptions\\"\n    ADD CONSTRAINT \\"gym_subscriptions_trainer_id_fkey\\" FOREIGN KEY (\\"trainer_id\\") REFERENCES \\"public\\".\\"personal_trainers\\"(\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"gym_subscriptions\\"\n    ADD CONSTRAINT \\"gym_subscriptions_user_id_fkey\\" FOREIGN KEY (\\"user_id\\") REFERENCES \\"public\\".\\"gym_user_profiles\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"gym_user_profiles\\"\n    ADD CONSTRAINT \\"gym_user_profiles_current_gym_id_fkey\\" FOREIGN KEY (\\"current_gym_id\\") REFERENCES \\"public\\".\\"gyms\\"(\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"gym_user_profiles\\"\n    ADD CONSTRAINT \\"gym_user_profiles_id_fkey\\" FOREIGN KEY (\\"id\\") REFERENCES \\"public\\".\\"profiles\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"gyms\\"\n    ADD CONSTRAINT \\"gyms_admin_id_fkey\\" FOREIGN KEY (\\"admin_id\\") REFERENCES \\"public\\".\\"profiles\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"personal_trainers\\"\n    ADD CONSTRAINT \\"personal_trainers_gym_id_fkey\\" FOREIGN KEY (\\"gym_id\\") REFERENCES \\"public\\".\\"gyms\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"profiles\\"\n    ADD CONSTRAINT \\"profiles_id_fkey\\" FOREIGN KEY (\\"id\\") REFERENCES \\"auth\\".\\"users\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"subscription_plans\\"\n    ADD CONSTRAINT \\"subscription_plans_gym_id_fkey\\" FOREIGN KEY (\\"gym_id\\") REFERENCES \\"public\\".\\"gyms\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"user_exercise_history\\"\n    ADD CONSTRAINT \\"user_exercise_history_user_id_fkey\\" FOREIGN KEY (\\"user_id\\") REFERENCES \\"auth\\".\\"users\\"(\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"user_exercise_preferences\\"\n    ADD CONSTRAINT \\"user_exercise_preferences_user_id_fkey\\" FOREIGN KEY (\\"user_id\\") REFERENCES \\"auth\\".\\"users\\"(\\"id\\")","ALTER TABLE ONLY \\"public\\".\\"user_nutrition_log\\"\n    ADD CONSTRAINT \\"user_nutrition_log_food_id_fkey\\" FOREIGN KEY (\\"food_id\\") REFERENCES \\"public\\".\\"nutrition\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"user_nutrition_log\\"\n    ADD CONSTRAINT \\"user_nutrition_log_user_id_fkey\\" FOREIGN KEY (\\"user_id\\") REFERENCES \\"public\\".\\"gym_user_profiles\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"user_workouts\\"\n    ADD CONSTRAINT \\"user_workouts_exercise_id_fkey\\" FOREIGN KEY (\\"exercise_id\\") REFERENCES \\"public\\".\\"exercises\\"(\\"id\\") ON DELETE CASCADE","ALTER TABLE ONLY \\"public\\".\\"user_workouts\\"\n    ADD CONSTRAINT \\"user_workouts_user_id_fkey\\" FOREIGN KEY (\\"user_id\\") REFERENCES \\"public\\".\\"gym_user_profiles\\"(\\"id\\") ON DELETE CASCADE","CREATE POLICY \\"Anyone can view exercises\\" ON \\"public\\".\\"exercises\\" FOR SELECT TO \\"authenticated\\" USING (true)","CREATE POLICY \\"Anyone can view nutrition data\\" ON \\"public\\".\\"nutrition\\" FOR SELECT TO \\"authenticated\\" USING (true)","CREATE POLICY \\"Anyone can view products\\" ON \\"public\\".\\"products\\" FOR SELECT TO \\"authenticated\\" USING (true)","CREATE POLICY \\"Everyone can view cached AI exercises\\" ON \\"public\\".\\"ai_exercises_cache\\" FOR SELECT USING (true)","CREATE POLICY \\"Gym admins can manage their equipment\\" ON \\"public\\".\\"gym_equipment\\" USING ((\\"gym_id\\" IN ( SELECT \\"gyms\\".\\"id\\"\n   FROM \\"public\\".\\"gyms\\"\n  WHERE (\\"gyms\\".\\"admin_id\\" = \\"auth\\".\\"uid\\"()))))","CREATE POLICY \\"Gym admins can manage their gyms\\" ON \\"public\\".\\"gyms\\" USING ((\\"admin_id\\" = \\"auth\\".\\"uid\\"()))","CREATE POLICY \\"Gym admins can manage their plans\\" ON \\"public\\".\\"subscription_plans\\" USING ((\\"gym_id\\" IN ( SELECT \\"gyms\\".\\"id\\"\n   FROM \\"public\\".\\"gyms\\"\n  WHERE (\\"gyms\\".\\"admin_id\\" = \\"auth\\".\\"uid\\"()))))","CREATE POLICY \\"Gym admins can manage their trainers\\" ON \\"public\\".\\"personal_trainers\\" USING ((\\"gym_id\\" IN ( SELECT \\"gyms\\".\\"id\\"\n   FROM \\"public\\".\\"gyms\\"\n  WHERE (\\"gyms\\".\\"admin_id\\" = \\"auth\\".\\"uid\\"()))))","CREATE POLICY \\"Gym admins can view their gym subscriptions\\" ON \\"public\\".\\"gym_subscriptions\\" FOR SELECT USING ((\\"gym_id\\" IN ( SELECT \\"gyms\\".\\"id\\"\n   FROM \\"public\\".\\"gyms\\"\n  WHERE (\\"gyms\\".\\"admin_id\\" = \\"auth\\".\\"uid\\"()))))","CREATE POLICY \\"Gym admins can view their subscribers\\" ON \\"public\\".\\"gym_user_profiles\\" FOR SELECT USING ((\\"current_gym_id\\" IN ( SELECT \\"gyms\\".\\"id\\"\n   FROM \\"public\\".\\"gyms\\"\n  WHERE (\\"gyms\\".\\"admin_id\\" = \\"auth\\".\\"uid\\"()))))","CREATE POLICY \\"Service role can manage AI exercises cache\\" ON \\"public\\".\\"ai_exercises_cache\\" TO \\"service_role\\" USING (true)","CREATE POLICY \\"Users can create subscriptions\\" ON \\"public\\".\\"gym_subscriptions\\" FOR INSERT WITH CHECK ((\\"user_id\\" = \\"auth\\".\\"uid\\"()))","CREATE POLICY \\"Users can create their own exercise history\\" ON \\"public\\".\\"user_exercise_history\\" FOR INSERT WITH CHECK ((\\"auth\\".\\"uid\\"() = \\"user_id\\"))","CREATE POLICY \\"Users can create their own exercise preferences\\" ON \\"public\\".\\"user_exercise_preferences\\" FOR INSERT WITH CHECK ((\\"auth\\".\\"uid\\"() = \\"user_id\\"))","CREATE POLICY \\"Users can insert their own gym profile\\" ON \\"public\\".\\"gym_user_profiles\\" FOR INSERT WITH CHECK ((\\"auth\\".\\"uid\\"() = \\"id\\"))","CREATE POLICY \\"Users can insert their own profile\\" ON \\"public\\".\\"profiles\\" FOR INSERT WITH CHECK ((\\"auth\\".\\"uid\\"() = \\"id\\"))","CREATE POLICY \\"Users can manage their own gym profile\\" ON \\"public\\".\\"gym_user_profiles\\" USING ((\\"id\\" = \\"auth\\".\\"uid\\"()))","CREATE POLICY \\"Users can manage their own nutrition log\\" ON \\"public\\".\\"user_nutrition_log\\" USING ((\\"user_id\\" = \\"auth\\".\\"uid\\"()))","CREATE POLICY \\"Users can manage their own workouts\\" ON \\"public\\".\\"user_workouts\\" USING ((\\"user_id\\" = \\"auth\\".\\"uid\\"()))","CREATE POLICY \\"Users can update their own exercise history\\" ON \\"public\\".\\"user_exercise_history\\" FOR UPDATE USING ((\\"auth\\".\\"uid\\"() = \\"user_id\\"))","CREATE POLICY \\"Users can update their own exercise preferences\\" ON \\"public\\".\\"user_exercise_preferences\\" FOR UPDATE USING ((\\"auth\\".\\"uid\\"() = \\"user_id\\"))","CREATE POLICY \\"Users can update their own gym profile\\" ON \\"public\\".\\"gym_user_profiles\\" FOR UPDATE USING ((\\"auth\\".\\"uid\\"() = \\"id\\"))","CREATE POLICY \\"Users can update their own profile\\" ON \\"public\\".\\"profiles\\" FOR UPDATE USING ((\\"auth\\".\\"uid\\"() = \\"id\\"))","CREATE POLICY \\"Users can view all gyms\\" ON \\"public\\".\\"gyms\\" FOR SELECT TO \\"authenticated\\" USING (true)","CREATE POLICY \\"Users can view gym equipment\\" ON \\"public\\".\\"gym_equipment\\" FOR SELECT TO \\"authenticated\\" USING (true)","CREATE POLICY \\"Users can view subscription plans\\" ON \\"public\\".\\"subscription_plans\\" FOR SELECT TO \\"authenticated\\" USING (true)","CREATE POLICY \\"Users can view their own exercise history\\" ON \\"public\\".\\"user_exercise_history\\" FOR SELECT USING ((\\"auth\\".\\"uid\\"() = \\"user_id\\"))","CREATE POLICY \\"Users can view their own exercise preferences\\" ON \\"public\\".\\"user_exercise_preferences\\" FOR SELECT USING ((\\"auth\\".\\"uid\\"() = \\"user_id\\"))","CREATE POLICY \\"Users can view their own gym profile\\" ON \\"public\\".\\"gym_user_profiles\\" FOR SELECT USING ((\\"auth\\".\\"uid\\"() = \\"id\\"))","CREATE POLICY \\"Users can view their own profile\\" ON \\"public\\".\\"profiles\\" FOR SELECT USING ((\\"auth\\".\\"uid\\"() = \\"id\\"))","CREATE POLICY \\"Users can view their own subscriptions\\" ON \\"public\\".\\"gym_subscriptions\\" FOR SELECT USING ((\\"user_id\\" = \\"auth\\".\\"uid\\"()))","CREATE POLICY \\"Users can view trainers\\" ON \\"public\\".\\"personal_trainers\\" FOR SELECT TO \\"authenticated\\" USING (true)","ALTER TABLE \\"public\\".\\"ai_exercises_cache\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"exercises\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"gym_equipment\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"gym_subscriptions\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"gym_user_profiles\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"gyms\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"nutrition\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"personal_trainers\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"products\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"profiles\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"subscription_plans\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"user_exercise_history\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"user_exercise_preferences\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"user_nutrition_log\\" ENABLE ROW LEVEL SECURITY","ALTER TABLE \\"public\\".\\"user_workouts\\" ENABLE ROW LEVEL SECURITY","ALTER PUBLICATION \\"supabase_realtime\\" OWNER TO \\"postgres\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"postgres\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"anon\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"authenticated\\"","GRANT USAGE ON SCHEMA \\"public\\" TO \\"service_role\\"","GRANT ALL ON FUNCTION \\"public\\".\\"handle_new_user\\"() TO \\"anon\\"","GRANT ALL ON FUNCTION \\"public\\".\\"handle_new_user\\"() TO \\"authenticated\\"","GRANT ALL ON FUNCTION \\"public\\".\\"handle_new_user\\"() TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"ai_exercises_cache\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"ai_exercises_cache\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"ai_exercises_cache\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"exercises\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"exercises\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"exercises\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_equipment\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_equipment\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_equipment\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_subscriptions\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_subscriptions\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_subscriptions\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_user_profiles\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_user_profiles\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"gym_user_profiles\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"gyms\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"gyms\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"gyms\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"nutrition\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"nutrition\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"nutrition\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"personal_trainers\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"personal_trainers\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"personal_trainers\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"products\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"products\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"products\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"profiles\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"profiles\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"profiles\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"subscription_plans\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"subscription_plans\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"subscription_plans\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"user_exercise_history\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"user_exercise_history\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"user_exercise_history\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"user_exercise_preferences\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"user_exercise_preferences\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"user_exercise_preferences\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"user_nutrition_log\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"user_nutrition_log\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"user_nutrition_log\\" TO \\"service_role\\"","GRANT ALL ON TABLE \\"public\\".\\"user_workouts\\" TO \\"anon\\"","GRANT ALL ON TABLE \\"public\\".\\"user_workouts\\" TO \\"authenticated\\"","GRANT ALL ON TABLE \\"public\\".\\"user_workouts\\" TO \\"service_role\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"postgres\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"anon\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"authenticated\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON SEQUENCES  TO \\"service_role\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"postgres\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"anon\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"authenticated\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON FUNCTIONS  TO \\"service_role\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"postgres\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"anon\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"authenticated\\"","ALTER DEFAULT PRIVILEGES FOR ROLE \\"postgres\\" IN SCHEMA \\"public\\" GRANT ALL ON TABLES  TO \\"service_role\\"","RESET ALL"}	remote_schema
20250620000000	{"-- Create user_weekly_plans table\nCREATE TABLE public.user_weekly_plans (\n  id UUID NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,\n  user_id UUID REFERENCES auth.users NOT NULL,\n  week_start DATE NOT NULL,\n  plan_data JSONB NOT NULL,\n  created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT now(),\n  UNIQUE(user_id, week_start)\n)","-- RLS Policies\nALTER TABLE public.user_weekly_plans ENABLE ROW LEVEL SECURITY","CREATE POLICY \\"Users can view their own weekly plans\\"\n  ON public.user_weekly_plans\n  FOR SELECT\n  USING (auth.uid() = user_id)","CREATE POLICY \\"Users can insert their own weekly plans\\"\n  ON public.user_weekly_plans\n  FOR INSERT\n  WITH CHECK (auth.uid() = user_id)","CREATE POLICY \\"Users can update their own weekly plans\\"\n  ON public.user_weekly_plans\n  FOR UPDATE\n  USING (auth.uid() = user_id)","-- Index for quick lookup\nCREATE INDEX idx_user_weekly_plans_user_id_week_start ON public.user_weekly_plans(user_id, week_start)"}	create_user_weekly_plans
\.


--
-- TOC entry 3681 (class 0 OID 16643)
-- Dependencies: 243
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 4557 (class 0 OID 0)
-- Dependencies: 233
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 4, true);


--
-- TOC entry 4558 (class 0 OID 0)
-- Dependencies: 259
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- TOC entry 4559 (class 0 OID 0)
-- Dependencies: 252
-- Name: hooks_id_seq; Type: SEQUENCE SET; Schema: supabase_functions; Owner: supabase_functions_admin
--

SELECT pg_catalog.setval('supabase_functions.hooks_id_seq', 1, false);


--
-- TOC entry 3895 (class 2606 OID 17348)
-- Name: extensions extensions_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_pkey PRIMARY KEY (id);


--
-- TOC entry 3890 (class 2606 OID 17332)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3893 (class 2606 OID 17340)
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- TOC entry 3947 (class 2606 OID 17937)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3861 (class 2606 OID 16487)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3969 (class 2606 OID 18043)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3926 (class 2606 OID 18061)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3928 (class 2606 OID 18071)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3859 (class 2606 OID 16480)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3949 (class 2606 OID 17930)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3945 (class 2606 OID 17918)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3937 (class 2606 OID 18111)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 3939 (class 2606 OID 17905)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 3973 (class 2606 OID 18096)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 16470)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3856 (class 2606 OID 17848)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3958 (class 2606 OID 17977)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 3960 (class 2606 OID 17975)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3965 (class 2606 OID 17991)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3864 (class 2606 OID 16493)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3932 (class 2606 OID 17869)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3955 (class 2606 OID 17958)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3951 (class 2606 OID 17949)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3846 (class 2606 OID 18031)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3848 (class 2606 OID 16457)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3994 (class 2606 OID 18358)
-- Name: ai_exercises_cache ai_exercises_cache_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ai_exercises_cache
    ADD CONSTRAINT ai_exercises_cache_pkey PRIMARY KEY (id);


--
-- TOC entry 3992 (class 2606 OID 18182)
-- Name: category_exercises category_exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.category_exercises
    ADD CONSTRAINT category_exercises_pkey PRIMARY KEY (id);


--
-- TOC entry 3997 (class 2606 OID 18360)
-- Name: exercises exercises_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.exercises
    ADD CONSTRAINT exercises_pkey PRIMARY KEY (id);


--
-- TOC entry 3999 (class 2606 OID 18362)
-- Name: gym_equipment gym_equipment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_equipment
    ADD CONSTRAINT gym_equipment_pkey PRIMARY KEY (id);


--
-- TOC entry 4001 (class 2606 OID 18364)
-- Name: gym_subscriptions gym_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_subscriptions
    ADD CONSTRAINT gym_subscriptions_pkey PRIMARY KEY (id);


--
-- TOC entry 4003 (class 2606 OID 18366)
-- Name: gym_user_profiles gym_user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_user_profiles
    ADD CONSTRAINT gym_user_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4005 (class 2606 OID 18368)
-- Name: gyms gyms_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gyms
    ADD CONSTRAINT gyms_pkey PRIMARY KEY (id);


--
-- TOC entry 4007 (class 2606 OID 18370)
-- Name: nutrition nutrition_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nutrition
    ADD CONSTRAINT nutrition_pkey PRIMARY KEY (id);


--
-- TOC entry 4009 (class 2606 OID 18372)
-- Name: personal_trainers personal_trainers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_trainers
    ADD CONSTRAINT personal_trainers_pkey PRIMARY KEY (id);


--
-- TOC entry 4011 (class 2606 OID 18374)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4013 (class 2606 OID 18376)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4015 (class 2606 OID 18378)
-- Name: subscription_plans subscription_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_plans
    ADD CONSTRAINT subscription_plans_pkey PRIMARY KEY (id);


--
-- TOC entry 3986 (class 2606 OID 18164)
-- Name: user_body_measurements user_body_measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_body_measurements
    ADD CONSTRAINT user_body_measurements_pkey PRIMARY KEY (id);


--
-- TOC entry 3988 (class 2606 OID 18166)
-- Name: user_body_measurements user_body_measurements_user_id_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_body_measurements
    ADD CONSTRAINT user_body_measurements_user_id_date_key UNIQUE (user_id, date);


--
-- TOC entry 4019 (class 2606 OID 18380)
-- Name: user_exercise_history user_exercise_history_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_exercise_history
    ADD CONSTRAINT user_exercise_history_pkey PRIMARY KEY (id);


--
-- TOC entry 4022 (class 2606 OID 18382)
-- Name: user_exercise_preferences user_exercise_preferences_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_exercise_preferences
    ADD CONSTRAINT user_exercise_preferences_pkey PRIMARY KEY (id);


--
-- TOC entry 4024 (class 2606 OID 18384)
-- Name: user_exercise_preferences user_exercise_preferences_user_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_exercise_preferences
    ADD CONSTRAINT user_exercise_preferences_user_id_key UNIQUE (user_id);


--
-- TOC entry 3980 (class 2606 OID 18128)
-- Name: user_goals user_goals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_goals
    ADD CONSTRAINT user_goals_pkey PRIMARY KEY (user_id);


--
-- TOC entry 4026 (class 2606 OID 18386)
-- Name: user_nutrition_log user_nutrition_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_nutrition_log
    ADD CONSTRAINT user_nutrition_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3982 (class 2606 OID 18145)
-- Name: user_wearables_log user_wearables_log_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_wearables_log
    ADD CONSTRAINT user_wearables_log_pkey PRIMARY KEY (id);


--
-- TOC entry 3984 (class 2606 OID 18147)
-- Name: user_wearables_log user_wearables_log_user_id_date_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_wearables_log
    ADD CONSTRAINT user_wearables_log_user_id_date_key UNIQUE (user_id, date);


--
-- TOC entry 4031 (class 2606 OID 18520)
-- Name: user_weekly_plans user_weekly_plans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_weekly_plans
    ADD CONSTRAINT user_weekly_plans_pkey PRIMARY KEY (id);


--
-- TOC entry 4033 (class 2606 OID 18522)
-- Name: user_weekly_plans user_weekly_plans_user_id_week_start_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_weekly_plans
    ADD CONSTRAINT user_weekly_plans_user_id_week_start_key UNIQUE (user_id, week_start);


--
-- TOC entry 4028 (class 2606 OID 18388)
-- Name: user_workouts user_workouts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_workouts
    ADD CONSTRAINT user_workouts_pkey PRIMARY KEY (id);


--
-- TOC entry 3905 (class 2606 OID 17636)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3907 (class 2606 OID 17646)
-- Name: messages_2025_07_22 messages_2025_07_22_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_22
    ADD CONSTRAINT messages_2025_07_22_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3909 (class 2606 OID 17657)
-- Name: messages_2025_07_23 messages_2025_07_23_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_23
    ADD CONSTRAINT messages_2025_07_23_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3911 (class 2606 OID 17668)
-- Name: messages_2025_07_24 messages_2025_07_24_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_24
    ADD CONSTRAINT messages_2025_07_24_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3913 (class 2606 OID 17679)
-- Name: messages_2025_07_25 messages_2025_07_25_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_25
    ADD CONSTRAINT messages_2025_07_25_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3915 (class 2606 OID 17690)
-- Name: messages_2025_07_26 messages_2025_07_26_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.messages_2025_07_26
    ADD CONSTRAINT messages_2025_07_26_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3902 (class 2606 OID 17491)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 3899 (class 2606 OID 17465)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3867 (class 2606 OID 16510)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 3877 (class 2606 OID 16551)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3879 (class 2606 OID 16549)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3875 (class 2606 OID 16527)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 3923 (class 2606 OID 17787)
-- Name: prefixes prefixes_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT prefixes_pkey PRIMARY KEY (bucket_id, level, name);


--
-- TOC entry 3920 (class 2606 OID 17748)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 3918 (class 2606 OID 17733)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 3886 (class 2606 OID 16745)
-- Name: hooks hooks_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.hooks
    ADD CONSTRAINT hooks_pkey PRIMARY KEY (id);


--
-- TOC entry 3884 (class 2606 OID 16735)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: supabase_functions; Owner: supabase_functions_admin
--

ALTER TABLE ONLY supabase_functions.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3978 (class 2606 OID 18119)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: supabase_migrations; Owner: postgres
--

ALTER TABLE ONLY supabase_migrations.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3896 (class 1259 OID 17385)
-- Name: extensions_tenant_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE INDEX extensions_tenant_external_id_index ON _realtime.extensions USING btree (tenant_external_id);


--
-- TOC entry 3897 (class 1259 OID 17376)
-- Name: extensions_tenant_external_id_type_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX extensions_tenant_external_id_type_index ON _realtime.extensions USING btree (tenant_external_id, type);


--
-- TOC entry 3891 (class 1259 OID 17369)
-- Name: tenants_external_id_index; Type: INDEX; Schema: _realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX tenants_external_id_index ON _realtime.tenants USING btree (external_id);


--
-- TOC entry 3862 (class 1259 OID 16488)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3836 (class 1259 OID 17858)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3837 (class 1259 OID 17860)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3838 (class 1259 OID 17861)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3935 (class 1259 OID 17939)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 3967 (class 1259 OID 18047)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3924 (class 1259 OID 18027)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4560 (class 0 OID 0)
-- Dependencies: 3924
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3929 (class 1259 OID 17855)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 3970 (class 1259 OID 18044)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 3971 (class 1259 OID 18045)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3943 (class 1259 OID 18050)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3940 (class 1259 OID 17911)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3941 (class 1259 OID 18056)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 3974 (class 1259 OID 18103)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 3975 (class 1259 OID 18102)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 3976 (class 1259 OID 18104)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3839 (class 1259 OID 17862)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3840 (class 1259 OID 17859)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3849 (class 1259 OID 16471)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3850 (class 1259 OID 16472)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3851 (class 1259 OID 17854)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3854 (class 1259 OID 17941)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3857 (class 1259 OID 18046)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 3961 (class 1259 OID 17983)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 3962 (class 1259 OID 18048)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 3963 (class 1259 OID 17998)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 3966 (class 1259 OID 17997)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3930 (class 1259 OID 18049)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3933 (class 1259 OID 17940)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 3953 (class 1259 OID 17965)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 3956 (class 1259 OID 17964)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 3952 (class 1259 OID 17950)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 3942 (class 1259 OID 18109)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 3934 (class 1259 OID 17938)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3841 (class 1259 OID 18018)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4561 (class 0 OID 0)
-- Dependencies: 3841
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3842 (class 1259 OID 17856)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3843 (class 1259 OID 16461)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3844 (class 1259 OID 18073)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 3989 (class 1259 OID 18183)
-- Name: category_exercises_category_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_exercises_category_id_idx ON public.category_exercises USING btree (category_id);


--
-- TOC entry 3990 (class 1259 OID 18184)
-- Name: category_exercises_created_at_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX category_exercises_created_at_idx ON public.category_exercises USING btree (created_at);


--
-- TOC entry 3995 (class 1259 OID 18389)
-- Name: idx_ai_exercises_cache_goal_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ai_exercises_cache_goal_category ON public.ai_exercises_cache USING btree (goal_category);


--
-- TOC entry 4016 (class 1259 OID 18390)
-- Name: idx_user_exercise_history_goal_category; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_exercise_history_goal_category ON public.user_exercise_history USING btree (goal_category);


--
-- TOC entry 4017 (class 1259 OID 18391)
-- Name: idx_user_exercise_history_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_exercise_history_user_id ON public.user_exercise_history USING btree (user_id);


--
-- TOC entry 4020 (class 1259 OID 18392)
-- Name: idx_user_exercise_preferences_user_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_exercise_preferences_user_id ON public.user_exercise_preferences USING btree (user_id);


--
-- TOC entry 4029 (class 1259 OID 18531)
-- Name: idx_user_weekly_plans_user_id_week_start; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_weekly_plans_user_id_week_start ON public.user_weekly_plans USING btree (user_id, week_start);


--
-- TOC entry 3900 (class 1259 OID 17637)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 3903 (class 1259 OID 17540)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 3865 (class 1259 OID 16516)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3868 (class 1259 OID 16538)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 3916 (class 1259 OID 17759)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3869 (class 1259 OID 17805)
-- Name: idx_name_bucket_level_unique; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX idx_name_bucket_level_unique ON storage.objects USING btree (name COLLATE "C", bucket_id, level);


--
-- TOC entry 3870 (class 1259 OID 17724)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3871 (class 1259 OID 17807)
-- Name: idx_objects_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_lower_name ON storage.objects USING btree ((path_tokens[level]), lower(name) text_pattern_ops, bucket_id, level);


--
-- TOC entry 3921 (class 1259 OID 17808)
-- Name: idx_prefixes_lower_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_prefixes_lower_name ON storage.prefixes USING btree (bucket_id, level, ((string_to_array(name, '/'::text))[level]), lower(name) text_pattern_ops);


--
-- TOC entry 3872 (class 1259 OID 16539)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 3873 (class 1259 OID 17806)
-- Name: objects_bucket_id_level_idx; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX objects_bucket_id_level_idx ON storage.objects USING btree (bucket_id, level, name COLLATE "C");


--
-- TOC entry 3887 (class 1259 OID 16747)
-- Name: supabase_functions_hooks_h_table_id_h_name_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_h_table_id_h_name_idx ON supabase_functions.hooks USING btree (hook_table_id, hook_name);


--
-- TOC entry 3888 (class 1259 OID 16746)
-- Name: supabase_functions_hooks_request_id_idx; Type: INDEX; Schema: supabase_functions; Owner: supabase_functions_admin
--

CREATE INDEX supabase_functions_hooks_request_id_idx ON supabase_functions.hooks USING btree (request_id);


--
-- TOC entry 4034 (class 0 OID 0)
-- Name: messages_2025_07_22_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_22_pkey;


--
-- TOC entry 4035 (class 0 OID 0)
-- Name: messages_2025_07_23_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_23_pkey;


--
-- TOC entry 4036 (class 0 OID 0)
-- Name: messages_2025_07_24_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_24_pkey;


--
-- TOC entry 4037 (class 0 OID 0)
-- Name: messages_2025_07_25_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_25_pkey;


--
-- TOC entry 4038 (class 0 OID 0)
-- Name: messages_2025_07_26_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_07_26_pkey;


--
-- TOC entry 4087 (class 2620 OID 18173)
-- Name: user_body_measurements set_user_body_measurements_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_user_body_measurements_updated_at BEFORE UPDATE ON public.user_body_measurements FOR EACH ROW EXECUTE FUNCTION public.update_user_body_measurements_updated_at();


--
-- TOC entry 4085 (class 2620 OID 18135)
-- Name: user_goals set_user_goals_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_user_goals_updated_at BEFORE UPDATE ON public.user_goals FOR EACH ROW EXECUTE FUNCTION public.update_user_goals_updated_at();


--
-- TOC entry 4086 (class 2620 OID 18154)
-- Name: user_wearables_log set_user_wearables_log_updated_at; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER set_user_wearables_log_updated_at BEFORE UPDATE ON public.user_wearables_log FOR EACH ROW EXECUTE FUNCTION public.update_user_wearables_log_updated_at();


--
-- TOC entry 4082 (class 2620 OID 17496)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4077 (class 2620 OID 17815)
-- Name: buckets enforce_bucket_name_length_trigger; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER enforce_bucket_name_length_trigger BEFORE INSERT OR UPDATE OF name ON storage.buckets FOR EACH ROW EXECUTE FUNCTION storage.enforce_bucket_name_length();


--
-- TOC entry 4078 (class 2620 OID 17803)
-- Name: objects objects_delete_delete_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_delete_delete_prefix AFTER DELETE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 4079 (class 2620 OID 17801)
-- Name: objects objects_insert_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_insert_create_prefix BEFORE INSERT ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.objects_insert_prefix_trigger();


--
-- TOC entry 4080 (class 2620 OID 17802)
-- Name: objects objects_update_create_prefix; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER objects_update_create_prefix BEFORE UPDATE ON storage.objects FOR EACH ROW WHEN (((new.name <> old.name) OR (new.bucket_id <> old.bucket_id))) EXECUTE FUNCTION storage.objects_update_prefix_trigger();


--
-- TOC entry 4083 (class 2620 OID 17811)
-- Name: prefixes prefixes_create_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_create_hierarchy BEFORE INSERT ON storage.prefixes FOR EACH ROW WHEN ((pg_trigger_depth() < 1)) EXECUTE FUNCTION storage.prefixes_insert_trigger();


--
-- TOC entry 4084 (class 2620 OID 17800)
-- Name: prefixes prefixes_delete_hierarchy; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER prefixes_delete_hierarchy AFTER DELETE ON storage.prefixes FOR EACH ROW EXECUTE FUNCTION storage.delete_prefix_hierarchy_trigger();


--
-- TOC entry 4081 (class 2620 OID 17712)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4041 (class 2606 OID 17377)
-- Name: extensions extensions_tenant_external_id_fkey; Type: FK CONSTRAINT; Schema: _realtime; Owner: supabase_admin
--

ALTER TABLE ONLY _realtime.extensions
    ADD CONSTRAINT extensions_tenant_external_id_fkey FOREIGN KEY (tenant_external_id) REFERENCES _realtime.tenants(external_id) ON DELETE CASCADE;


--
-- TOC entry 4046 (class 2606 OID 17842)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4050 (class 2606 OID 17931)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4049 (class 2606 OID 17919)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4048 (class 2606 OID 17906)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4055 (class 2606 OID 18097)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4039 (class 2606 OID 17875)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4052 (class 2606 OID 17978)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4053 (class 2606 OID 18051)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4054 (class 2606 OID 17992)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4047 (class 2606 OID 17870)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4051 (class 2606 OID 17959)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4059 (class 2606 OID 18393)
-- Name: gym_equipment gym_equipment_gym_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_equipment
    ADD CONSTRAINT gym_equipment_gym_id_fkey FOREIGN KEY (gym_id) REFERENCES public.gyms(id) ON DELETE CASCADE;


--
-- TOC entry 4060 (class 2606 OID 18398)
-- Name: gym_subscriptions gym_subscriptions_gym_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_subscriptions
    ADD CONSTRAINT gym_subscriptions_gym_id_fkey FOREIGN KEY (gym_id) REFERENCES public.gyms(id) ON DELETE CASCADE;


--
-- TOC entry 4061 (class 2606 OID 18403)
-- Name: gym_subscriptions gym_subscriptions_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_subscriptions
    ADD CONSTRAINT gym_subscriptions_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.subscription_plans(id) ON DELETE CASCADE;


--
-- TOC entry 4062 (class 2606 OID 18408)
-- Name: gym_subscriptions gym_subscriptions_trainer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_subscriptions
    ADD CONSTRAINT gym_subscriptions_trainer_id_fkey FOREIGN KEY (trainer_id) REFERENCES public.personal_trainers(id);


--
-- TOC entry 4063 (class 2606 OID 18413)
-- Name: gym_subscriptions gym_subscriptions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_subscriptions
    ADD CONSTRAINT gym_subscriptions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.gym_user_profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4064 (class 2606 OID 18418)
-- Name: gym_user_profiles gym_user_profiles_current_gym_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_user_profiles
    ADD CONSTRAINT gym_user_profiles_current_gym_id_fkey FOREIGN KEY (current_gym_id) REFERENCES public.gyms(id);


--
-- TOC entry 4065 (class 2606 OID 18423)
-- Name: gym_user_profiles gym_user_profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gym_user_profiles
    ADD CONSTRAINT gym_user_profiles_id_fkey FOREIGN KEY (id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4066 (class 2606 OID 18428)
-- Name: gyms gyms_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gyms
    ADD CONSTRAINT gyms_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4067 (class 2606 OID 18433)
-- Name: personal_trainers personal_trainers_gym_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.personal_trainers
    ADD CONSTRAINT personal_trainers_gym_id_fkey FOREIGN KEY (gym_id) REFERENCES public.gyms(id) ON DELETE CASCADE;


--
-- TOC entry 4068 (class 2606 OID 18438)
-- Name: profiles profiles_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4069 (class 2606 OID 18443)
-- Name: subscription_plans subscription_plans_gym_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.subscription_plans
    ADD CONSTRAINT subscription_plans_gym_id_fkey FOREIGN KEY (gym_id) REFERENCES public.gyms(id) ON DELETE CASCADE;


--
-- TOC entry 4058 (class 2606 OID 18167)
-- Name: user_body_measurements user_body_measurements_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_body_measurements
    ADD CONSTRAINT user_body_measurements_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4070 (class 2606 OID 18448)
-- Name: user_exercise_history user_exercise_history_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_exercise_history
    ADD CONSTRAINT user_exercise_history_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- TOC entry 4071 (class 2606 OID 18453)
-- Name: user_exercise_preferences user_exercise_preferences_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_exercise_preferences
    ADD CONSTRAINT user_exercise_preferences_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- TOC entry 4056 (class 2606 OID 18129)
-- Name: user_goals user_goals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_goals
    ADD CONSTRAINT user_goals_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4072 (class 2606 OID 18458)
-- Name: user_nutrition_log user_nutrition_log_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_nutrition_log
    ADD CONSTRAINT user_nutrition_log_food_id_fkey FOREIGN KEY (food_id) REFERENCES public.nutrition(id) ON DELETE CASCADE;


--
-- TOC entry 4073 (class 2606 OID 18463)
-- Name: user_nutrition_log user_nutrition_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_nutrition_log
    ADD CONSTRAINT user_nutrition_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.gym_user_profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4057 (class 2606 OID 18148)
-- Name: user_wearables_log user_wearables_log_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_wearables_log
    ADD CONSTRAINT user_wearables_log_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4076 (class 2606 OID 18523)
-- Name: user_weekly_plans user_weekly_plans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_weekly_plans
    ADD CONSTRAINT user_weekly_plans_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- TOC entry 4074 (class 2606 OID 18468)
-- Name: user_workouts user_workouts_exercise_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_workouts
    ADD CONSTRAINT user_workouts_exercise_id_fkey FOREIGN KEY (exercise_id) REFERENCES public.exercises(id) ON DELETE CASCADE;


--
-- TOC entry 4075 (class 2606 OID 18473)
-- Name: user_workouts user_workouts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_workouts
    ADD CONSTRAINT user_workouts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.gym_user_profiles(id) ON DELETE CASCADE;


--
-- TOC entry 4040 (class 2606 OID 16528)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4045 (class 2606 OID 17788)
-- Name: prefixes prefixes_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.prefixes
    ADD CONSTRAINT "prefixes_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4042 (class 2606 OID 17734)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4043 (class 2606 OID 17754)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4044 (class 2606 OID 17749)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4236 (class 0 OID 16481)
-- Dependencies: 236
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4254 (class 0 OID 18037)
-- Dependencies: 281
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4245 (class 0 OID 17835)
-- Dependencies: 272
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4235 (class 0 OID 16474)
-- Dependencies: 235
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4249 (class 0 OID 17924)
-- Dependencies: 276
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4248 (class 0 OID 17912)
-- Dependencies: 275
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4247 (class 0 OID 17899)
-- Dependencies: 274
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4255 (class 0 OID 18087)
-- Dependencies: 282
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4234 (class 0 OID 16463)
-- Dependencies: 234
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4252 (class 0 OID 17966)
-- Dependencies: 279
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4253 (class 0 OID 17984)
-- Dependencies: 280
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4237 (class 0 OID 16489)
-- Dependencies: 237
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4246 (class 0 OID 17865)
-- Dependencies: 273
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4251 (class 0 OID 17951)
-- Dependencies: 278
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4250 (class 0 OID 17942)
-- Dependencies: 277
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4233 (class 0 OID 16451)
-- Dependencies: 232
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4272 (class 3256 OID 18478)
-- Name: exercises Anyone can view exercises; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view exercises" ON public.exercises FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4273 (class 3256 OID 18479)
-- Name: nutrition Anyone can view nutrition data; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view nutrition data" ON public.nutrition FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4274 (class 3256 OID 18480)
-- Name: products Anyone can view products; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Anyone can view products" ON public.products FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4275 (class 3256 OID 18481)
-- Name: ai_exercises_cache Everyone can view cached AI exercises; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Everyone can view cached AI exercises" ON public.ai_exercises_cache FOR SELECT USING (true);


--
-- TOC entry 4276 (class 3256 OID 18482)
-- Name: gym_equipment Gym admins can manage their equipment; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Gym admins can manage their equipment" ON public.gym_equipment USING ((gym_id IN ( SELECT gyms.id
   FROM public.gyms
  WHERE (gyms.admin_id = auth.uid()))));


--
-- TOC entry 4277 (class 3256 OID 18483)
-- Name: gyms Gym admins can manage their gyms; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Gym admins can manage their gyms" ON public.gyms USING ((admin_id = auth.uid()));


--
-- TOC entry 4278 (class 3256 OID 18484)
-- Name: subscription_plans Gym admins can manage their plans; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Gym admins can manage their plans" ON public.subscription_plans USING ((gym_id IN ( SELECT gyms.id
   FROM public.gyms
  WHERE (gyms.admin_id = auth.uid()))));


--
-- TOC entry 4279 (class 3256 OID 18485)
-- Name: personal_trainers Gym admins can manage their trainers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Gym admins can manage their trainers" ON public.personal_trainers USING ((gym_id IN ( SELECT gyms.id
   FROM public.gyms
  WHERE (gyms.admin_id = auth.uid()))));


--
-- TOC entry 4280 (class 3256 OID 18486)
-- Name: gym_subscriptions Gym admins can view their gym subscriptions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Gym admins can view their gym subscriptions" ON public.gym_subscriptions FOR SELECT USING ((gym_id IN ( SELECT gyms.id
   FROM public.gyms
  WHERE (gyms.admin_id = auth.uid()))));


--
-- TOC entry 4283 (class 3256 OID 18487)
-- Name: gym_user_profiles Gym admins can view their subscribers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Gym admins can view their subscribers" ON public.gym_user_profiles FOR SELECT USING ((current_gym_id IN ( SELECT gyms.id
   FROM public.gyms
  WHERE (gyms.admin_id = auth.uid()))));


--
-- TOC entry 4284 (class 3256 OID 18488)
-- Name: ai_exercises_cache Service role can manage AI exercises cache; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Service role can manage AI exercises cache" ON public.ai_exercises_cache TO service_role USING (true);


--
-- TOC entry 4285 (class 3256 OID 18489)
-- Name: gym_subscriptions Users can create subscriptions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create subscriptions" ON public.gym_subscriptions FOR INSERT WITH CHECK ((user_id = auth.uid()));


--
-- TOC entry 4286 (class 3256 OID 18490)
-- Name: user_exercise_history Users can create their own exercise history; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own exercise history" ON public.user_exercise_history FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4287 (class 3256 OID 18491)
-- Name: user_exercise_preferences Users can create their own exercise preferences; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own exercise preferences" ON public.user_exercise_preferences FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4288 (class 3256 OID 18492)
-- Name: gym_user_profiles Users can insert their own gym profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own gym profile" ON public.gym_user_profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- TOC entry 4289 (class 3256 OID 18493)
-- Name: profiles Users can insert their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own profile" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = id));


--
-- TOC entry 4305 (class 3256 OID 18529)
-- Name: user_weekly_plans Users can insert their own weekly plans; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own weekly plans" ON public.user_weekly_plans FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- TOC entry 4290 (class 3256 OID 18494)
-- Name: gym_user_profiles Users can manage their own gym profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can manage their own gym profile" ON public.gym_user_profiles USING ((id = auth.uid()));


--
-- TOC entry 4291 (class 3256 OID 18495)
-- Name: user_nutrition_log Users can manage their own nutrition log; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can manage their own nutrition log" ON public.user_nutrition_log USING ((user_id = auth.uid()));


--
-- TOC entry 4292 (class 3256 OID 18496)
-- Name: user_workouts Users can manage their own workouts; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can manage their own workouts" ON public.user_workouts USING ((user_id = auth.uid()));


--
-- TOC entry 4293 (class 3256 OID 18497)
-- Name: user_exercise_history Users can update their own exercise history; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own exercise history" ON public.user_exercise_history FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4294 (class 3256 OID 18498)
-- Name: user_exercise_preferences Users can update their own exercise preferences; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own exercise preferences" ON public.user_exercise_preferences FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4295 (class 3256 OID 18499)
-- Name: gym_user_profiles Users can update their own gym profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own gym profile" ON public.gym_user_profiles FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 4296 (class 3256 OID 18500)
-- Name: profiles Users can update their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own profile" ON public.profiles FOR UPDATE USING ((auth.uid() = id));


--
-- TOC entry 4306 (class 3256 OID 18530)
-- Name: user_weekly_plans Users can update their own weekly plans; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own weekly plans" ON public.user_weekly_plans FOR UPDATE USING ((auth.uid() = user_id));


--
-- TOC entry 4281 (class 3256 OID 18501)
-- Name: gyms Users can view all gyms; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view all gyms" ON public.gyms FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4282 (class 3256 OID 18502)
-- Name: gym_equipment Users can view gym equipment; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view gym equipment" ON public.gym_equipment FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4297 (class 3256 OID 18503)
-- Name: subscription_plans Users can view subscription plans; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view subscription plans" ON public.subscription_plans FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4298 (class 3256 OID 18504)
-- Name: user_exercise_history Users can view their own exercise history; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own exercise history" ON public.user_exercise_history FOR SELECT USING ((auth.uid() = user_id));


--
-- TOC entry 4299 (class 3256 OID 18505)
-- Name: user_exercise_preferences Users can view their own exercise preferences; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own exercise preferences" ON public.user_exercise_preferences FOR SELECT USING ((auth.uid() = user_id));


--
-- TOC entry 4300 (class 3256 OID 18506)
-- Name: gym_user_profiles Users can view their own gym profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own gym profile" ON public.gym_user_profiles FOR SELECT USING ((auth.uid() = id));


--
-- TOC entry 4301 (class 3256 OID 18507)
-- Name: profiles Users can view their own profile; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own profile" ON public.profiles FOR SELECT USING ((auth.uid() = id));


--
-- TOC entry 4302 (class 3256 OID 18508)
-- Name: gym_subscriptions Users can view their own subscriptions; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own subscriptions" ON public.gym_subscriptions FOR SELECT USING ((user_id = auth.uid()));


--
-- TOC entry 4304 (class 3256 OID 18528)
-- Name: user_weekly_plans Users can view their own weekly plans; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own weekly plans" ON public.user_weekly_plans FOR SELECT USING ((auth.uid() = user_id));


--
-- TOC entry 4303 (class 3256 OID 18509)
-- Name: personal_trainers Users can view trainers; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view trainers" ON public.personal_trainers FOR SELECT TO authenticated USING (true);


--
-- TOC entry 4256 (class 0 OID 18236)
-- Dependencies: 288
-- Name: ai_exercises_cache; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.ai_exercises_cache ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4257 (class 0 OID 18244)
-- Dependencies: 289
-- Name: exercises; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.exercises ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4258 (class 0 OID 18251)
-- Dependencies: 290
-- Name: gym_equipment; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.gym_equipment ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4259 (class 0 OID 18259)
-- Dependencies: 291
-- Name: gym_subscriptions; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.gym_subscriptions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4260 (class 0 OID 18265)
-- Dependencies: 292
-- Name: gym_user_profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.gym_user_profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4261 (class 0 OID 18272)
-- Dependencies: 293
-- Name: gyms; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.gyms ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4262 (class 0 OID 18280)
-- Dependencies: 294
-- Name: nutrition; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.nutrition ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4263 (class 0 OID 18287)
-- Dependencies: 295
-- Name: personal_trainers; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.personal_trainers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4264 (class 0 OID 18294)
-- Dependencies: 296
-- Name: products; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4265 (class 0 OID 18302)
-- Dependencies: 297
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4266 (class 0 OID 18310)
-- Dependencies: 298
-- Name: subscription_plans; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.subscription_plans ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4267 (class 0 OID 18318)
-- Dependencies: 299
-- Name: user_exercise_history; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_exercise_history ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4268 (class 0 OID 18327)
-- Dependencies: 300
-- Name: user_exercise_preferences; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_exercise_preferences ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4269 (class 0 OID 18341)
-- Dependencies: 301
-- Name: user_nutrition_log; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_nutrition_log ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4271 (class 0 OID 18511)
-- Dependencies: 303
-- Name: user_weekly_plans; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_weekly_plans ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4270 (class 0 OID 18349)
-- Dependencies: 302
-- Name: user_workouts; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.user_workouts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4241 (class 0 OID 17622)
-- Dependencies: 263
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4238 (class 0 OID 16502)
-- Dependencies: 238
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4240 (class 0 OID 16544)
-- Dependencies: 240
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4239 (class 0 OID 16517)
-- Dependencies: 239
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4244 (class 0 OID 17778)
-- Dependencies: 271
-- Name: prefixes; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.prefixes ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4242 (class 0 OID 17725)
-- Dependencies: 269
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4243 (class 0 OID 17739)
-- Dependencies: 270
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4307 (class 6104 OID 16388)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4371 (class 0 OID 0)
-- Dependencies: 22
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4372 (class 0 OID 0)
-- Dependencies: 17
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4374 (class 0 OID 0)
-- Dependencies: 13
-- Name: SCHEMA net; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA net TO supabase_functions_admin;
GRANT USAGE ON SCHEMA net TO postgres;
GRANT USAGE ON SCHEMA net TO anon;
GRANT USAGE ON SCHEMA net TO authenticated;
GRANT USAGE ON SCHEMA net TO service_role;


--
-- TOC entry 4375 (class 0 OID 0)
-- Dependencies: 18
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- TOC entry 4376 (class 0 OID 0)
-- Dependencies: 14
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4377 (class 0 OID 0)
-- Dependencies: 21
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4378 (class 0 OID 0)
-- Dependencies: 11
-- Name: SCHEMA supabase_functions; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA supabase_functions TO postgres;
GRANT USAGE ON SCHEMA supabase_functions TO anon;
GRANT USAGE ON SCHEMA supabase_functions TO authenticated;
GRANT USAGE ON SCHEMA supabase_functions TO service_role;
GRANT ALL ON SCHEMA supabase_functions TO supabase_functions_admin;


--
-- TOC entry 4379 (class 0 OID 0)
-- Dependencies: 16
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4386 (class 0 OID 0)
-- Dependencies: 327
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4387 (class 0 OID 0)
-- Dependencies: 417
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 326
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 325
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 336
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4393 (class 0 OID 0)
-- Dependencies: 337
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4394 (class 0 OID 0)
-- Dependencies: 382
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 338
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4396 (class 0 OID 0)
-- Dependencies: 343
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4397 (class 0 OID 0)
-- Dependencies: 345
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 379
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4399 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4400 (class 0 OID 0)
-- Dependencies: 342
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 344
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 346
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4403 (class 0 OID 0)
-- Dependencies: 347
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 340
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4405 (class 0 OID 0)
-- Dependencies: 341
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4409 (class 0 OID 0)
-- Dependencies: 358
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4411 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM supabase_admin;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO supabase_admin WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4412 (class 0 OID 0)
-- Dependencies: 381
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4413 (class 0 OID 0)
-- Dependencies: 380
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4414 (class 0 OID 0)
-- Dependencies: 354
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4415 (class 0 OID 0)
-- Dependencies: 360
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4416 (class 0 OID 0)
-- Dependencies: 356
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4417 (class 0 OID 0)
-- Dependencies: 339
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4418 (class 0 OID 0)
-- Dependencies: 335
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4419 (class 0 OID 0)
-- Dependencies: 372
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4420 (class 0 OID 0)
-- Dependencies: 374
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4421 (class 0 OID 0)
-- Dependencies: 376
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4422 (class 0 OID 0)
-- Dependencies: 373
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4423 (class 0 OID 0)
-- Dependencies: 375
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4424 (class 0 OID 0)
-- Dependencies: 377
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4425 (class 0 OID 0)
-- Dependencies: 318
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4426 (class 0 OID 0)
-- Dependencies: 320
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4427 (class 0 OID 0)
-- Dependencies: 319
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4428 (class 0 OID 0)
-- Dependencies: 321
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4429 (class 0 OID 0)
-- Dependencies: 370
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4430 (class 0 OID 0)
-- Dependencies: 316
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4431 (class 0 OID 0)
-- Dependencies: 371
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4432 (class 0 OID 0)
-- Dependencies: 317
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4433 (class 0 OID 0)
-- Dependencies: 348
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4434 (class 0 OID 0)
-- Dependencies: 368
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4435 (class 0 OID 0)
-- Dependencies: 349
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4436 (class 0 OID 0)
-- Dependencies: 369
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4437 (class 0 OID 0)
-- Dependencies: 362
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4438 (class 0 OID 0)
-- Dependencies: 355
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4440 (class 0 OID 0)
-- Dependencies: 357
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4441 (class 0 OID 0)
-- Dependencies: 334
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4442 (class 0 OID 0)
-- Dependencies: 322
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4443 (class 0 OID 0)
-- Dependencies: 323
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4444 (class 0 OID 0)
-- Dependencies: 324
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4445 (class 0 OID 0)
-- Dependencies: 328
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;


--
-- TOC entry 4446 (class 0 OID 0)
-- Dependencies: 329
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4447 (class 0 OID 0)
-- Dependencies: 330
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4448 (class 0 OID 0)
-- Dependencies: 332
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 331
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4450 (class 0 OID 0)
-- Dependencies: 333
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4451 (class 0 OID 0)
-- Dependencies: 383
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4452 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- TOC entry 4453 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer); Type: ACL; Schema: net; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO postgres;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO anon;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO authenticated;
GRANT ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO service_role;


--
-- TOC entry 4454 (class 0 OID 0)
-- Dependencies: 304
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 4455 (class 0 OID 0)
-- Dependencies: 353
-- Name: FUNCTION handle_new_user(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.handle_new_user() TO anon;
GRANT ALL ON FUNCTION public.handle_new_user() TO authenticated;
GRANT ALL ON FUNCTION public.handle_new_user() TO service_role;


--
-- TOC entry 4456 (class 0 OID 0)
-- Dependencies: 351
-- Name: FUNCTION update_user_body_measurements_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_user_body_measurements_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_user_body_measurements_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_user_body_measurements_updated_at() TO service_role;


--
-- TOC entry 4457 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION update_user_goals_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_user_goals_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_user_goals_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_user_goals_updated_at() TO service_role;


--
-- TOC entry 4458 (class 0 OID 0)
-- Dependencies: 350
-- Name: FUNCTION update_user_wearables_log_updated_at(); Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON FUNCTION public.update_user_wearables_log_updated_at() TO anon;
GRANT ALL ON FUNCTION public.update_user_wearables_log_updated_at() TO authenticated;
GRANT ALL ON FUNCTION public.update_user_wearables_log_updated_at() TO service_role;


--
-- TOC entry 4459 (class 0 OID 0)
-- Dependencies: 414
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4460 (class 0 OID 0)
-- Dependencies: 422
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4461 (class 0 OID 0)
-- Dependencies: 413
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4462 (class 0 OID 0)
-- Dependencies: 407
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4463 (class 0 OID 0)
-- Dependencies: 418
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4464 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4465 (class 0 OID 0)
-- Dependencies: 415
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4466 (class 0 OID 0)
-- Dependencies: 406
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4467 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4468 (class 0 OID 0)
-- Dependencies: 419
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4469 (class 0 OID 0)
-- Dependencies: 411
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4470 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4471 (class 0 OID 0)
-- Dependencies: 401
-- Name: FUNCTION http_request(); Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

REVOKE ALL ON FUNCTION supabase_functions.http_request() FROM PUBLIC;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO postgres;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO anon;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO authenticated;
GRANT ALL ON FUNCTION supabase_functions.http_request() TO service_role;


--
-- TOC entry 4472 (class 0 OID 0)
-- Dependencies: 367
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 4473 (class 0 OID 0)
-- Dependencies: 366
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4474 (class 0 OID 0)
-- Dependencies: 352
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4476 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4478 (class 0 OID 0)
-- Dependencies: 281
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4481 (class 0 OID 0)
-- Dependencies: 272
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4483 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4485 (class 0 OID 0)
-- Dependencies: 276
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4487 (class 0 OID 0)
-- Dependencies: 275
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4489 (class 0 OID 0)
-- Dependencies: 274
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4490 (class 0 OID 0)
-- Dependencies: 282
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4492 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4494 (class 0 OID 0)
-- Dependencies: 233
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4496 (class 0 OID 0)
-- Dependencies: 279
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4498 (class 0 OID 0)
-- Dependencies: 280
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4500 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 273
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 278
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 277
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 232
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 242
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;


--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;


--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE ai_exercises_cache; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.ai_exercises_cache TO anon;
GRANT ALL ON TABLE public.ai_exercises_cache TO authenticated;
GRANT ALL ON TABLE public.ai_exercises_cache TO service_role;


--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE category_exercises; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.category_exercises TO anon;
GRANT ALL ON TABLE public.category_exercises TO authenticated;
GRANT ALL ON TABLE public.category_exercises TO service_role;


--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE exercises; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.exercises TO anon;
GRANT ALL ON TABLE public.exercises TO authenticated;
GRANT ALL ON TABLE public.exercises TO service_role;


--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 290
-- Name: TABLE gym_equipment; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.gym_equipment TO anon;
GRANT ALL ON TABLE public.gym_equipment TO authenticated;
GRANT ALL ON TABLE public.gym_equipment TO service_role;


--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE gym_subscriptions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.gym_subscriptions TO anon;
GRANT ALL ON TABLE public.gym_subscriptions TO authenticated;
GRANT ALL ON TABLE public.gym_subscriptions TO service_role;


--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE gym_user_profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.gym_user_profiles TO anon;
GRANT ALL ON TABLE public.gym_user_profiles TO authenticated;
GRANT ALL ON TABLE public.gym_user_profiles TO service_role;


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE gyms; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.gyms TO anon;
GRANT ALL ON TABLE public.gyms TO authenticated;
GRANT ALL ON TABLE public.gyms TO service_role;


--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE nutrition; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.nutrition TO anon;
GRANT ALL ON TABLE public.nutrition TO authenticated;
GRANT ALL ON TABLE public.nutrition TO service_role;


--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE personal_trainers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.personal_trainers TO anon;
GRANT ALL ON TABLE public.personal_trainers TO authenticated;
GRANT ALL ON TABLE public.personal_trainers TO service_role;


--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE products; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.products TO anon;
GRANT ALL ON TABLE public.products TO authenticated;
GRANT ALL ON TABLE public.products TO service_role;


--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 297
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.profiles TO anon;
GRANT ALL ON TABLE public.profiles TO authenticated;
GRANT ALL ON TABLE public.profiles TO service_role;


--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE subscription_plans; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.subscription_plans TO anon;
GRANT ALL ON TABLE public.subscription_plans TO authenticated;
GRANT ALL ON TABLE public.subscription_plans TO service_role;


--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 286
-- Name: TABLE user_body_measurements; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_body_measurements TO anon;
GRANT ALL ON TABLE public.user_body_measurements TO authenticated;
GRANT ALL ON TABLE public.user_body_measurements TO service_role;


--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE user_exercise_history; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_exercise_history TO anon;
GRANT ALL ON TABLE public.user_exercise_history TO authenticated;
GRANT ALL ON TABLE public.user_exercise_history TO service_role;


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 300
-- Name: TABLE user_exercise_preferences; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_exercise_preferences TO anon;
GRANT ALL ON TABLE public.user_exercise_preferences TO authenticated;
GRANT ALL ON TABLE public.user_exercise_preferences TO service_role;


--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 284
-- Name: TABLE user_goals; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_goals TO anon;
GRANT ALL ON TABLE public.user_goals TO authenticated;
GRANT ALL ON TABLE public.user_goals TO service_role;


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 301
-- Name: TABLE user_nutrition_log; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_nutrition_log TO anon;
GRANT ALL ON TABLE public.user_nutrition_log TO authenticated;
GRANT ALL ON TABLE public.user_nutrition_log TO service_role;


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 285
-- Name: TABLE user_wearables_log; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_wearables_log TO anon;
GRANT ALL ON TABLE public.user_wearables_log TO authenticated;
GRANT ALL ON TABLE public.user_wearables_log TO service_role;


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE user_weekly_plans; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_weekly_plans TO anon;
GRANT ALL ON TABLE public.user_weekly_plans TO authenticated;
GRANT ALL ON TABLE public.user_weekly_plans TO service_role;


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE user_workouts; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.user_workouts TO anon;
GRANT ALL ON TABLE public.user_workouts TO authenticated;
GRANT ALL ON TABLE public.user_workouts TO service_role;


--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 264
-- Name: TABLE messages_2025_07_22; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_22 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_22 TO dashboard_user;


--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 265
-- Name: TABLE messages_2025_07_23; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_23 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_23 TO dashboard_user;


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 266
-- Name: TABLE messages_2025_07_24; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_24 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_24 TO dashboard_user;


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 267
-- Name: TABLE messages_2025_07_25; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_25 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_25 TO dashboard_user;


--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 268
-- Name: TABLE messages_2025_07_26; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.messages_2025_07_26 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_07_26 TO dashboard_user;


--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 259
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 271
-- Name: TABLE prefixes; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.prefixes TO service_role;
GRANT ALL ON TABLE storage.prefixes TO authenticated;
GRANT ALL ON TABLE storage.prefixes TO anon;


--
-- TOC entry 4548 (class 0 OID 0)
-- Dependencies: 269
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4549 (class 0 OID 0)
-- Dependencies: 270
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4551 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE hooks; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.hooks TO postgres;
GRANT ALL ON TABLE supabase_functions.hooks TO anon;
GRANT ALL ON TABLE supabase_functions.hooks TO authenticated;
GRANT ALL ON TABLE supabase_functions.hooks TO service_role;


--
-- TOC entry 4553 (class 0 OID 0)
-- Dependencies: 252
-- Name: SEQUENCE hooks_id_seq; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO postgres;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO anon;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO authenticated;
GRANT ALL ON SEQUENCE supabase_functions.hooks_id_seq TO service_role;


--
-- TOC entry 4554 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE migrations; Type: ACL; Schema: supabase_functions; Owner: supabase_functions_admin
--

GRANT ALL ON TABLE supabase_functions.migrations TO postgres;
GRANT ALL ON TABLE supabase_functions.migrations TO anon;
GRANT ALL ON TABLE supabase_functions.migrations TO authenticated;
GRANT ALL ON TABLE supabase_functions.migrations TO service_role;


--
-- TOC entry 4555 (class 0 OID 0)
-- Dependencies: 243
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 4556 (class 0 OID 0)
-- Dependencies: 244
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: supabase_admin
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2489 (class 826 OID 16590)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- TOC entry 2490 (class 826 OID 16591)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- TOC entry 2488 (class 826 OID 16589)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- TOC entry 2499 (class 826 OID 16664)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- TOC entry 2498 (class 826 OID 16663)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- TOC entry 2497 (class 826 OID 16662)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- TOC entry 2502 (class 826 OID 16624)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2501 (class 826 OID 16623)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2500 (class 826 OID 16622)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2494 (class 826 OID 16604)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2496 (class 826 OID 16603)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2495 (class 826 OID 16602)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2506 (class 826 OID 16446)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2482 (class 826 OID 16447)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2507 (class 826 OID 16445)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2484 (class 826 OID 16449)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2508 (class 826 OID 16444)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2483 (class 826 OID 16448)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2492 (class 826 OID 16594)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- TOC entry 2493 (class 826 OID 16595)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- TOC entry 2491 (class 826 OID 16593)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- TOC entry 2487 (class 826 OID 16501)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2486 (class 826 OID 16500)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2485 (class 826 OID 16499)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2505 (class 826 OID 16727)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2504 (class 826 OID 16726)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2503 (class 826 OID 16725)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: supabase_functions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA supabase_functions GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 3674 (class 3466 OID 16608)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- TOC entry 3679 (class 3466 OID 16677)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- TOC entry 3673 (class 3466 OID 16606)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- TOC entry 3680 (class 3466 OID 16678)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO supabase_admin;

--
-- TOC entry 3675 (class 3466 OID 16609)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- TOC entry 3676 (class 3466 OID 16610)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

-- Completed on 2025-07-23 19:15:17 IST

--
-- PostgreSQL database dump complete
--

