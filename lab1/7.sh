#!/bin/bash

EMAILREGEX="[a-zA-Z0-9_.]+@[a-zA-Z0-9_]+(\\.[a-zA-Z]+)+"

grep -r -E -o -h -I $EMAILREGEX /etc | tr '\n' ',' > emails.lst

