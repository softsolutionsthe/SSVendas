ECHO OFF
echo *********************************************************************
xcopy  /E /C %tmp%"\SoftSolutions\downloads\SSVendas\trunk" /s /y
echo *********************************************************************
del /s /q "conexao.udl"
del /s /q "certificado.pfx"
del /s /q "configs.ini"
echo *********************************************************************
xcopy %tmp%"\SoftSolutions\bk\conexao.udl"
xcopy %tmp%"\SoftSolutions\bk\configs.ini"
xcopy %tmp%"\SoftSolutions\bk\certificado.pfx" "Certificados"
echo *********************************************************************
del update.bat
xcopy %tmp%\SoftSolutions\downloads\SSVendas\trunk\update.bat /s /y
echo *********************************************************************
unzip SSVendas.zip
start SSVendas.exe
echo *********************************************************************
if EXIST %windir%\SysWOW64 goto Win64

:Win32
ECHO *** Copiando as DLLs ***
if NOT EXIST %windir%\System32\capicom.dll copy capicom.dll %windir%\System32
if NOT EXIST %windir%\System32\msxml5.dll  copy msxml5.dll  %windir%\System32
if NOT EXIST %windir%\System32\msxml5r.dll copy msxml5r.dll %windir%\System32
ECHO *** Registrando as DLLs ***
regsvr32 %windir%\System32\capicom.dll /s
regsvr32 %windir%\System32\msxml5.dll /s
goto end

:Win64
ECHO *** Copiando as DLLs x64 ***
if NOT EXIST %windir%\SysWOW64\capicom.dll copy capicom.dll %windir%\SysWOW64
if NOT EXIST %windir%\SysWOW64\msxml5.dll  copy msxml5.dll  %windir%\SysWOW64
if NOT EXIST %windir%\SysWOW64\msxml5r.dll copy msxml5r.dll %windir%\SysWOW64
ECHO *** Registrando as DLLs x64 ***
regsvr32 %windir%\SysWOW64\capicom.dll /s
regsvr32 %windir%\SysWOW64\msxml5.dll /s
goto end

:end

exit;
