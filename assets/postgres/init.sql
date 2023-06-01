
create database keycloak;
CREATE USER keycloak_user WITH PASSWORD 'pass123';
GRANT ALL PRIVILEGES ON DATABASE keycloak TO keycloak_user;

create database test_db;
CREATE USER dbuser
WITH PASSWORD 'pass123';
GRANT ALL PRIVILEGES ON DATABASE test_db TO dbuser;

