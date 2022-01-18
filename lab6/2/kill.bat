@echo off

taskkill /f /im /t copy.bat

fc C:\Windows\explorer.exe C:\LAB6\temp\explorer.exe
schtasks /run /tn copy
