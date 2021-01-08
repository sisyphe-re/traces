#!/usr/bin/python3
# pdr.py: get pdr from log

import os
import sys

# Test arguments
if len(sys.argv) != 2:
    print("Usage: "+sys.argv[0]+" <out.txt>")
    sys.exit(2)
log_id = sys.argv[1]

try:
   log_file = open(log_id, "r" )
except IOError:
    print(sys.argv[0]+": "+log_id+": cannot open file")
    sys.exit(3)
