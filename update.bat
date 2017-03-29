echo off
cls

del /s /q %temp%\SoftSolutions\downloads
rd /s /q %temp%\SoftSolutions\downloads
rd /s /q %temp%\SoftSolutions\downloads\SSVendas

taskill /f /im ssvendas.exe
taskill /f /im ssvendas_nfce.exe

mkdir %tmp%"\SoftSolutions\bk"

del /s /q %tmp%"\SoftSolutions\bk\conexao.udl"
del /s /q %tmp%"\SoftSolutions\bk\configs.ini"
del /s /q %tmp%"\SoftSolutions\bk\certificado.pfx"

xcopy conexao.udl %tmp%"\SoftSolutions\bk\"
xcopy configs.ini %tmp%"\SoftSolutions\bk\"
xcopy "Certificados\certificado.pfx" %tmp%"\SoftSolutions\bk\"

attrib +r +s +h update.bat
del /s /q ""
attrib -r -s -h update.bat

rd /s /q "Certificados"
rd /s /q "Eventos"
rd /s /q "NotasFiscais"
rd /s /q "Schemas" 
rd /s /q "XMLs"
rd /s /q "MinGW"

echo *********************************************************************
mkdir  %tmp%"\SoftSolutions\downloads\SSVendas"
echo "baixando arquivos..."
svn co https://github.com/softsolutionsthe/SSVendas %tmp%\SoftSolutions\downloads\SSVendas

echo *********************************************************************
xcopy  /E /C %tmp%"\SoftSolutions\downloads\SSVendas\trunk" /s /y
echo *********************************************************************
xcopy %tmp%"\SoftSolutions\bk\conexao.udl" /s /y
xcopy %tmp%"\SoftSolutions\bk\configs.ini" /s /y
xcopy %tmp%"\SoftSolutions\bk\certificado.pfx" "Certificados" /s /y
echo *********************************************************************
unzip SSVendas.zip
unzip SSVendas_NFCe.zip
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
