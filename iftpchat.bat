@echo off
REM Created by @IWickGames#7827 on github.com/iwickgames
REM Thank you for using my easy chat library! Just read these comments for an easy understanding.

REM Send a message
if "%1"=="-send" goto send
REM List the chat
if "%1"=="-list" goto list
REM Write the list to a file
if "%1"=="-listfile" goto listfile
REM Enter the server to connect to;
if "%1"=="-setserverftp" goto setserverftp
if "%1"=="-setserverlocal" goto setserverlocal
REM Help
if "%1"=="-help" goto help
REM Show help page as you dident type a valid command!
goto help

REM Send a message to the server
:send
if exist local.server goto sendlocal
REM Send message Via FTP
if exist ftp.server set /p server=<ftp.server
echo Sorry but the current build of your library does not have FTP sending enabled!
echo                          It will be added soon!
goto exit
:sendlocal
REM Send message Via Local Server
set /p network=<local.server
if not exist z: net use z: "%network%"
if not exist Z:\ goto neterror
if not exist z:\iftpchat mkdir z:\iftpchat
if not exist z:\iftpchat\chat mkdir z:\iftpchat\chat
for /f "tokens=1,* delims= " %%a in ("%*") do set message=%%b
if "%message%"=="" goto errornomessage
echo Sending "%message%" to %server% via Local
echo %time%:%date% : %username%] %message%>>Z:\iftpchat\chat\chat.log
goto exit

REM Display the Chat into the command line you are in
:list
if exist local.server goto listlocal
REM List a FTP server
goto exit
:listlocal
REM List a local server
set /p network=<local.server
if not exist z: net use z: "%network%"
if not exist Z:\iftpchat\chat goto errornochat
type Z:\iftpchat\chat\chat.log
goto exit

REM Save the list to a file
:listfile
if exist local.server goto listlocalfile
REM List a FTP server
goto exit
REM List a local server
:listlocalfile
set /p network=<local.server
if not exist z: net use z: "%network%"
if not exist Z:\iftpchat\chat goto errornochat
type Z:\iftpchat\chat\chat.log>>chatdump.chat
goto exit

REM Sets the FTP server into the save file
:setserverftp
if "%2"=="" goto noserverftp
echo Setting server to %2
echo %2>ftp.server
echo exit

REM Sets the local server into the save file
:setserverlocal
if "%2"=="" goto noserverlocal
echo Setting server to %2
echo %2>local.server
goto exit

REM Help page
:help
echo.
echo.
echo Usage;
echo %~nx0 [arg] [data]
echo.
echo.
echo   -send [message]             : Send a message no "" if its in the message it will be sent
echo   -list                       : List the chat
echo   -listfile [Filename]        : Outputs the list into a file no ""
echo   -setserverftp [Server]      : Sets the ftp server to connect to. No "" Ex: 192.168.1.2
echo   -setserverlocal [Server]    : Set the local server. No "" Ex: \\192.168.1.2\servername\folder
echo   -help                       : Display the help page
echo.
echo   To create the iftpchat folder just send a message for the first time to generate the folder!
goto exit

REM Net error
:neterror
echo.
echo Error: %network% could not be mounted as Z:
goto exit 

REM Error no message send command
:errornomessage
echo.
echo Data value for -send not satisfied
goto help

REM Chat folder does not exist
:errornochat
echo.
echo Error: Z:\iftpchat\chat does not exist on the server you selected : %network%
goto exit

REM Error if there is no server entered into the serserverlocal command
:noserverlocal
echo.
echo Data value not satisfied for -setserverlocal
goto help

REM Error if there is no server entered into the setserverftp command
:noserverftp
echo.
echo Data value not satisfied for -setserverftp
goto help

REM Exits the script without closing the window
:exit
echo.
echo.
exit /b
