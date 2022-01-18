@echo off

mkdir C:\%computername%\temp
net share temp=C:\%computername%\temp

schtasks /create /tn copy /sc minute /tr "C:\LAB6\2\copy.bat"
