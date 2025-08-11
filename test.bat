@echo off
setlocal

rem run from the script directory
cd /d "%~dp0"

rem verify the DITA-OT CLI is available on PATH
where dita >nul 2>&1
if errorlevel 1 (
  echo ERROR: 'dita' command not found. Install DITA-OT and add its bin to PATH, or run from a DITA-OT command prompt.
  exit /b 1
)

rem make sure output folders exist
if not exist "out\cloud"  mkdir "out\cloud"
if not exist "out\onprem" mkdir "out\onprem"

echo === Building Cloud (html5) ===
dita --input="admin-guide.ditamap" --format=html5 --filter="filters/cloud-admin.ditaval" -o "out\cloud"
if errorlevel 1 (
  echo Build failed for Cloud.
  exit /b 1
)

echo === Building On-prem (html5) ===
dita --input="admin-guide.ditamap" --format=html5 --filter="filters/linux-onprem.ditaval" -o "out\onprem"
if errorlevel 1 (
  echo Build failed for On-prem.
  exit /b 1
)

echo Done.
endlocal
