# How to generate application traces with FIT IoT-LAB 

This project contain :
* A script to launch an experiment on the FIT IoT-LAB testbed and store the results on your computer
* A code base to parse and analyse the obtained data
* Applications traces obtained with this method

## Experimentation script

*Redaction in progress*

### Prerequisite steps

*You must have FIT IoT lab credentials, you can register [here](https://www.iot-lab.info/testbed/signup).*

Store your credentials on your computer :
```
$ iotlab-auth -u <login>
```

Modify the variables in the script according to your environment :
* LOGIN: you FIT IoT-LAB login
* SITE: the site where you want to experiment, here you can find a description of each site : [grenoble](https://www.iot-lab.info/docs/deployment/grenoble/), [lille](https://www.iot-lab.info/docs/deployment/lille/), [lyon](https://www.iot-lab.info/docs/deployment/grenoble/), [saclay](https://www.iot-lab.info/docs/deployment/saclay/), [strasbourg](https://www.iot-lab.info/docs/deployment/saclay/)
* CODEDIR: the location of your firmware (in absolute path, no relative path)
* EXPDIR: the absolute path of this directory, used to store log and retrieve scripts 

### Usage 

```
$ ./exp.sh <exp name> <interval (s)> <payload size (b)> <exp duration (m)> <nb packets> <list of nodes>"
```

Parameters :
* exp name: the name of the experience, used to store the results
* interval (s): at which interval nodes will send "nb packets" packet (ex: three packets every 3 seconds)
* payload size (b): the payload size in bytes
* exp duration (m): the experiment duration in minutes
* nb packets: the number of packets send each time, useful when you want to send more than one packet per seconds
* list of nodes: the list of nodes for the experiment, you can find useful examples [here](https://www.iot-lab.info/docs/tools/cli/#experiment-command), **be aware that the site in your node list and in the script must be the same**

Example : 

```
$ ./exp.sh "MyExp" 6 12 1 1 "3,archi=m3:at86rf231+site=lille"
```
will launch an experience named "MyExp", during 1 minute, where nodes send 1 packet of 12 bytes every 6 seconds, on three [M3 nodes](https://www.iot-lab.info/docs/boards/iot-lab-m3/) at Lille.

## Python sources

*Redaction in progress*

### Dependencies
* Python: 3.6.9
* pip: 9.0.1 
* matplotlib: 3.3.3

### Usage 

*Redaction in progress*

## Applications Traces 

*Redaction in progress*
