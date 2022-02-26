#!/usr/bin/env bash
# lists.sh: bash list example code
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch07/lists.sh
#_________________________________________________________________________
# Does not work on Zsh 5.4.2!

# Books are not as wide as some screens!
FORMAT='fmt --width 70 --split-only'

# Declare a list                                                         <1>
# declare -a mylist   # Can do this, or `local -a` or `readonly -a` or:
mylist[0]='foo'       # This both declares and assigns to mylist[0]

# OR Both declares & assigns:
#mylist=(foo bar baz three four "five by five" six)

# Push or assign, note the +=                                            <2>
###mylist=(bar)               # Would overwrite mylist[0]
mylist+=(bar)              # mylist[1]
mylist+=(baz)              # mylist[2]
mylist+=(three four)       # mylist[3] AND mylist[4]
mylist+=("five by five")   # mylist[5] Note spaces
mylist+=("six")            # mylist[6]

# OR APPEND, note the "+" and we're assuming foo was already assigned
#mylist+=(bar baz three four "five by five" six)

# Display or dump the values                                             <3>
echo -e "\nThe element count is: ${#mylist[@]} or ${#mylist[*]}"

echo -e "\nThe length of element [4] is: ${#mylist[4]}"

echo -e "\nDump or list:"
declare -p mylist | $FORMAT
echo -n      "\${mylist[@]}   = " ; printf "%q|"  ${mylist[@]}
echo -en   "\n\${mylist[*]}   = " ; printf "%q|"  ${mylist[*]}
echo -en "\n\"\${mylist[@]}\" = " ; printf "%q|" "${mylist[@]}"
echo -en "\n\"\${mylist[*]}\" = " ; printf "%q|" "${mylist[*]}"
echo -e "   # But this is broken!"  # Previous line is bad and no newline
# See `help printf` or chapter 6 "printf for reuse or debugging", we need
# this to show the correct words:
# %q	quote the argument in a way that can be reused as shell input

# "Join" the values                                                      <4>
function Join { local IFS="$1"; shift; echo "$*"; } # One character delimiter!
echo -en "\nJoin \${mylist[@]} = " ; Join ',' "${mylist[@]}"
function String_Join {
    local delimiter="$1"
    local first_element="$2"
    shift 2
    printf '%s' "$first_element" "${@/#/$delimiter}"
    # Print first element, then reuse the '%s' format to display the rest of
    # the elements (from the function args $@), but add a prefix of $delimiter
    # by "replacing" the leading empty pattern (/#) with $delimiter.
}
echo -n 'String_Join ${mylist[@]} = ' ; String_Join '<>' "${mylist[@]}"

# Iterate over the values                                                <5>
echo -e "\nforeach \"\${!mylist[@]}\":"
for element in "${!mylist[@]}"; do
    echo -e "\tElement: $element; value: ${mylist[$element]}"
done

echo -e "\nBut don't do this: \${mylist[*]}"
for element in ${mylist[*]}; do
    echo -e "\tElement: $element; value: ${mylist[$element]}"
done

# Handle slices (subsets) of the list, shift and pop                    <6>
echo -e "\nStart from element 5 and show a slice of 2 elements:"
printf "%q|" "${mylist[@]:5:2}"
echo '' # No newline in above

echo -e "\nShift FIRST element [0] (dumped before and after):"
declare -p mylist | $FORMAT          # Display before
mylist=("${mylist[@]:1}")            # First element, needs quotes
#mylist=("${mylist[@]:$count}")      # First #count elements
declare -p mylist  | $FORMAT         # Display after

echo -e "\nPop LAST element (dumped before and after):"
declare -p mylist | $FORMAT
unset -v 'mylist[-1]'                # bash v4.3+
#unset -v "mylist[${#mylist[*]}-1]"  # Older
declare -p mylist

# Delete slices or the entire list                                       <7>
echo -e "\nDelete element 2 using unset (dumped before and after):"
declare -p mylist
unset -v 'mylist[2]'
declare -p mylist

# Delete the entire list                                                 <8>
unset -v mylist
