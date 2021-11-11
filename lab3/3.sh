#!/bin/bash

crontab -l | {
	cat;
	echo "5 * * * 4 bash /root/lab3/1.sh";
} | crontab -
