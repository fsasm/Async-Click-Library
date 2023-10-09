#!/bin/env sh

# print every command before executing it
set -x

# default value for argument
TOP="${1:-gcd_tb}"
STD="08"

# compile everything
cat sources.list | xargs -L1 ghdl -a --std=$STD

# elaborate
ghdl -e --std=$STD $TOP 

# execute
ghdl -r --std=$STD $TOP --vcd=wave.vcd
