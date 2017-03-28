attrib +r +s +h update.bat

mkdir %tmp%"\SoftSolutions\bk"

del %tmp%"\SoftSolutions\bk\conexao.udl"
del %tmp%"\SoftSolutions\bk\certificado.pfx"
xcopy conexao.udl %tmp%"\SoftSolutions\bk\"
xcopy "Certificados\certificado.pfx" %tmp%"\SoftSolutions\bk\"

mkdir  %tmp%"\SoftSolutions\downloads"
echo "Aguardando baixar os arquivos."
TortoiseProc.exe /notempfile /command:checkout /path:%tmp%\SoftSolutions\downloads

del /s /q ""
rd /s /q "Certificados"
rd /s /q "Eventos"
rd /s /q "NotasFiscais"
rd /s /q "Schemas" 
rd /s /q "XMLs"
rd /s /q "MinGW"

xcopy  /E /C %tmp%"\SoftSolutions\downloads\trunk"

del "conexao.udl"
del "certificado.pfx"
xcopy %tmp%"\SoftSolutions\bk\conexao.udl"
xcopy %tmp%"\SoftSolutions\bk\certificado.pfx" "Certificados"

attrib -r -s -h update.bat

start instala.bat