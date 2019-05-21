#!/bin/bash

for i in $(docker ps --no-trunc | awk '{print $1}' | grep -v CONTAINER); do 
	LIMIT=`cat /sys/fs/cgroup/memory/docker/${i}/memory.limit_in_bytes`; 
	USAGE=`systemd-cgtop -b --iterations 1 | grep ${i} | awk '{print $4}'`; 
	echo Container ${i} is using $USAGE and its limited at $LIMIT; 
done;
