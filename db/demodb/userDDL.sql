-- put your DDL to create your db identities (users and roles)
-- put your DCL to grant your db identities permissions
-- In the example below I'm creating a role, a user, and granted the user some permissions


-- profiles
CREATE PROFILE "APP_PROFILE"
LIMIT
COMPOSITE_LIMIT UNLIMITED
SESSIONS_PER_USER UNLIMITED
CPU_PER_SESSION UNLIMITED
CPU_PER_CALL UNLIMITED
LOGICAL_READS_PER_SESSION UNLIMITED
LOGICAL_READS_PER_CALL UNLIMITED
IDLE_TIME UNLIMITED
CONNECT_TIME UNLIMITED
PRIVATE_SGA UNLIMITED
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LIFE_TIME UNLIMITED
PASSWORD_REUSE_TIME UNLIMITED
PASSWORD_REUSE_MAX UNLIMITED
PASSWORD_VERIFY_FUNCTION DEFAULT
PASSWORD_LOCK_TIME UNLIMITED
PASSWORD_GRACE_TIME UNLIMITED ;

CREATE USER "APP_USER" IDENTIFIED BY VALUES 'supersecret'
DEFAULT TABLESPACE "SYSAUX"
TEMPORARY TABLESPACE "TEMP"
PROFILE "APP_PROFILE";

GRANT "CONNECT" TO "APP_USER" ;
GRANT "RESOURCE" TO "APP_USER" ;
