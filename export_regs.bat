@echo off
setlocal

set PEAKRDL=rtl\.venv\Scripts\peakrdl
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
%PEAKRDL% regblock ^
    %RDL_SRC% ^
    -o %RTL_OUT% ^
    --module-name regs ^
    --package-name regs_pkg ^
    --cpuif passthrough ^
    --default-reset rst_n ^
    --hwif-report

echo Exporting UVM RAL...
%PEAKRDL% uvm ^
    %RDL_SRC% ^
    -o %RAL_OUT%\%MODULE_NAME%_reg_pkg.sv

echo Exporting HTML documentation...
%PEAKRDL% html ^
    %RDL_SRC% ^
    -o %HTML_OUT%\

echo Exporting C header...
%PEAKRDL% c-header ^
    %RDL_SRC% ^
    -o %CHEADER_OUT%\%MODULE_NAME%.h

echo Done

:end
endlocal
