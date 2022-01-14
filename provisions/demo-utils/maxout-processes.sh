#!/bin/bash

# This script fills up RAM and forces machine to crash eventually
# It is used to show that containers hold the RAM and CPU limitations added by lxc

for i in {1..3752}; do sleep infinity & done