; https://stackoverflow.com/questions/39253268/autohotkey-and-windows-10-how-to-get-current-explorer-path
GetActiveExplorerPath() {
    explorerHwnd := WinActive("ahk_class CabinetWClass")
    if (explorerHwnd)
    {
        for window in ComObjCreate("Shell.Application").Windows
        {
            if (window.hwnd==explorerHwnd)
                return window.Document.Folder.Self.Path
        }
    }
}

^!t::
p := GetActiveExplorerPath()
wt := WinExist("ahk_class CASCADIA_HOSTING_WINDOW_CLASS")
if (wt) {
    WinActivate, ahk_id %wt%
} else {
    Run, wt.exe
}
WinWaitActive, ahk_class CASCADIA_HOSTING_WINDOW_CLASS
if (p != "") {
    SendInput, ^+2
    SendInput, cd %p%{Enter}
}
return
