-- AUTHOR: Richard Koranteng (richard@rkkoranteng.com)
--
-- NAME: databaseConfig.sql

-- DESCRIPTION: oracle instance and database configs specifc to each db

-- The following script is run as SYS

-- put your oracle db specific configs here. In example below I'm adding application tablespace

CREATE TABLESPACE "APP_DATA" DATAFILE '/ora/data1/oradata/DEMODB/app_data.dbf' SIZE 6186598400
AUTOEXTEND ON NEXT 104857600 MAXSIZE 32767M
LOGGING ONLINE PERMANENT BLOCKSIZE 8192
EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT
NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;
