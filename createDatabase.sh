#!/bin/bash
# MIT License
# Copyright (c) 2020 Richard Koranteng.
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# AUTHOR: Richard Koranteng (richard@rkkoranteng.com)
#
# NAME: createDatabase
#
# DESCRIPTION: oracle database creation script

# syntax check
if [ $# -ne 1 ]
then
 echo -e "\nUsage: $0 <db name>\n"
 exit 1;
fi

# source variables
if [ -f "configuration.sh" ]
then
  . configuration.sh
else
 echo -e "\nError: Invalid/missing environment config file 'configuration.sh'\n"
 exit 1;
fi

. ~/.bash_profile
ORACLE_SID=$1

# db creation
if [ -f "${scriptRoot}/db/${ORACLE_SID}/databaseCreation.rsp" ]
then

 if [ -f "${scriptRoot}/db/${ORACLE_SID}/databaseTemplate.dbc" ]
 then
  DBUN=`echo ${ORACLE_SID} | tr '[:lower:]' '[:upper:]'`

  if [ ! -d "/ora/data5/fast_recovery_area/${DBUN}" ]
  then
   mkdir -p /ora/data5/fast_recovery_area/${DBUN}
  fi

  dbca -silent -createDatabase -responseFile ${scriptRoot}/db/${ORACLE_SID}/databaseCreation.rsp
 else
  echo -e "\nError: Invalid/missing db creation response file '${scriptRoot}/db/${ORACLE_SID}/databaseTemplate.dbc'\n"
  exit 1;
 fi

else

  echo -e "\nError: Invalid/missing db creation template file '${scriptRoot}/db/${ORACLE_SID}/databaseCreation.rsp'\n"

fi

# db custom config
sqlplus -S -L / as sysdba << ENDSQL
 create pfile='${ORACLE_HOME}/dbs/init${ORACLE_SID}.ora.bak' from spfile;
 @${scriptRoot}/db/${ORACLE_SID}/databaseConfig.sql
 shutdown immediate
 exit;
ENDSQL

if [ -f "/ora/data1/oradata/${DBUN}/control02.ctl" ]
then
 mv /ora/data1/oradata/${DBUN}/control02.ctl /ora/data5/fast_recovery_area/${DBUN}/control02.ctl
elif [ -f "/ora/data2/oradata/${DBUN}/control02.ctl" ]
then
 mv /ora/data2/oradata/${DBUN}/control02.ctl /ora/data5/fast_recovery_area/${DBUN}/control02.ctl
fi

sqlplus -S -L / as sysdba << ENDSQL
 startup
 exit;
ENDSQL

mv ${ORACLE_HOME}/dbs/init${ORACLE_SID}.ora.bak ${ORACLE_HOME}/dbs/init${ORACLE_SID}.ora.`date +%m%d%y_%s`
