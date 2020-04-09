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
# NAME: configuration
#
# DESCRIPTION: config settings for oracle-provisioning utility

# script home
scriptRoot=$(pwd)

# Database
oracleDBTemplate=${scriptRoot}/oracle/databaseTemplate.dbc

# Directories
oracleDirectory='/ora/data1 /ora/data2 /ora/export'

# Environment Variables
oracleVariables=${scriptRoot}/oracle/bash_profile

# Kernel Parameters
oracleLimits=${scriptRoot}/root/limits.conf
oracleSelinux=${scriptRoot}/root/selinux.conf
oracleSysctl=${scriptRoot}/root/sysctl.conf

# Packages
oraclePackage=${scriptRoot}/root/packages.lst

# Software
oracleSoftware='/ora/export/LINUX.X64_180000_db_home.zip'
oracleInstallResponse=${scriptRoot}/oracle/databaseInstall.rsp
oracleListener=${scriptRoot}/oracle/listener.ora
oracleSqlnet=${scriptRoot}/oracle/sqlnet.ora
oracleTnsnames=${scriptRoot}/oracle/tnsnames.ora

# User and Groups
oracleGroup='dba'
oracleUser='oracle'
