#
# Settings for software I use on Windows 10 (1709) desktop.
# Most of the tools I use is run under WSL.
#

if(!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")){
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $PSScriptRoot -Verb RunAs
	Exit
}

function link($src, $dest){
	if(Test-Path $dest){
		Move-Item -Path $dest -Destination "$($dest)~"
	}

	New-Item -Path $dest -ItemType SymbolicLink -Value $src
}

Push-Location $PSScriptRoot

link '.config\git\config' "$HOME\.gitconfig"
link '.config\sublime-text-3\Packages\C++' "$env:APPDATA\Sublime Text 3\Packages\C++"
link '.mozilla\firefox\profiles.ini' "$env:APPDATA\Mozilla\Firefox\profiles.ini"
link '.mozilla\firefox\Profiles\p3lim\chrome' "$env:APPDATA\Mozilla\Firefox\Profiles\p3lim\chrome"
link '.minttyrc' "$env:APPDATA\wsltty\config"

Get-ChildItem '.config\sublime-text-3\Packages\User' | Foreach-Object {
	link "$($_.FullName)" "$env:APPDATA\Sublime Text 3\Packages\User\$($_.Name)"
}

if(!(Test-Path "$env:APPDATA\Sublime Text 3\Packages\Default")){
	New-Item -Path "$env:APPDATA\Sublime Text 3\Packages\Default" -ItemType Directory
}

Get-ChildItem '.config\sublime-text-3\Packages\Default' | Foreach-Object {
	link "$($_.FullName)" "$env:APPDATA\Sublime Text 3\Packages\Default\$($_.Name)"
}

if(!(Test-Path "$env:APPDATA\Sublime Text 3\Packages\Paste")){
    git clone https://github.com/p3lim/sublime-paste "$env:APPDATA\Sublime Text 3\Packages\Paste"
}
