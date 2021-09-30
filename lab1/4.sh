#!/bin/bash

if [[ $HOME != $PWD ]]; then
	echo "Please, launch from home directory"
	exit 1
fi

echo $HOME

