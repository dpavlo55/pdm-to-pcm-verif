@echo off
setlocal

:: Generate timestamp: DD-MM-YYYY HH:MM:SS
for /f "tokens=1-3 delims=/" %%a in ("%date%") do (
    set DAY=%%a
    set MON=%%b
    set YR=%%c
)
for /f "tokens=1-3 delims=:." %%a in ("%time: =0%") do (
    set HH=%%a
    set MM=%%b
    set SS=%%c
)
set TIMESTAMP=%DAY%-%MON%-%YR% %HH%:%MM%:%SS%
set MSG=wip %TIMESTAMP%

echo Commit message: %MSG%
echo.

:: ── 1. rtl subrepo ──────────────────────────────────────────────────────────
echo [1/3] Committing rtl...
cd /d "%~dp0rtl"
git add -A
git diff --cached --quiet && (echo   No changes to commit in rtl) || (
    git commit -m "%MSG%"
    git push
)

:: ── 2. parent verif repo ────────────────────────────────────────────────────
echo [2/3] Committing pdm-to-pcm-verif...
cd /d "%~dp0"
git add -A
git diff --cached --quiet && (echo   No changes to commit in pdm-to-pcm-verif) || (
    git commit -m "%MSG%"
    git push
)

:: ── 3. uvc_create repo ──────────────────────────────────────────────────────
echo [3/3] Committing uvc_create...
cd /d "%~dp0..\uvc_create"
git add -A
git diff --cached --quiet && (echo   No changes to commit in uvc_create) || (
    git commit -m "%MSG%"
    git push
)

echo.
echo Done.
endlocal
