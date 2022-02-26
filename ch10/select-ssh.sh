#!/usr/bin/env bash
# select-ssh.sh: Create a menu from ~/.ssh/config to set ssh_target,
# then SSH to it
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch10/select-ssh.sh
#_________________________________________________________________________

#ssh_config="$HOME/.ssh/config"  # Real one
# Replace the trailing 'select-ssh.sh' with 'ssh_config'
ssh_config="${0%/*}/ssh_config"  # Idioms test file

PS3='SSH to> '
select ssh_target in Exit \
  $(egrep -i '^Host \w+' "$ssh_config" | cut -d' ' -f2-); do
    case $REPLY in
        1|q|x|quit|exit) exit 0
        ;;
        *) break
        ;;
    esac
done

# This is only an example, so echo what we would have done
echo ssh $ssh_target
