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
# NAME: preinstall
#
# DESCRIPTION: oracle database software pre-installation task(s) 
#
# The following steps are perfomed as root OS user
#
# SUMMARY OF STEPS:
# - check syntax
# - apply configuration file
# - check /etc/hosts and /etc/hostname
# - apply OS kernel parameters
# - apply OS limit parameters
# - create OS user and group
# - apply SELinux parameters
# - create OS directories and assign permissions

# syntax check
if [ $# -gt 0 ]
then
 echo -e "\nUsage: $0\n"
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

# host file
host=`hostname`

if [ `grep -w ${host} /etc/hosts |wc -l` -gt 0 ]
then 
 echo "ChecK Pass: Hostname found in /etc/hosts"
else 
 echo "Check Fail: Missing entry for host /etc/hosts"
 exit 1;
fi

if [ `grep -w ${host} /etc/hostname |wc -l` -gt 0 ]
then
 echo "ChecK Pass: Hostname found in /etc/hostname"
else
 echo "Check Fail: Missing entry for host /etc/hostname"
 exit 1;
fi


# sysctl
if [ -f "/etc/sysctl.conf" ]
then
 cp /etc/sysctl.conf /etc/sysctl.conf.`date +%m%d%y_%s`
fi

echo "" >> /etc/sysctl.conf
cat ${oracleSysctl} >> /etc/sysctl.conf
sysctl -p

# limits
if [ -f "/etc/security/limits.conf" ]
then
 cp /etc/security/limits.conf /etc/security/limits.conf.`date +%m%d%y_%s`
fi

echo "" >> /etc/security/limits.conf
cat ${oracleLimits} >> /etc/security/limits.conf
 

# packages
while read line 
do
 yum install -y $line
done < ${oraclePackage}

# user and group creation
#for i in $(echo ${oracleGroup})
#do
# groupadd $i
# useradd -g $i ${oracleUser}
#done

# selinux
if [ -f "/etc/selinux/config" ]
then
 cp /etc/selinux/config /etc/selinux/config.`date +%m%d%y_%s`
fi

cp ${oracleSelinux} /etc/selinux/config

# directories
for in in $(echo ${oracleDirectory})
do
 chown ${oracleUser}:${oracleGroup} $i
 chmod 775 $i
done 


