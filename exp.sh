#!/bin/bash
# exp.sh: launch experiment on IoT-lab, log & retrieve results from server

set -e
# Test arguments
if [ "$#" -ne 4 ]; then
	echo "Usage: $0 <interval (s)> <payload size (B)> <exp duration (m)> <list of nodes>"
	exit
fi
# Define variables
IOTLAB="foubert@grenoble.iot-lab.info"
CODEDIR="/home/foubert/repos/iot-lab/parts/contiki/examples/ipv6/simple-udp-rpl"
EXPDIR="/home/foubert/dev/traces"
# Catch SIGINT
trap ctrl_c INT
function ctrl_c() {
	echo "Terminating experiment."
	iotlab-experiment stop -i "$EXPID"
	exit 1
}
# Configure firmware
sed -i "s/#define\ SEND_INTERVAL_SECONDS\ .*/#define\ SEND_INTERVAL_SECONDS\ $1/g" $CODEDIR/broadcast-example.c
sed -i "s/#define\ SEND_BUFFER_SIZE\ .*/#define\ SEND_BUFFER_SIZE\ $2/g" $CODEDIR/broadcast-example.c
# Compile firmware
cd $CODEDIR
make TARGET=iotlab-m3 -j8 || { echo "Compilation failed."; exit 1; }
# Submit experiment
cd $EXPDIR
EXPID=$(iotlab-experiment submit -n traces -d $3 -l $4 | grep id | cut -d' ' -f6)
iotlab-experiment wait
# Start aggregator on server
ssh -t "$IOTLAB" tmux new-session -d -s aggregate
ssh -t "$IOTLAB" tmux send-keys -t aggregate 'serial_aggregator' Space '-l' Space $4 Space '\>' Space "out.txt" Space '2\>\&1' Space '\&\&' Space 'exit' C-m
# Flash nodes
iotlab-node -up $CODEDIR/broadcast-example.iotlab-m3 -l $4
# Wait for experiment termination
iotlab-experiment wait --state Terminated
# Retrieve log from server
mkdir $EXPDIR/log/$EXPID
scp "$IOTLAB":~/out.txt $EXPDIR/log/$EXPID/out.txt

exit 0
