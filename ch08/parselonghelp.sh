#!/usr/bin/env bash
# parselonghelp.sh: Use getopts to parse these arguments, including long & help
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch08/parselonghelp.sh
#_________________________________________________________________________
# Long arguments: --amode and --help
#             and --outfile filename or --outfile=filename

PROGRAM=${0##*/}  # bash version of `basename`
VERSION="$PROGRAM v1.2.3"

VERBOSE=':'  # Default is off (no-op)
DEBUG=':'    # Default is off (no-op)

function Display_Help {
    # Tab indents below, starting after the EoN (End-of-Note) line!
    cat <<-EoN
	This script does nothing but show help, a real script should be more exciting.
	    usage: $PROGRAM (options)

	Options:
	    -a | --amode    = Enable "amode", default is off
	    -d | --debug    = Include debug output, default is off
	    -h | --help     = Show this help message and exit
	    -o | --outfile  = Send output to file instead of STDOUT
	    -v | --verbose  = Include verbose output, default is off
	    -V | --version  = Show the version and exit

	You can put more detail here if you need to.
	EoN
    # Tab indents above!
    # If we have this next line the script will always exit after calling
    # Display_Help.  You may or may not want that...you decide.
    # exit 1  # If you use this, remove the other exits after the call!
} # end of function Display_Help

while getopts ':-:adho:vV' VAL ; do
    case $VAL in
        # If you keep options in lexical order they are easier to find and
        # you reduce the chances of a collision
        a ) AMODE=1 ;;
        d ) DEBUG='echo' ;;
        h ) Display_Help && exit 1 ;;       # We violated our style here
        o ) OFILE="$OPTARG" ;;
        v ) VERBOSE='echo'  ;;
        V ) echo "$VERSION" && exit 0 ;;    # We violated our style here too
#--------------------------------------------------------
        -) # this section added to support long arguments
             case $OPTARG in
                amode     ) AMODE=1 ;;
                debug     ) DEBUG='echo' ;;
                help      )
                    Display_Help
                    exit 1
                ;;
                outfile=* ) OFILE="${OPTARG#*=}" ;;
                outfile   )
                            OFILE="${!OPTIND}"
                            let OPTIND++
                ;;
                verbose   ) VERBOSE='echo' ;;
                version   )
                    echo "$VERSION"
                    exit 0
                ;;
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

echo "Code for $0 goes here."

$VERBOSE 'Example verbose message...'
$DEBUG 'Example DEBUG message...'

echo "End of $PROGRAM run."
