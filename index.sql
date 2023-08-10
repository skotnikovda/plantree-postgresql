DROP DATABASE IF EXISTS plantree;
CREATE DATABASE plantree;
\c plantree
SET client_min_messages TO WARNING;
\i types.sql
\i tables.sql
\i rules.sql
\i triggers/insert.sql
\i triggers/delete.sql
\i triggers/update.sql