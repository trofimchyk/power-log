:: Write current date & time to the log-file in current folder
@echo off
echo %DATE% %TIME:~0,-3% >> "%DATE%.log"

:: Delete files older than 4 days
@echo Off
SetLocal EnableDelayedExpansion

Call :FromNow -5
for %%i in (*.log) do (
  set $t=%%~ti& set $d=!$t:~6,4!!$t:~3,2!!$t:~,2!
  if !$d! LSS %yyyymmdd% DEL /F "%%i"
)
Exit /B

:FromNow
 SetLocal
 Set yyyy=%DATE:~-4%& set /a mm=100%DATE:~3,2%%%100& set /a dd=100%DATE:~,2%%%100
 Set /A JD=%~1+dd-32075+1461*(yyyy+4800+(mm-14)/12)/4+367*(mm-2-(mm-14)/12*12)/12-3*((yyyy+4900+(mm-14)/12)/100)/4
 Set /A L=JD+68569,N=4*L/146097,L=L-(146097*N+3)/4,I=4000*(L+1)/1461001
 Set /A L=L-1461*I/4+31,J=80*L/2447,K=L-2447*J/80,L=J/11
 Set /A J=J+2-12*L,I=100*(N-49)+I+L
 Set /A yyyy=I,mm=100+J,dd=100+K
 EndLocal& Set yyyymmdd=%yyyy%%mm:~-2%%dd:~-2%
Exit /B