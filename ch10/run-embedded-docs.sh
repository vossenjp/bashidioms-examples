#!/usr/bin/env bash
# run-embedded-docs.sh: Wrapper for automatic BI example code output updater
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch10/run-embedded-docs.sh
#_________________________________________________________________________

OUTPUT_INCLUDE_FILE='examples/ch10/embedded-docs.out'

# We *could* send all STDOUT from this script to the output file like this:
#exec > $OUTPUT_INCLUDE_FILE
# We do not do that here because our "example code output updater" already
# does itself, the way we want it to.

echo '### Running looks like this (`./embedded-docs.sh`): <1>'
examples/ch10/embedded-docs.sh

echo -e "\n"
echo '### Emitting (un-rendered) docs looks like this (`./embedded-docs.sh --emit-docs`): <6>'
examples/ch10/embedded-docs.sh --emit-docs
