#!/usr/bin/env bash
# list.sh: A wrapper script for ls-related tools & simple `case..esac` demo
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch03/list.sh
#_________________________________________________________________________
VERSION='v1.2b'

function usagexit {
    echo "$0 [color|last|len|long]"
    exit
}

# Show each filename preceded by the length of its name, sorted by
# filename length
function lslen {
    ls -1 "$@" \
    | while read fn; do
        printf '%3d %s\n' ${#fn} ${fn}
    done | sort -n
}

(( $# < 1 )) && usagexit                                               # <1>
sub=$1
shift

case $sub in
    color)                                # Colorized ls
        ls -N --color=tty -T 0 "$@"
    ;;

    last | latest)    # latest files                                   # <2>
        ls -lrt | tail "-${1:-5}"
    ;;

    len*)                                 # Files with name lengths    # <3>
        lslen "$@"
    ;;

    long)                                 # File with longest name
        lslen "$@" | tail -1
    ;;

    *) # Default
        echo "unknown command: $sub"
        usagexit
    ;;
esac
