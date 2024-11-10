-- ********************************************************************************
-- This script creates the database users and grants them the necessary permissions
-- ********************************************************************************

CREATE USER spotowner1
WITH PASSWORD 'finalcapstone';

GRANT ALL
ON ALL TABLES IN SCHEMA public
TO spotowner1;

GRANT ALL
ON ALL SEQUENCES IN SCHEMA public
TO spotowner1;

CREATE USER i_see_spot
WITH PASSWORD 'go-spot-go';

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO i_see_spot;

GRANT USAGE, SELECT
ON ALL SEQUENCES IN SCHEMA public
TO i_see_spot;
;
