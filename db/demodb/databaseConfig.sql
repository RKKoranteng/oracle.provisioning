-- AUTHOR: Richard Koranteng (richard@rkkoranteng.com)
--
-- NAME: databaseConfig.sql

-- DESCRIPTION: oracle instance and database configs specifc to each db

-- The following script is run as SYS

-- put your oracle db specific configs here. In example below I'm adding application tablespace

-- instance parameters
alter system set db_recovery_file_dest='/ora/data5/fast_recovery_area/DEMODB' scope=spfile;
alter system set db_recovery_file_dest_size=32212254720 scope=spfile;
alter system set control_files='/ora/data1/oradata/DEMODB/control01.ctl','/ora/data5/fast_recovery_area/DEMODB/control02.ctl' scope=spfile;
alter system set java_pool_size=16777216 scope=spfile;
alter system set log_checkpoint_interval=10000 scope=spfile;
alter system set memory_max_target=9g scope=spfile;
alter system set memory_target=8g scope=spfile;
alter system set open_cursors=2000 scope=spfile;
alter system set optimizer_index_caching=90 scope=spfile;
alter system set pga_aggregate_limit=0 scope=spfile;
alter system set processes=600 scope=spfile;
alter system set session_cached_cursors=1500 scope=spfile;
alter system set sga_target=0 scope=spfile;
alter system set sga_max_size=0 scope=spfile;

-- tablespaces
CREATE TABLESPACE "APP_DATA" DATAFILE '/ora/data1/oradata/DEMODB/app_data.dbf' SIZE 6186598400
AUTOEXTEND ON NEXT 104857600 MAXSIZE 32767M
LOGGING ONLINE PERMANENT BLOCKSIZE 8192
EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT
NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;
