@ECHO OFF

CD %~dp0

ECHO creating FILES directory...

MD FILES
CD FILES

ECHO gathering configuration...

FOR /F "tokens=3-5 skip=2" %%G IN ('REG Query "HKLM\SOFTWARE\Tableau" /F "AppVersion" /S /E /C') DO if not "%%G" == "search:" set TSPATH=%%G %%H %%I

"%TSPATH%\bin\tabadmin.exe" config -o workgroup.yml

ECHO identifying hosts...

cscript ..\SCRIPTS\read.vbs //NOLOGO

ECHO gathering cpu information...

WMIC /output:cpu.csv /node:@hosts.txt cpu get name, numberofcores, numberoflogicalprocessors, manufacturer, deviceid, systemname /format:csv

ECHO gathering os information...

WMIC /output:os.csv /node:@hosts.txt os get name, caption, csname, freephysicalmemory, freevirtualmemory, totalvirtualmemorysize, osarchitecture /format:csv

ECHO gathering computer system information...

WMIC /output:computersystem.csv /node:@hosts.txt computersystem get name, caption, manufacturer, model, numberoflogicalprocessors, numberofprocessors, systemtype, totalphysicalmemory /format:csv

ECHO gathering pagefile information...

WMIC /output:pagefile.csv /node:@hosts.txt pagefile get allocatedbasesize, currentusage, caption, name, peakusage /format:csv

ECHO gathering logical disk information...

WMIC /output:logicaldisk.csv /node:@hosts.txt logicaldisk get name, caption, description, systemname, volumename, size, freespace, filesystem /format:csv

ECHO performing cleanup tasks...

DEL hosts.txt

cscript ..\SCRIPTS\cleanup.vbs //NOLOGO

ECHO data written to FILES directory...

CD ..\

PAUSE



