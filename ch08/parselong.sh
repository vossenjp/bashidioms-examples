#!/usr/bin/env bash
# parselong.sh: Use getopts to parse these arguments, including long ones
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch08/parselong.sh
#_________________________________________________________________________
# Long arguments: --amode
#             and --outfile filename or --outfile=filename

VERBOSE=':'  # Default is off (no-op)

while getopts ':-:ao:v' VAL ; do                                       # <1>
    case $VAL in
        a ) AMODE=1 ;;
        o ) OFILE="$OPTARG" ;;
        v ) VERBOSE='echo'  ;;
#--------------------------------------------------------
        - ) # This section added to support long arguments             # <2>
             case $OPTARG in
                amode     ) AMODE=1 ;;
                outfile=* ) OFILE="${OPTARG#*=}" ;;                    # <3>
                outfile   )                                            # <4>
                            OFILE="${!OPTIND}"                         # <5>
                            let OPTIND++                               # <6>
                ;;
                verbose   ) VERBOSE='echo' ;;
                * )
                    echo "unknown long argument: $OPTARG"
                    exit
                ;;
            esac
        ;;
#--------------------------------------------------------
        : ) echo "error: no argument supplied" ;;
        * )
            echo "error: unknown option $OPTARG"
            echo "    valid options are: aov"
        ;;
    esac
done
shift $((OPTIND -1))
