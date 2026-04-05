@echo off
setlocal

set PEAKRDL=rtl\.venv\Scripts\peakrdl
set UDP_SRC=rtl\src\regblock_udps.rdl
set RDL_SRC=rtl\src\pdm_to_pcm.rdl
set RTL_OUT=rtl\src\
set RAL_OUT=src\tb\
set HTML_OUT=docs\html
set CHEADER_OUT=docs\c\

set MODULE_NAME=pdm_to_pcm

mkdir %RTL_OUT% 2>nul
mkdir %RAL_OUT% 2>nul
mkdir %HTML_OUT% 2>nul
mkdir %CHEADER_OUT% 2>nul

echo Exporting RTL regblock...
%PEAKRDL% --peakrdl-cfg rtl\scripts\peakrdl.toml regblock-tt ^
    %UDP_SRC% ^
    %RDL_SRC% ^
    -o %RTL_OUT%

echo Exporting UVM RAL...
%PEAKRDL% --peakrdl-cfg rtl\scripts\peakrdl.toml uvm-tt ^
    %UDP_SRC% ^
    %RDL_SRC% ^
    --type-style hier ^
    -o %RAL_OUT%\%MODULE_NAME%_reg_pkg.sv

echo Exporting HTML documentation...
%PEAKRDL% html ^
    %UDP_SRC% ^
    %RDL_SRC% ^
    -o %HTML_OUT%\

echo Exporting C header...
%PEAKRDL% c-header ^
    %UDP_SRC% ^
    %RDL_SRC% ^
    -o %CHEADER_OUT%\%MODULE_NAME%.h

echo Done

:end
endlocal
