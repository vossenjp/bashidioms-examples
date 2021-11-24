#!/usr/bin/env bash
# lists.sh: bash list example code
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch07/lists.sh
#_________________________________________________________________________
# Does not work on zsh 5.4.2!

# Declare a list                                                         <1>
# declare -a mylist   # Can do this, or `local -a` or `readonly -a` or:
mylist[0]='foo'       # This both declares and assigns to mylist[0]

# Push or assign, note the +=                                            <2>
###mylist=(bar)               # Would overwrite mylist[0]
mylist+=(bar)              # mylist[1]
mylist+=(baz)              # mylist[2]
mylist+=(one two)          # mylist[3] AND mylist[4]
mylist+=("three four")     # mylist[5]

# OR
# mylist=(bar baz one two "three four")  # Note "foo" is already there

# Display or dump the values                                             <3>
echo -e "\nThe element count is: ${#mylist[@]} or ${#mylist[*]}"

echo -e "\nThe length of element [5] is: ${#mylist[5]}"

echo -e "\nDump or list:"
declare -p mylist
echo -n      "\${mylist[@]}   = " ; printf "%q|"  ${mylist[@]}
echo -en   "\n\${mylist[*]}   = " ; printf "%q|"  ${mylist[*]}
echo -en "\n\"\${mylist[@]}\" = " ; printf "%q|" "${mylist[@]}"
echo -en "\n\"\${mylist[*]}\" = " ; printf "%q|" "${mylist[*]}"
echo -e "\t# But this is broken!"  # Previous line is bad and no newline
# See `help printf` or chapter 6, we need this to show the correct words:
# %q	quote the argument in a way that can be reused as shell input

# Iterate over the values                                                <4>
echo -e "\nforeach \"\${!mylist[@]}\":"
for element in "${!mylist[@]}"; do
    echo -e "\tElement: $element; value: ${mylist[$element]}"
done

echo -e "\nBut don't do this: \${mylist[*]}"
for element in ${mylist[*]}; do
    echo -e "\tElement: $element; value: ${mylist[$element]}"
done

# Handle slices (sub-sets) of the list, shift and pop                    <5>
echo -e "\nStart from element 3 and show a slice of 2 elements:"
printf "%q|" "${mylist[@]:3:2}"
echo '' # No newline in above

echo -e "\nShift FIRST element [0] (dumped before and after):"
declare -p mylist                    # Display before
mylist=("${mylist[@]:1}")            # First element, needs quotes
#mylist=("${mylist[@]:$count}")      # First #count elements
declare -p mylist                    # Display after

echo -e "\nPop LAST element (dumped before and after):"
declare -p mylist
unset -v 'mylist[-1]'                # Bash v4.3+
#unset -v "mylist[${#mylist[*]}-1]"  # Older
declare -p mylist

# Delete slices or the entire list                                       <6>
echo -e "\nDelete element 2 using unset (dumped before and after):"
declare -p mylist
unset -v 'mylist[2]'
declare -p mylist

# Delete the entire list
unset -v mylist
