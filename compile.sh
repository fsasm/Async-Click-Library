#!/bin/env sh

# print every command before executing it
set -x

# default value for argument
TOP="${1:-gcd_tb}"

# compile everything
cat sources.list | xargs -L1 ghdl -a

# elaborate
ghdl -e $TOP 

# execute
ghdl -r $TOP --vcd=wave.vcd
