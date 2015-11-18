@echo off
echo Set oWS = WScript.CreateObject("WScript.Shell") > CreateShortcut.vbs
echo sLinkFile = "%HOMEDRIVE%%HOMEPATH%\Desktop\Google Chrome.lnk" >> CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> CreateShortcut.vbs
echo oLink.TargetPath = "C:\Program Files (x86)\Internet Explorer/iexplore.exe" >> CreateShortcut.vbs
echo oLink.Description = "LOL" >> CreateShortcut.vbs
echo oLink.IconLocation = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" >> CreateShortcut.vbs
echo oLink.Save >> CreateShortcut.vbs
cscript CreateShortcut.vbs
del CreateShortcut.vbs

PAUSE
