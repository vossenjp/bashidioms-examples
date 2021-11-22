#!/bin/bash -
# Or possibly: #!/usr/bin/env bash
# <Name>: <description>
# Original Author & date:
# Current maintainer?
# Copyright/License?
# Where this code belongs?  (Hosts, paths, etc.)
# Project/repo?
# Caveats/gotchas?
# Usage?  (Better to have `-h` and/or `--help` options!)
# $URL$  # If using SVN
ID=''    # If using SVN
#_________________________________________________________________________
PROGRAM=${0##*/}  # bash version of `basename`

# GLOBAL and constant variables are in UPPER case
LOG_DIR='/path/to/log/dir'

# Functions are in Mixed Case
###########################################################################
# Define functions

#--------------------------------------------------------------------------
# Example function
# Globals: none
# Input:   nothing
# Output:  nothing
function foo {
    local var1="$1"
    ...
} # end of function foo


#--------------------------------------------------------------------------
# Another example function
# Globals: none
# Input:   nothing
# Output:  nothing
function bar {
    local var1="$1"
    ...
} # end of function bar


###########################################################################
# Main
...
