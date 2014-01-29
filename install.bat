@echo off
echo Ensuring .NET 4.0 is installed
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://raw.github.com/StefanScherer/arduino-ide/install/InstallNet4.ps1'))"
echo Installing Chocolatey
@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin

where cinst
if ERRORLEVEL 1 goto set_chocolatey
goto inst
:set_chocolatey
set ChocolateyInstall=%SystemDrive%\Chocolatey
set PATH=%PATH%;%ChocolateyInstall%\bin
:inst

call cinst vim
call cinst sudo
call cinst git
set PATH=%PATH%;C:\Program Files (x86)\Git\cmd\

rem call cinst vagrant
rem set PATH=%PATH%;%ProgramFiles%\Oracle\VirtualBox
rem set PATH=%PATH%;%SystemDrive%\hashicorp\vagrant\bin

cd /D %USERPROFILE%\Documents
if not exist GitHub mkdir GitHub
cd GitHub

git clone https://github.com/StefanScherer/dotfiles-windows.git
cd dotfiles-windows
call sync -f

