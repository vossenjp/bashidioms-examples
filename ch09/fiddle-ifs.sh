#!/usr/bin/env bash
# fiddle-ifs.sh: Fiddling with $IFS for fun and profit, to read files
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch09/fiddle-ifs.sh
#_________________________________________________________________________

# Create test file (not spelling out "word" to keep output < 80 columns)
IFS_TEST_FILE='/tmp/ifs-test.txt'
cat <<'EoF' > $IFS_TEST_FILE
line1 wd1 wd2 wd3
line2 wd1 wd2 wd3
line3 wd1 wd2 wd3
EoF


#--------------------------------------------------------------------------
echo 'Normal $IFS and `read` operation; split into words:'
printf '$IFS before: %q\n' "$IFS"
while read line w1 w2 w3; do
    printf 'IFS during: %q\tline = %q, w1 = %q, w2 = %q, w3 = %q\n' \
      "$IFS" "$line" "$w1" "$w2" "$w3"
done < $IFS_TEST_FILE
printf 'IFS after:  %q\n' "$IFS"


#--------------------------------------------------------------------------
echo ''
echo 'Temporary $IFS change for `read` inline:'
echo 'Words are NOT split, yet $IFS appears unchanged, because only the read'
echo 'line has the changed $IFS.  We also shortened "line" to "ln" to make'
echo 'it fit a book page.'
printf 'IFS before: %q\n' "$IFS"
while IFS='' read line w1 w2 w3; do
    printf 'IFS during: %q\tln = %q, w1 = %q, w2 = %q, w3 = %q\n' \
      "$IFS" "$line" "$w1" "$w2" "$w3"
done < $IFS_TEST_FILE
printf 'IFS after:  %q\n' "$IFS"


#--------------------------------------------------------------------------
function Read_A_File {
    local file="$1"
    local IFS=''

    while read line w1 w2 w3; do
    printf 'IFS during: %q\tline = %q, w1 = %q, w2 = %q, w3 = %q\n' \
      "$IFS" "$line" "$w1" "$w2" "$w3"
    done < "$file"
}

echo ''
echo 'Temporary $IFS change for `read` in a function; NOT split, $IFS changed:'
printf 'IFS before: %q\n' "$IFS"
Read_A_File $IFS_TEST_FILE
printf 'IFS after:  %q\n' "$IFS"


#--------------------------------------------------------------------------
echo ''
echo 'But you may not need to change $IFS at all...  See `help read` and'
echo 'note the parts about:'
echo '    ...leftover words assigned to the last NAME'
echo '    ...[read line until] DELIM is read, rather than newline'
echo 'Normal $IFS and `read` operation using only 1 variable:'
printf 'IFS before: %q\n' "$IFS"
while read line; do
    printf 'IFS during: %q\tline = %q\n' "$IFS" "$line"
done < $IFS_TEST_FILE
printf 'IFS after:  %q\n' "$IFS"
