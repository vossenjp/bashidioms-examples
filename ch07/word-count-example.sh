#!/usr/bin/env bash
# word-count-example.sh: More examples for bash lists and hashes, and $RANDOM
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch07/word-count-example.sh
#_________________________________________________________________________
# Does not work on Zsh 5.4.2!
# See also: `man uniq`

WORD_FILE='/tmp/words.txt'
> $WORD_FILE                                                           # <1>
trap "rm -f $WORD_FILE" ABRT EXIT HUP INT QUIT TERM

declare -A myhash                                                      # <2>

echo "Creating & reading random word list in: $WORD_FILE"

# Create a list of words to use for the hash example
mylist=(foo bar baz one two three four)

# Loop, and randomly pick elements out of the list
range="${#mylist[@]}"                                                  # <3>
for ((i=0; i<35; i++)); do
    random_element="$(( $RANDOM % $range ))"                           # <4>
    echo "${mylist[$random_element]}" >> $WORD_FILE                    # <5>
done

# Read the word list into a hash
while read line; do                                                    # <6>
    (( myhash[$line]++ ))                                              # <7>
done < $WORD_FILE                                                      # <8>


echo -e "\nUnique words from: $WORD_FILE"                              # <9>
for key in "${!myhash[@]}"; do
    echo "$key"
done | sort

echo -e "\nWord counts, ordered by word, from: $WORD_FILE"             # <10>
for key in "${!myhash[@]}"; do
    printf "%s\t%d\n" $key ${myhash[$key]}
done | sort

echo -e "\nWord counts, ordered by count, from: $WORD_FILE"            # <11>
for key in "${!myhash[@]}"; do
    printf "%s\t%d\n" $key ${myhash[$key]}
done | sort -k2,2n
