#!/usr/bin/env bash
# hashes.sh: bash Hash example code
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch07/hashes.sh
#_________________________________________________________________________

# Declare a hash                                                         <1>
declare -A myhash   # MUST do this, or `local -A` or `readonly -A`

# Assign to it, note no "+"                                              <2>
###myhash=(bar)               # Would create or overwrite myhash[0]
myhash[a]='foo'
myhash[b]='bar'
myhash[c]='baz'
myhash[d]='one two'        # Different than our list example
myhash[e]='three four'

# OR
#myhash=( [a]=foo [b]=bar [c]=baz [d]="one two" [e]="three four")

# Display or dump the details and values                                 <3>
echo -e "\nThe key count is: ${#myhash[@]} or ${#myhash[*]}"

echo -e "\nThe length of the value of key [e] is: ${#myhash[e]}"

echo -e "\nDump or list:"
declare -p myhash
echo -n      "\${myhash[@]}   = " ; printf "%q|"  ${myhash[@]}
echo -en   "\n\${myhash[*]}   = " ; printf "%q|"  ${myhash[*]}
echo -en "\n\"\${myhash[@]}\" = " ; printf "%q|" "${myhash[@]}"
echo -en "\n\"\${myhash[*]}\" = " ; printf "%q|" "${myhash[*]}"
echo '' # No newline in above
# See `help printf` or chapter 6, we need this to show the correct words:
# %q	quote the argument in a way that can be reused as shell input

# Iterate over the keys and values                                       <4>
echo -e "\nforeach \"\${!myhash[@]}\":"
for key in "${!myhash[@]}"; do
    echo -e "\tKey: $key; value: ${myhash[$key]}"
done

echo -e "\nBut don't do this: \${myhash[*]}"
for key in ${myhash[*]}; do
    echo -e "\tKey: $key; value: ${myhash[$key]}"
done

# Handle slices (sub-sets) of the hash                                   <5>
echo -e "\nStart from element 3 and show a slice of 2 elements:"
printf "%q|" "${myhash[@]:3:2}"
echo '' # No newline in above

#echo -e "\nShift FIRST key [0]:" = makes no sense in a hash!
#echo -e "\nPop LAST key:"        = makes no sense in a hash!

# Delete keys or the entire hash                                         <6>
echo -e "\nDelete key c using unset (dumped before and after):"
declare -p myhash
unset -v 'myhash[c]'
declare -p myhash

# Delete the entire hash
unset -v myhash
