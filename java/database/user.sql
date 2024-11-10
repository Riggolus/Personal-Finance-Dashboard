-- ********************************************************************************
-- This script creates the database users and grants them the necessary permissions
-- ********************************************************************************

CREATE USER spotowner2
WITH PASSWORD 'finalcapstone';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO spotowner2;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO spotowner2;

CREATE USER frank_dog
WITH PASSWORD 'go-frank-go';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO frank_dog;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO frank_dog;
;
