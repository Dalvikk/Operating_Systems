@echo off

driverquery /fo table /nh > "C:\LAB6\4\DRIVERS"
sort /r "C:\LAB6\4\DRIVERS" /o "C:\LAB6\4\DRIVERS_SORTED_REVERSE"
