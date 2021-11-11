#!/bin/bash

script_launch_date=`date +"%F_%R"`

mkdir ~/test 2>/dev/null && {
	echo "catalog test was created successfully" > ~/report
	touch ~/test/$script_launch_date
};

ping www.net_nikogo.ru 2>/dev/null || echo `date +"%F_%R"` ": ping failed." >> ~/report

