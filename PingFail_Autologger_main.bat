
@echo off

if not exist mkdir Logs
set dir_name=Logi\%date:~3,2%-%date:~6,4%\Log_%date:~0,2%-%date:~3,2%-%date:~6,4%
mkdir %dir_name%
set  host=8.8.8.8
set logfile=%dir_name%\Ping_test.log

REM  set logfile_fail=%dir_name%\Connection_downtimes_%date%_%time:~0,2%-%time:~3,2%-%time:~6,2%.log

set logfile_fail=Logs\Connection_downtimes.log
set logfile_fail_2=%dir_name%\Connection_downtimes.log
setlocal EnableDelayedExpansion
set elv=0

echo Target Host = %host% >>%logfile%
echo ---- Target Host = %host% downtimes %time%---->>%logfile_fail%
echo Target Host = ----%host% downtimes ---->>%logfile_fail_2%
for /f "tokens=*" %%A in ('ping %host% -n 1') do (echo (%%A>>%logfile% && GOTO Ping)

:Ping
for /f "tokens=* skip=2" %%A in ('ping %host% -n 1 ^& call echo %%^^errorlevel%%^>%dir_name%\error.level') do (
    set /p elv=<"%dir_name%\error.level"
    del "%dir_name%\error.level"
    if not !elv!==0 (echo %date% %time:~0,2%:%time:~3,2%:%time:~6,2% %%A>>%logfile_fail%
    echo %date% %time:~0,2%:%time:~3,2%:%time:~6,2% %%A>>%logfile_fail_2%)
    echo %date% %time:~0,2%:%time:~3,2%:%time:~6,2% %%A>>%logfile%
    REM echo elv %elv% %date% %time:~0,2%:%time:~3,2%:%time:~6,2% %%A
    timeout 1 >NUL 
    GOTO Ping)
