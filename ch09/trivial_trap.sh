#!/usr/bin/env bash
# trivial_trap.sh: Trivial bash trap example
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch09/trivial_trap.sh
#_________________________________________________________________________
# Does not work on zsh 5.4.2!

function Cleanup {
    echo "$FUNCNAME was triggered!  Cleaning up..."
}

echo "Starting script $0..."

echo 'Setting the trap...'
trap Cleanup ABRT EXIT HUP INT QUIT TERM

echo 'About to exit...'
