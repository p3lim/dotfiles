$shell = New-Object -ComObject WScript.Shell
$shortcut = $shell.CreateShortcut("$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Firefox X.lnk")
$shortcut.WorkingDirectory = "C:\Program Files\Mozilla Firefox\"
$shortcut.TargetPath = $shortcut.WorkingDirectory + "firefox.exe"
$shortcut.Arguments = "-no-remote -p x"
$shortcut.IconLocation = $shortcut.TargetPath + ", 0"
$shortcut.Save()
