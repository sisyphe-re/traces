#!/usr/bin/python3
# pdr.py: get pdr from log

import os
import sys
import matplotlib.pyplot as plt
plt.rcdefaults()

# Test arguments
if len(sys.argv) != 2:
    print("Usage: "+sys.argv[0]+" <out.txt>")
    sys.exit(2)
log_id = sys.argv[1]
# Open log
try:
   log_file = open(log_id, "r" )
   log = log_file.readlines()
except IOError:
    print(sys.argv[0]+": "+log_id+": cannot open file")
    sys.exit(3)
# Get list of nodes
nodes_list = []
for line in log:
    node_id = line.split(';')[1]
    if "m3" in node_id and node_id not in nodes_list:
        nodes_list.append(node_id)
print(nodes_list)
# Get RX
nodes_rx = dict()
for node in nodes_list:
    nodes_rx[node] = 0
for line in log:
    for node in nodes_list:
        if node in line and "received" in line:
            nodes_rx[node] += 1
print(nodes_rx)
# Get TX
nodes_tx = dict()
for node in nodes_list:
    nodes_tx[node] = 0
for line in log:
    for node in nodes_list:
        if node in line and "Sending" in line:
            nodes_tx[node] += 1
print(nodes_tx)
# Compute PDR
nodes_pdr = dict()
for node in nodes_list:
    nodes_pdr[node] = (nodes_rx[node] / (sum(nodes_tx.values()) - nodes_tx[node]))*100
print(nodes_pdr)
# Plot PDR
fig = plt.figure()
plt.bar(nodes_pdr.keys(), nodes_pdr.values())
plt.xlabel("Node ID")
plt.ylabel("PDR (%)")
plt.title("Packet Delivery Ratio (PDR) per node")
plt.show()
