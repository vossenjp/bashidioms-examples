#!/usr/bin/env bash
# fancy_mapfile.sh: Fancy `mapfile` example
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch09/fancy_mapfile.sh
#_________________________________________________________________________
# Does not work on Zsh 5.4.2!

HOSTS_FILE='/tmp/nodes.txt'

# Create test file                                                    # <1>
> $HOSTS_FILE
for n in node{0..9}; do echo "$n" >> $HOSTS_FILE; done

### ADJUSTABLE VARIABLES
#BATCH_SIZE=0  # Do the entire file at once (default); watch out for memory
BATCH_SIZE=4
SLEEP_SECS_PER_NODE=1     # Can set to 0
SLEEP_SECS_PER_BATCH=1    # Set to zero if `BATCH_SIZE=0`!

# Display runtime feedback to STDERR (so STDOUT can go into `tee` or a file)
node_count="$(wc -l < $HOSTS_FILE)"                                   # <2>
batch_count="$(( node_count / BATCH_SIZE ))"                          # <3>
echo '' 1>&2
echo "Nodes to process:        $node_count" 1>&2
echo "Batch size and count:    $BATCH_SIZE / $batch_count" 1>&2       # <4>
echo "Sleep seconds per node:  $SLEEP_SECS_PER_NODE" 1>&2
echo "Sleep seconds per batch: $SLEEP_SECS_PER_BATCH" 1>&2
echo '' 1>&2

node_counter=0
batch_counter=0
# While we're reading data...    && there is still data in $HOSTS_FILE
while mapfile -t -n $BATCH_SIZE nodes && ((${#nodes[@]})); do
    for node in ${nodes[@]}; do                                       # <5>
        echo "node $(( node_counter++ )): $node"
        sleep $SLEEP_SECS_PER_NODE
    done
    (( batch_counter++ ))
    # Don't get stuck here AFTER the last (partial) batch...
    [ "$node_counter" -lt "$node_count" ] && {
        # You can also use `mapfile -C Call_Back -c $BATCH_SIZE` for feedback but
        # it runs the callback up front too, so if you have a delay you'll
        # have to wait for that
        echo "Completed $node_counter of $node_count nodes;" \
             "batch $batch_counter of $batch_count;" \
             "sleeping for $SLEEP_SECS_PER_BATCH seconds..." 1>&2
        sleep $SLEEP_SECS_PER_BATCH
    }
done < $HOSTS_FILE
