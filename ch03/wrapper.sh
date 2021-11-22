#!/usr/bin/env bash
# wrapper.sh: Simple "wrapper" script demo
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch03/wrapper.sh
#_________________________________________________________________________

# Trivial Sanity Checks                                                # <1>
[ -n "$BOOK_ASC" ] || {
    echo "FATAL: must export \$BOOK_ASC to the location of the book's Asciidoc files!"
    exit 1
}
\cd "$BOOK_ASC" || {
    echo "FATAL: can't cd to '$BOOK_ASC'!"
    exit 2
}

SELF="$0"                                                              # <2>

action="$1"                                                            # <3>
shift                                                                  # <4>
[ -x /usr/bin/xsel -a $# -lt 1 ] && {                                  # <5>
    # Read/write the clipboard on Linux
    text=$(xsel -b)
    function Output {
        echo -en "$*" | xsel -bi
    }
} || {
    # Read/write STDIN/STDOUT
    text=$*
    function Output {
        echo -en "$*"
    }
}

case "$action" in                                                      # <6>

    #######################################################################
    # Content/Markup                                                   # <7>

    ### Headers                                                        # <8>
    h1 )                 # Inside chapter heading 1 (really Asciidoc h3) <9>
        Output "[[$($SELF id $text)]]\n=== $text"                      # <10>
    ;;
    h2 )                 # Inside chapter heading 2 (really Asciidoc h4)
        Output "[[$($SELF id $text)]]\n==== $text"
    ;;
    h3 )                 # Inside chapter heading 3 (really Asciidoc h5)
        Output "[[$($SELF id $text)]]\n===== $text"
    ;;

    ### Lists
    bul|bullet )         # Bullet list (** = level 2, + = multi-line element)
        Output "* $text"
    ;;
    nul|number|order* )  # Numbered/ordered list (.. = level 2, + = multi-line element)
        Output ". $text"
    ;;
    term )               # Terms
        Output "term_here::\n  $text"
    ;;

    ### Inline
    bold )               # Inline bold (O'Reilly prefers italics to bold)
        Output "*$text*"
    ;;
    i|italic*|itl )      # Inline italics (O'Reilly prefers italics to bold)
        Output "_${text}_"
    ;;
    c|constant|cons )    # Inline constant width (command, code, keywords, more)
        Output "+$text+"
    ;;
    type|constantbold )  # Inline bold constant width (user types literally)
        Output "*+$text+*"
    ;;
    var|constantitalic ) # Inline italic constant width (user-supplied values)
        Output "_++$text++_"
    ;;
    sub|subscript )      # Inline subscript
        Output "~$text~"
    ;;
    sup|superscript )    # Inline superscript
        Output "^$text^"
    ;;
    foot )               # Create a footnote
        Output "footnote:[$text]"
    ;;
    url|link )           # Create a URL with alternate text
        Output "link:\$\$$text\$\$[]"   # URL[link shows as]
    ;;
    esc|escape )         # Escape a character (esp. *)
        Output "\$\$$text\$\$"   # $$*$$
    ;;


    #######################################################################
    # Tools                                                            # <7>

    id )                 ## Convert a hack/recipe name to an ID
        #us_text=${text// /_}  # Space to '_'
        #lc_text=${us_text,,}  # Lower case; Bash 4+ only!
        # Initial `tr -s '_' ' '` to preserve _ in case we process an ID twice (like from "xref")
        Output $(echo $text | tr -s '_' ' ' | tr '[:upper:]' '[:lower:]' | tr -d '[:punct:]' | tr -s ' ' '_')
    ;;

    index )              ## Creates 'index.txt' in AsciiDoc dir
        # Like:
            # ch02.asciidoc:== The Text Utils
            # ch02.asciidoc:=== Common Text Utils and similar tools
            # ch02.asciidoc:=== Finding data
        egrep '^=== ' ch*.asciidoc | egrep -v '^ch00.asciidoc' \
          > $BOOK_ASC/index.txt && {
            echo "Updated: $BOOK_ASC/index.txt"
            exit 0
        } || {
            echo "FAILED to update: $BOOK_ASC/index.txt"
            exit 1
        }
    ;;

    rerun )              ## Re-run example code to re-create (existing!) output files
        # Only re-run for code that ALREADY HAS a *.out file...not ALL *.sh code
        for output in examples/*/*.out; do
            code=${output/out/sh}
            echo "Re-running code for: $code > $output"
            $code > $output
        done
    ;;

    cleanup )            ## Clean up all the xHTML/XML/PDF cruft
        rm -fv {ch??,app?}.{pdf,xml,html} book.{xml,html} docbook-xsl.css
    ;;


    * )                                                                # <11>
        \cd -  # UGLY cheat to revert the 'cd' above...
        ( echo "Usage:"                                                # <12>
        egrep '\)[[:space:]]+# '   $0                                  # <13>
        echo ''
        egrep '\)[[:space:]]+## '  $0                                  # <14>
        echo ''
        egrep '\)[[:space:]]+### ' $0 ) | grep "${1:-.}" | more        # <15>
    ;;

esac
