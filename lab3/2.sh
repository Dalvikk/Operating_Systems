#!/bin/bash

cat 1.sh | at now + 2 minutes
tail -n 0 -f ~/report
