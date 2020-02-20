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
# NAME: install
#
# DESCRIPTION: oracle database software installation task(s)
#
# The following steps are perfomed as oracle OS user
#
# SUMMARY OF STEPS:
# - check syntax
# - apply configuration file
# - apply environment variables
# - create oracle specific directories
# - install database software

# syntax check
if [ $# -gt 0 ]
then
 echo -e "\nUsage: $0\n"
 exit 1;
fi;

# source variables
if [ -f "configuration.sh" ]
then
  . configuration.sh
else
  echo -e "\nError: Invalid/missing environment config file 'configuration.sh'\n"
  exit 1;
fi

# environment variables
if [ -f "/home/oracle/.bash_profile" ]
then
 cp /home/oracle/.bash_profile /home/oracle/.bash_profile.`date +%m%d%y_%s`
else
 touch /home/oracle/.bash_profile
fi

echo -e "\n#ORACLE ENVIRONMENT VARIABLES"
cat ${oracleVariables} >> /home/oracle/.bash_profile

source ~/.bash_profile

# directory
if [ ! -d "$ORACLE_HOME" ]
then
 mkdir $ORACLE_HOME
fi

# install
unzip ${oracleSoftware} -d $ORACLE_HOME

$ORACLE_HOME/runInstaller -silent  -ignorePrereqFailure -responseFile ${oracleInstallResponse}

su -c '$ORACLE_HOME/root.sh'
