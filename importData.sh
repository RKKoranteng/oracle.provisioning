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
# NAME: importData
#
# DESCRIPTION: Data pump import script

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

if [ -f "${scriptRoot}/db/${ORACLE_SID}/dataImport.conf" ]
then

 # create database link
 for i in $(cat ${scriptRoot}/db/${ORACLE_SID}/dataImport.conf)
 do
  export $i
 done

 sqlplus -S -L / as sysdba << ENDSQL
  create database link ora-prov
  connect to SYSTEM identified by ${sourcePassword}
  using '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)(HOST=${sourceHost})(PORT=${sourcePort}))(CONNECT_DATA=(SERVICE_NAME=${sourceDB})))';
  exit;
ENDSQL

 # create user
 sqlplus -S -L / as sysdba << ENDSQL
 @${scriptRoot}/db/${ORACLE_SID}/userDDL.sql
 exit;
ENDSQL

 # import data
 impdp \'/ as sysdba\' schemas=${sourceSchema} network_link=ora-prov directory=DATA_PUMP_DIR logfile=imp_migration.log

else
 echo -e "\nError: Invalid/missing data pump config file '${scriptRoot}/db/${ORACLE_SID}/dataImport.conf'\n"
 exit 1;
fi
