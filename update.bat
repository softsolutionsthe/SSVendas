echo off
cls

taskill /f /im ssvendas.exe
taskill /f /im ssvendas_nfce.exe

attrib +r +s +h update.bat

mkdir %tmp%"\SoftSolutions\bk"

del /s /q %tmp%"\SoftSolutions\bk\conexao.udl"
del /s /q %tmp%"\SoftSolutions\bk\configs.ini"
del /s /q %tmp%"\SoftSolutions\bk\certificado.pfx"

xcopy conexao.udl %tmp%"\SoftSolutions\bk\"
xcopy configs.ini %tmp%"\SoftSolutions\bk\"
xcopy "Certificados\certificado.pfx" %tmp%"\SoftSolutions\bk\"

del /s /q ""
rd /s /q "Certificados"
rd /s /q "Eventos"
rd /s /q "NotasFiscais"
rd /s /q "Schemas" 
rd /s /q "XMLs"
rd /s /q "MinGW"

mkdir  %tmp%"\SoftSolutions\downloads\SSVendas"
echo "Aguardando baixar os arquivos."
TortoiseProc.exe /notempfile /command:checkout /path:%tmp%\SoftSolutions\downloads\SSVendas

attrib -r -s -h update.bat

xcopy %tmp%\SoftSolutions\downloads\SSVendas\trunk\instala.bat
start instala.bat
