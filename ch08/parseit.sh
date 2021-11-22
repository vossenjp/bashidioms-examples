#!/usr/bin/env bash
# parseit.sh: Use getopts to parse these arguments
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch08/parseit.sh
#_________________________________________________________________________

while getopts ':ao:v' VAL ; do                                         # <1>
    case $VAL in                                                       # <2>
        a ) AMODE=1 ;;
        o ) OFILE="$OPTARG" ;;
        v ) VERBOSE=1 ;;
        : ) echo "error: no arg supplied to $OPTARG option" ;;         # <3>
        * )                                                            # <4>
            echo "error: unknown option $OPTARG"
            echo "  valid options are: aov"
        ;;
    esac
done
shift $((OPTIND -1))                                                   # <5>
