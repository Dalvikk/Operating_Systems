#!/bin/bash

ps -ef | awk '{ if(substr($8, 1, 10)  == "/usr/sbin/") print "PID=" $2 ", command=" $8 }'


