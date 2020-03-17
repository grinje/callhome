@echo off
setlocal

set ADDRESS=remote.host
set PORT=22

set SSHFLAGS=-q -o ServerAliveInterval=60 -o StrictHostKeyChecking=no -o ServerAliveCountMax=2 -o ExitOnForwardFailure=True
set SSHCMD=ssh -T %SSHFLAGS% -p %PORT% callhome@%ADDRESS%

:loop

set tunnel=UNSET
for /f "usebackq tokens=*" %%a in (`ssh -T -p %PORT% callhome@%ADDRESS%`) do (set tunnel=%%a)

if not "%tunnel%"=="UNSET" (
  %SSHCMD% -N -R "*:%tunnel%:127.0.0.1:3389"
)

timeout 60 /nobreak > nul

goto loop
