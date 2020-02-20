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
# NAME: postinstall
#
# DESCRIPTION: oracle database software post installation task(s) 
#
# The following steps are perfomed as oracle OS user
#
# SUMMARY OF STEPS:
# - check syntax
# - apply configuration file
# - apply environment variables
# - create database
# - apply TNS settings

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

# cancel db creation in this job. Refer to createDatabase.sh to create db
# db creation
#${scriptRoot}/createDatabase.sh $1
#exit 1;

# listener creation
if [ -f "$TNS_ADMIN/listener.ora" ]
then
 cp $TNS_ADMIN/listener.ora $TNS_ADMIN/listener.ora.`date +%m%d%y_%s`
fi

cp ${oracleListener} $TNS_ADMIN/listener.ora
lsnrctl stop
lsnrctl start

# sqlnet creation
if [ -f "$TNS_ADMIN/sqlnet.ora" ]
then
 cp $TNS_ADMIN/sqlnet.ora $TNS_ADMIN/sqlnet.ora.`date +%m%d%y_%s`
fi

cp ${oracleSqlnet} $TNS_ADMIN/sqlnet.ora

# tnsnames creation
if [ -f "$TNS_ADMIN/tnsnames.ora" ]
then
 cp $TNS_ADMIN/tnsnames.ora $TNS_ADMIN/tnsnames.ora.`date +%m%d%y_%s`
fi

cp ${oracleTnsnames} $TNS_ADMIN/tnsnames.ora


