-- PostgreSQL initialization script
-- This script sets up the database, user, and permissions based on the localstack secret configuration

-- Create the database user (using DO block to check if exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_roles WHERE rolname = 'postgres-user') THEN
        CREATE USER "postgres-user" WITH PASSWORD 'postgres-pass';
        RAISE NOTICE 'User postgres-user created';
    ELSE
        RAISE NOTICE 'User postgres-user already exists';
    END IF;
END
$$;

-- Create the database (using DO block to check if exists)
DO $$
BEGIN
    IF NOT EXISTS (SELECT FROM pg_database WHERE datname = 'postgres-db') THEN
        PERFORM dblink_exec('dbname=' || current_database(), 'CREATE DATABASE "postgres-db" WITH OWNER "postgres-user"');
        RAISE NOTICE 'Database postgres-db created';
    ELSE
        RAISE NOTICE 'Database postgres-db already exists';
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        -- Fallback: try to create database directly (will fail if exists, but that's ok)
        CREATE DATABASE "postgres-db" WITH OWNER "postgres-user";
END
$$;

-- Grant all privileges on the database to the user
GRANT ALL PRIVILEGES ON DATABASE "postgres-db" TO "postgres-user";

-- Connect to the new database to set up additional permissions
\c "postgres-db";

-- Grant schema permissions
GRANT ALL ON SCHEMA public TO "postgres-user";
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO "postgres-user";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO "postgres-user";

-- Grant future object permissions
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON TABLES TO "postgres-user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL ON SEQUENCES TO "postgres-user";

-- Log the setup completion
DO $$
BEGIN
    RAISE NOTICE 'Database setup completed successfully!';
    RAISE NOTICE 'Database: postgres-db';
    RAISE NOTICE 'User: postgres-user';
    RAISE NOTICE 'Ready for N8N connection';
END $$;