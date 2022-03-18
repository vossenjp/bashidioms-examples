#!/usr/bin/env bash
# parameter-expansion.sh: parameter expansion for parsing, and a big list
# Original Author & date: _bash Idioms_ 2022
# bash Idioms filename: examples/ch04/parameter-expansion.sh
#_________________________________________________________________________
# Does not work on Zsh 5.4.2!

customer_subnet_name='Acme Inc subnet 10.11.12.13/24'

echo ''
echo "Say we have this string: $customer_subnet_name"

customer_name=${customer_subnet_name%subnet*}  # Trim from 'subnet' to end
subnet=${customer_subnet_name##* }             # Remove leading 'space*'
ipa=${subnet%/*}                               # Remove trailing '/*'
cidr=${subnet#*/}                              # Remove up to '/*'
fw_object_name=${customer_subnet_name// /_}    # Replace space with '_-
fw_object_name=${fw_object_name////-}          # Replace '/' with '-'
fw_object_name=${fw_object_name,,}             # Lowercase

echo ''
echo 'When the code runs we get:'
echo ''
echo "Customer name: $customer_name"
echo "Subnet:        $subnet"
echo "IPA            $ipa"
echo "CIDR mask:     $cidr"
echo "FW Object:     $fw_object_name"

# bash Shell Parameter Expansion: https://oreil.ly/Af8lw

# ${var#pattern}                Remove shortest (nongreedy) leading pattern
# ${var##pattern}               Remove longest (greedy) leading pattern
# ${var%pattern}                Remove shortest (nongreedy) trailing pattern
# ${var%%pattern}               Remove longest (greedy) trailing pattern

# ${var/pattern/replacement}    Replace first +pattern+ with +replacement+
# ${var//pattern/replacement}   Replace all +pattern+ with +replacement+

# ${var^pattern}                Uppercase first matching optional pattern
# ${var^^pattern}               Uppercase all matching optional pattern
# ${var,pattern}                Lowercase first matching optional pattern
# ${var,,pattern}               Lowercase all matching optional pattern

# ${var:offset}                 Substring starting at +offset+
# ${var:offset:length}          Substring starting at +offset+ for +length+

# ${var:-default}               Var if set, otherwise +default+
# ${var:-default}               Assign +default+ to +var+ if +var+ not already set
# ${var:?error_message}         Barf with +error_message+ if +var+ not set
# ${var:+replaced}              Expand to +replaced+ if +var+ _is_ set

# ${#var}                       Length of var
# ${!var[*]}                    Expand to indexes or keys
# ${!var[@]}                    Expand to indexes or keys, quoted

# ${!prefix*}                   Expand to variable names starting with +prefix+
# ${!prefix@}                   Expand to variable names starting with +prefix+, quoted

# ${var@Q}                      Quoted
# ${var@E}                      Expanded (better than `eval`!)
# ${var@P}                      Expanded as prompt
# ${var@A}                      Assign or declare
# ${var@a}                      Return attributes
