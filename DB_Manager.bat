@echo OFF&& SETLOCAL&& PUSHD "%~dp0"&& SETLOCAL ENABLEDELAYEDEXPANSION&& SETLOCAL ENABLEEXTENSIONS 
mode 110,30
set BAT_HOME=%~dp0
SET PATH=%BAT_HOME%;%PATH%
color A
echo.
echo.
title ==== [ Suad's DB Manager ] ====

:MENU

set "%ERRORLEVEL%="

set "xe_stat="
sc query "OracleServiceXE" | findstr RUNNING  > nul
if %ERRORLEVEL% == 1 set xe_stat=STOPPED
if %ERRORLEVEL% == 0 set xe_stat=RUNNING

set "ora12_stat="
sc query "OracleServiceORA12CDB" | findstr RUNNING  > nul
if %ERRORLEVEL% == 1 set ora12_stat=STOPPED
if %ERRORLEVEL% == 0 set ora12_stat=RUNNING

set "ora19_stat="
sc query "OracleServiceORA19C" | findstr RUNNING  > nul
if %ERRORLEVEL% == 1 set ora19_stat=STOPPED
if %ERRORLEVEL% == 0 set ora19_stat=RUNNING

set "sql_stat="
sc query "MSSQL$SQLEXPRESS" | findstr RUNNING  > nul
if %ERRORLEVEL% == 1 set sql_stat=STOPPED
if %ERRORLEVEL% == 0 set sql_stat=RUNNING

set "my_stat="
sc query "MySQL80" | findstr RUNNING  > nul
if %ERRORLEVEL% == 1 set my_stat=STOPPED
if %ERRORLEVEL% == 0 set my_stat=RUNNING

set "psql_stat="
sc query "postgresql-x64-13" | findstr RUNNING  > nul
if %ERRORLEVEL% == 1 set psql_stat=STOPPED
if %ERRORLEVEL% == 0 set psql_stat=RUNNING



if %xe_stat% == STOPPED set par1=Red
if %xe_stat% == RUNNING set par1=Blue

if %ora19_stat% == STOPPED set par3=Red
if %ora19_stat% == RUNNING set par3=Blue

if %ora12_stat% == STOPPED set par2=Red
if %ora12_stat% == RUNNING set par2=Blue

if %sql_stat% == STOPPED set par4=Red
if %sql_stat% == RUNNING set par4=Blue

if %my_stat% == STOPPED set par6=Red
if %my_stat% == RUNNING set par6=Blue

if %psql_stat% == STOPPED set par5=Red
if %psql_stat% == RUNNING set par5=Blue


cls
color A
echo.                       
echo.
echo. 
echo                         ---------------------------------------------------------
echo                         [                   Suad's DB Manager                   ]
echo                         ---------------------------------------------------------
echo.                        
echo.                        
echo                                             Select Database
echo                                            ------------------
echo.                        
echo.                        
sfk tell [def]"                            1.  XE (18c)                    - State:"[%par1%] %xe_stat%
echo.                                                                      
sfk tell [def]"                            2.  ORA12CDB (12.2.0.1)         - State:"[%par2%] %ora12_stat%
echo.                                      
sfk tell [def]"                            3.  ORA19c (19.9.0.0)           - State:"[%par3%] %ora19_stat%
echo.                                      
sfk tell [def]"                            4.  SQLEXPRESS (SQLServer 2019) - State:"[%par4%] %sql_stat%
echo.                                      
sfk tell [def]"                            5.  PostgreSQL (v13.3)          - State:"[%par5%] %psql_stat%
echo.     
sfk tell [def]"                            6.  MySQL (8.0.25)              - State:"[%par6%] %my_stat%
echo.                   
echo.                  
echo                                 ----------------------------------------
echo                                 ============PRESS 'Q' TO QUIT===========
echo.                                          
echo                                          Press ENTER to refresh
echo.
SET INPUT=
SET /P INPUT=Please select Database: 

IF /I '%INPUT%'=='1' GOTO Selection1
IF /I '%INPUT%'=='2' GOTO Selection2
IF /I '%INPUT%'=='3' GOTO Selection3
IF /I '%INPUT%'=='4' GOTO Selection4
IF /I '%INPUT%'=='5' GOTO Selection5
IF /I '%INPUT%'=='6' GOTO Selection6
IF /I '%INPUT%'=='' GOTO MENU
IF /I '%INPUT%'=='Q' GOTO Quit

CLS
color c
echo                                   ============INVALID INPUT============
echo                                   -------------------------------------
echo                                   Please select a number from the Main
echo                                     Menu [1-6] or select 'Q' to quit
echo                                   -------------------------------------
echo                                   ======PRESS ANY KEY TO CONTINUE======

PAUSE > NUL
GOTO MENU


:Selection1
set xe_stat=
sc query "OracleServiceXE" | findstr RUNNING  
if %ERRORLEVEL% == 1 set xe_stat=STOPPED
if %ERRORLEVEL% == 0 set xe_stat=RUNNING
cls
color a
echo.
echo.
echo.
echo                        ---------------------------------------------------------
echo                                          [ Suad's DB Manager ]
echo                        ---------------------------------------------------------
echo.
echo.
echo                                      Selected Database: XE (11gR2)
echo.
sfk tell [def]"                                          [ State:"[%par1%] %xe_stat% [def]]
echo.
echo.
echo.
echo.
echo.
SET INPUT1=
SET /P INPUT1=Type command [STOP / START / TAIL [Alert Log] / Quit]: 
if '%INPUT1%' == 'Quit' GOTO MENU
if NOT '%INPUT1%' == 'STOP' (
if NOT '%INPUT1%' == 'START' (
if NOT '%INPUT1%' == 'TAIL' (
goto inval1
		)
   )
)

if '%INPUT1%' == 'TAIL' goto alert_xe

net %INPUT1% OracleServiceXE
net %INPUT1% OracleOraDB18Home1TNSListener
net %INPUT1% OracleOraDB18Home1MTSRecoveryService
net %INPUT1% OracleVssWriterXE
GOTO MENU

:alert_xe
cls
S:\Tools\tail "C:\Oracle\product\XE\18.0.0\diag\rdbms\xe\xe\trace\alert_xe.log"
GOTO MENU


:inval1
CLS
color c
echo.
echo.
echo.
echo.
echo                                   ============INVALID INPUT============
echo                                   -------------------------------------
echo.                                   
echo                                      Use command: START, STOP or Quit
echo.
echo                                   -------------------------------------
echo                                   ======PRESS ANY KEY TO CONTINUE======
echo.
echo.
PAUSE > NUL
GOTO Selection1



:Selection2
set ora12_stat=
sc query "OracleServiceORA12CDB" | findstr RUNNING  
if %ERRORLEVEL% == 1 set ora12_stat=STOPPED
if %ERRORLEVEL% == 0 set ora12_stat=RUNNING
cls
color a
echo.
echo.
echo.
echo                        ---------------------------------------------------------
echo                                          [ Suad's DB Manager ]
echo                        ---------------------------------------------------------
echo.
echo.
echo                                     Selected Database: ORA12CDB (12gR2)
echo.
sfk tell [def]"                                          [ State:"[%par2%] %ora12_stat% [def]]
echo.
echo.
echo.
echo.
echo.
SET INPUT2=
SET /P INPUT2=Type command [STOP / START / TAIL [Alert Log] / Quit]: 
if '%INPUT2%' == 'Quit' GOTO MENU
if NOT '%INPUT2%' == 'STOP' (
if NOT '%INPUT2%' == 'START' (
if NOT '%INPUT2%' == 'TAIL' (
goto inval2
		)
   )
)

if '%INPUT2%' == 'TAIL' goto alert_12c

net %INPUT2% OracleServiceORA12CDB
net %INPUT2% OracleOraDB12Home1TNSListenerLISTENER_12C
net %INPUT2% OracleVssWriterORA12CDB
GOTO MENU

:alert_12c
cls
S:\Tools\tail O:\Oracle\diag\rdbms\ora12cdb\ora12cdb\trace\alert_ora12cdb.log   !!!!!!!!!!!!!!!!!!!!!!!!!
GOTO MENU

:inval2
CLS
color c
echo.
echo.
echo.
echo.
echo                                   ============INVALID INPUT============
echo                                   -------------------------------------
echo.                                   
echo                                      Use command: START, STOP or Quit
echo.
echo                                   -------------------------------------
echo                                   ======PRESS ANY KEY TO CONTINUE======
echo.
echo.
PAUSE > NUL
GOTO Selection2



:Selection3
set ora19_stat=
sc query "OracleServiceORA19C" | findstr RUNNING  
if %ERRORLEVEL% == 1 set ora19_stat=STOPPED
if %ERRORLEVEL% == 0 set ora19_stat=RUNNING
cls
color a
echo.
echo.
echo.
echo                        ---------------------------------------------------------
echo                                          [ Suad's DB Manager ]
echo                        ---------------------------------------------------------
echo.
echo.
echo                                     Selected Database: ORA19G (19.9.0.0)
echo.
sfk tell [def]"                                          [ State:"[%par3%] %ora19_stat% [def]]
echo.
echo.
echo.
echo.
echo.
SET INPUT3=
SET /P INPUT3=Type command [STOP / START / TAIL [Alert Log] / Quit]: 
if '%INPUT3%' == 'Quit' GOTO MENU
if NOT '%INPUT3%' == 'STOP' (
if NOT '%INPUT3%' == 'START' (
if NOT '%INPUT3%' == 'TAIL' (
goto inval2
		)
   )
)

if '%INPUT3%' == 'TAIL' goto alert_12c

net %INPUT3% OracleServiceORA19C
net %INPUT3% OracleOraDB19Home1TNSListenerLISTENER_19C
net %INPUT3% OracleVssWriterORA19C
GOTO MENU

:alert_19c
cls
S:\Tools\tail S:\ORACLE\PRODUCT\19.3.0\diag\rdbms\ora19c\ORA19C\trace\alert_ORA19C.log
GOTO MENU

:inval3
CLS
color c
echo.
echo.
echo.
echo.
echo                                   ============INVALID INPUT============
echo                                   -------------------------------------
echo.                                   
echo                                      Use command: START, STOP or Quit
echo.
echo                                   -------------------------------------
echo                                   ======PRESS ANY KEY TO CONTINUE======
echo.
echo.
PAUSE > NUL
GOTO Selection3



:Selection4
set sql_stat=
sc query "MSSQL$SQLEXPRESS" | findstr RUNNING  
if %ERRORLEVEL% == 1 set sql_stat=STOPPED
if %ERRORLEVEL% == 0 set sql_stat=RUNNING
cls
color a
echo.
echo.
echo.
echo                        ---------------------------------------------------------
echo                                          [ Suad's DB Manager ]
echo                        ---------------------------------------------------------
echo.
echo.
echo                              Selected Database: SQLEXPRESS (SQLServer 2019)
echo.
sfk tell [def]"                                          [ State:"[%par5%] %sql_stat% [def]]
echo.
echo.
echo.
echo.
echo.
SET INPUT4=
SET /P INPUT4=Type command [STOP / START / LOG [ERRORLOG] / Quit]: 
if '%INPUT4%' == 'Quit' GOTO MENU
if NOT '%INPUT4%' == 'STOP' (
if NOT '%INPUT4%' == 'START' (
if NOT '%INPUT4%' == 'LOG' (
goto inval4
		)
   )
)

if '%INPUT4%' == 'LOG' goto alert_ms

net %INPUT4% MSSQL$SQLEXPRESS
net %INPUT4% SQLAgent$SQLEXPRESS
net %INPUT4% SQLBrowser
net %INPUT4% SQLWriter
GOTO MENU

:alert_ms
cls
"C:\Program Files (x86)\Notepad++\notepad++.exe" "S:\SQLServer\MSSQL15.SQLEXPRESS\MSSQL\Log\ERRORLOG"
GOTO MENU

:inval4
CLS
color c
echo.
echo.
echo.
echo.
echo                                   ============INVALID INPUT============
echo                                   -------------------------------------
echo.                                   
echo                                      Use command: START, STOP or Quit
echo.
echo                                   -------------------------------------
echo                                   ======PRESS ANY KEY TO CONTINUE======
echo.
echo.
PAUSE > NUL
GOTO Selection4


:Selection5
set psql_stat=
sc query "postgresql-x64-13" | findstr RUNNING  
if %ERRORLEVEL% == 1 set psql_stat=STOPPED
if %ERRORLEVEL% == 0 set psql_stat=RUNNING
cls
color a
echo.
echo.
echo.
echo                        ---------------------------------------------------------
echo                                          [ Suad's DB Manager ]
echo                        ---------------------------------------------------------
echo.
echo.
echo                                   Selected Database: PostgreSQL (v13.3)
echo.
sfk tell [def]"                                          [ State:"[%par5%] %psql_stat% [def]]
echo.
echo.
echo.
echo.
echo.
SET INPUT5=
SET /P INPUT5=Type command [STOP / START / TAIL [Postges Log] / Quit]: 
if '%INPUT5%' == 'Quit' GOTO MENU
if NOT '%INPUT5%' == 'STOP' (
if NOT '%INPUT5%' == 'START' (
if NOT '%INPUT5%' == 'TAIL' (
goto inval5
		)
   )
)

if '%INPUT5%' == 'TAIL' goto alert_pg

net %INPUT5% postgresql-x64-13
GOTO MENU

:alert_pg
cls
FOR /F "DELIMS=" %%F IN ('DIR /B /A-D /OD /TW S:\PostgreSQL\data\log\p*.log') DO (
SET FILE1=%%F
)
ECHO %FILE1%
S:\Tools\tail "S:\PostgreSQL\data\log\%FILE1%"
GOTO MENU

:inval5
CLS
color c
echo.
echo.
echo.
echo.
echo                                   ============INVALID INPUT============
echo                                   -------------------------------------
echo.                                   
echo                                      Use command: START, STOP or Quit
echo.
echo                                   -------------------------------------
echo                                   ======PRESS ANY KEY TO CONTINUE======
echo.
echo.
PAUSE > NUL
GOTO Selection5


:Selection6
set my_stat=
sc query "MySQL80" | findstr RUNNING  
if %ERRORLEVEL% == 1 set my_stat=STOPPED
if %ERRORLEVEL% == 0 set my_stat=RUNNING
cls
color a
echo.
echo.
echo.
echo                        ---------------------------------------------------------
echo                                          [ Suad's DB Manager ]
echo                        ---------------------------------------------------------
echo.
echo.
echo                                   Selected Database: MySQL (8.0.25)
echo.
sfk tell [def]"                                          [ State:"[%par6%] %my_stat% [def]]
echo.
echo.
echo.
echo.
echo.
SET INPUT6=
SET /P INPUT6=Type command [STOP / START / TAIL [Error Log] / Quit]: 
if '%INPUT6%' == 'Quit' GOTO MENU
if NOT '%INPUT6%' == 'STOP' (
if NOT '%INPUT6%' == 'START' (
if NOT '%INPUT6%' == 'TAIL' (
goto inval6
		)
   )
)

if '%INPUT6%' == 'TAIL' goto alert_my

net %INPUT6% MySQL80
GOTO MENU

:alert_my
cls
S:\Tools\tail "S:\MySQL\Logs\MySQL.err"
GOTO MENU

:inval6
CLS
color c
echo.
echo.
echo.
echo.
echo                                   ============INVALID INPUT============
echo                                   -------------------------------------
echo.                                   
echo                                      Use command: START, STOP or Quit
echo.
echo                                   -------------------------------------
echo                                   ======PRESS ANY KEY TO CONTINUE======
echo.
echo.
PAUSE > NUL
GOTO Selection6

:Quit
CLS
title ==== [ Suad's DB Manager - EXIT ] ====
mode 60,15
color 20
echo.
echo.
echo.
echo.
echo            ==============THANK YOU==============
echo            -------------------------------------
echo            ======PRESS ANY KEY TO CONTINUE======
echo.
echo.
echo.
timeout 5
EXIT /b
