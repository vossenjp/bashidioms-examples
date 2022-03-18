#!/usr/bin/env bash
# list.sh: A wrapper script for ls-related tools & simple `case..esac` demo
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch03/list.sh
#_________________________________________________________________________
VERSION='v1.2b'

function Usage_Exit {
    echo "$0 [color|last|len|long]"
    exit
}

# Show each filename preceded by the length of its name, sorted by filename
# length.  Note '-' is valid but uncommon in function names, but it is not
# valid in variable names.  We don't usually use it, but you can.
function Ls-Length {
    ls -1 "$@" | while read fn; do
        printf '%3d %s\n' ${#fn} ${fn}
    done | sort -n
}

(( $# < 1 )) && Usage_Exit                                             # <1>
sub=$1
shift

case $sub in
    color)                                # Colorized ls
        ls -N --color=tty -T 0 "$@"
    ;;

    last | latest)                        # Latest files               # <2>
        ls -lrt | tail "-n${1:-5}"                                     # <3>
    ;;

    len*)                                 # Files with name lengths    # <4>
        Ls-Length "$@"
    ;;

    long)                                 # File with longest name
        Ls-Length "$@" | tail -1
    ;;

    *)                                    # Default
        echo "unknown command: $sub"
        Usage_Exit
    ;;
esac
