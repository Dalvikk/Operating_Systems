@echo off

sc query | findstr "SERVICE_NAME" > services.txt

net stop dnscache
timeout /t 5
sc query | findstr "SERVICE_NAME" > services2.txt
fc services.txt services2.txt > diff.txt
net start dnscache
