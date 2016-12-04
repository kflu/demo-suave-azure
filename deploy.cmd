@echo off

if not exist .paket (
  @echo "Installing Paket"
  mkdir .paket
  curl https://github.com/fsprojects/Paket/releases/download/1.4.0/paket.bootstrapper.exe -L --insecure -o .paket\paket.bootstrapper.exe

  if errorlevel 1 (
    exit /b %errorlevel%
  )
)

.paket\paket.bootstrapper.exe prerelease
if errorlevel 1 (
  exit /b %errorlevel%
)

if not exist paket.lock (
  @echo "Installing dependencies"
  .paket\paket.exe install
) else (
  @echo "Restoring dependencies"
  .paket\paket.exe restore
)

if errorlevel 1 (
  exit /b %errorlevel%
)

@ECHO Running build
CALL build.cmd

@echo "Copying files to web root"
xcopy /s /y build\ d:\home\site\wwwroot\
