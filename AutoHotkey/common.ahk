;ActiveINode()
;ActiveEspace()
;运行iNode
ActiveINode()
{    
    ;目前INode没判断登录
    if !WinExist("ahk_exe iNode Client.exe")
    {
        Run, "C:\Program Files (x86)\iNode\iNode Client\iNode Client.exe"        
        WinWait, iNode智能客户端, , 5
        if ErrorLevel
        {
            MsgBox, WinWait timed out.
            return
        }
    }
    
    WinActivate, ahk_class Qt5QWindowIcon
	;WinMove, iNode智能客户端,(A_ScreenWidth/2)-(Width/2), (A_ScreenHeight/2)-(Height/2)
    ;WinMaximize, ahk_class Qt5QWindowIcon 
    PixelGetColor, OutputVar, 136, 290
    ;MsgBox, %OutputVar%
    if %OutputVar% != 0xD0C3A1
    {    
        ;MsgBox, %OutputVar% 
        SetControlDelay -1
        ;ControlClick x162 y295,iNode智能客户端
        Click left 162, 295
        Sleep 3000 
        ActiveEspace()
    }	
	WinMinimize, ahk_class Qt5QWindowIcon

}       

;运行espace
ActiveEspace()
{
    ;判断是否已经运行
    if WinExist("ahk_exe eSpace.exe")
        WinActivate, ahk_exe eSpace.exe
    else
        Run, "C:\Program Files (x86)\eSpace_Desktop\eSpace.exe"
    ;判断是否已经登录
    if WinExist("eSpace Login")
    {
        WinWait, eSpace Login, , 3
        if ErrorLevel
        {
            MsgBox, WinWait timed out.
            return
        }
        WinActivate, ahk_exe eSpace.exe
        ;ControlClick x159 y579, eSpace Login
        Click left 159, 579
        ;Sleep 3000        
    }
	else
	{
		WinActivate, ahk_exe eSpace.exe
	}
}

:*:]t::  ; This hotstring replaces "]d" with the current date and time via the commands below.
FormatTime, CurrentDateTime,, yyyy-MM-dd HH:mm  ; It will look like 9/1/2005 3:53 PM
SendInput %CurrentDateTime%
return


:*:]d::  ; This hotstring replaces "]d" with the current date and time via the commands below.
FormatTime, CurrentDateTime,, yyyyMMdd  ; It will look like 9/1/2005 3:53 PM
SendInput %CurrentDateTime%
return


:*:/c3::Changeme_123

:*:/ikey::http://idea.iteblog.com/key.php

:*:@mvnt::mvn dependency:tree
:*:@mvna::mvn dependency:analyze

:*:@lsof::netstat -aon|findstr

:*:@log::private{space}static{space}final{space}Logger{space}LOG{space}={space}LoggerFactory.getLogger();

!n::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe notepad++.exe")
    WinActivate, ahk_exe notepad++.exe
else
    Run, notepad++.exe
return

!b::
; Activate an existing notepad.exe window, or open a new one
full_path:=getCurrentPath()
Run, "C:\Program Files\Git\git-bash.exe" "--cd=%full_path%."

return

!c::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe Clover.exe")
    WinActivate, ahk_exe Clover.exe
else
    Run, C:\Program Files (x86)\Clover\Clover.exe
return

!i::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe opera.exe")
    WinActivate, ahk_exe opera.exe
else
    Run, "C:\Program Files (x86)\Opera\launcher.exe"
return

!g::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe chrome.exe")
    WinActivate, ahk_exe chrome.exe
else
    Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  --args --disable-web-security --user-data-dir
return

!m::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe navicat.exe")
    WinActivate, ahk_exe navicat.exe
else
    Run, "C:\Program Files\PremiumSoft\Navicat Premium 12\navicat.exe"
return


!e::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe idea64.exe")
    WinActivate, ahk_exe idea64.exe
else
    Run, "D:\Program Files\JetBrains\IntelliJ IDEA 2017.2.1\bin\idea64.exe"
return

!p::
; Activate an existing notepad.exe window, or open a new one
Run, "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  --profile-directory=Default --app-id=fhbjgbiflinjbdggehcddcbncdddomop
return

!w::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe WINWORD.EXE")
    WinActivate, ahk_exe WINWORD.EXE
else
    Run, WINWORD.EXE
return

!f::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe Xftp.exe")
    WinActivate, ahk_exe Xftp.exe
else
    Run, "D:\Program Files (x86)\NetSarang\Xmanager Enterprise 5\Xftp.exe"
return

!s::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe Xshell.exe")
    WinActivate, ahk_exe Xshell.exe
else
    Run, "D:\Program Files (x86)\NetSarang\Xmanager Enterprise 5\Xshell.exe"
return


!r::OpenCmdInCurrent()
; Activate an existing notepad.exe window, or open a new one

$^+u::
if WinActive("ahk_exe explorer.exe")
{
    ExecuteCmdInCurrentPause("svn update .")
    return
} 
else 
{
    ;MsgBox, "explorer.exe is not active"
    send ^+u
    return
}

^+Esc::
if WinExist("ahk_exe perfmon.exe")
    WinActivate, ahk_exe perfmon.exe
else
    Run, "C:\Windows\System32\perfmon.exe" /res
return


!l::
; Activate an existing notepad.exe window, or open a new one
if WinExist("ahk_exe Listary.exe")
    WinActivate, ahk_exe Listary.exe
else
    Run, "C:\Program Files\Listary\Listary.exe"
return
Listary.exe

:*:/ip::172.16.20.85

:*:/128::192.168.187.128


;:*:@z::z1011014{tab}1011014{enter}

; Force a reboot (reboot + force = 2 + 4 = 6):
>^>!+Del::Shutdown, 6

!+F4::
;Process, Exist, opera.exe
;if (%ErrorLevel%<>0)
;    MsgBox, 我就是进程的pid %ErrorLevel%
WinGet, active_id, PID, A
run, taskkill /PID %active_id% /F,,Hide
return



; Opens the command shell 'cmd' in the directory browsed in Explorer.
; Note: expecting to be run when the active window is Explorer.
;
OpenCmdInCurrent()
{

    full_path:=getCurrentPath()
    IfInString full_path, :\
    {
        Run,  cmd /K cd /D "%full_path%"
    }
    else
    {
        Run, cmd /K cd /D "C:\"
    }
}

ExecuteCmdInCurrent(commond)
{

    full_path:=getCurrentPath()
    MsgBox, %full_path%,%commond%
    IfInString full_path, :\
    {
        Run,  cmd /C cd /D "%full_path%" & %commond% & pause
    }
    else
    {
        Run, cmd /C cd /D "C:\" & %commond% & pause
    }
}

ExecuteCmdInCurrentPause(commond)
{

    full_path:=getCurrentPath()
    ;MsgBox, %full_path%,%commond%
    IfInString full_path, :\
    {
        Run,  cmd /C cd /D "%full_path%" & %commond% & pause
    }
    else
    {
        Run, cmd /C cd /D "C:\" & %commond% & pause
    }
}

getCurrentPath()
{
    ; This is required to get the full path of the file from the address bar
    WinGetText, full_path, A

    ; Split on newline (`n)
    StringSplit, word_array, full_path, `n
    ; Take the first element from the array
    full_path = %word_array1%   

    ; strip to bare address
    full_path := RegExReplace(full_path, "^地址: ", "")
    full_path := RegExReplace(full_path, "^Address: ", "")

    ; Just in case - remove all carriage returns (`r)
    StringReplace, full_path, full_path, `r, , all

    IfInString full_path, :\
    {
        return full_path
    }
    else
    {
        return "C:\"
    }
}

