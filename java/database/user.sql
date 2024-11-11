-- ********************************************************************************
-- This script creates the database users and grants them the necessary permissions
-- ********************************************************************************

CREATE USER spotowner3
WITH PASSWORD 'finalcapstone';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO spotowner3;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO spotowner3;

CREATE USER frank_the_dog
WITH PASSWORD 'go-frank-go';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO frank_the_dog;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO frank_the_dog;
;
