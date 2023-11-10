#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; plugin syntax: all external ahk files called from this program shall start with `P_`

; AHK program
^+CapsLock::Reload
CapsLock::CapsLock

/*
; special shortcuts
^CapsLock::Send {Tab 3}
;+CapsLock::Send {Shift down}{Tab 3}{Shift up}
!CapsLock::Send {Tab 8}
!+CapsLock::Send {Shift down}{Tab 8}{Shift up}
*/

; 383 Embedded Systemes: open COM Sniffer and Putty
^!p::
run "C:\Users\jelly\OneDrive\Documents\Mines 2023F\383 - Embedded Systems\COMSniffer.exe"
;Sleep 1200
WinWait, COM Sniffer
run "C:\Users\jelly\OneDrive\Documents\Mines 2023F\383 - Embedded Systems\PuTTY"
sleep 1000
Send !r
sleep 50
Send +{tab 2}
sleep 50
Send {right}{backspace}8
KeyWait, Enter, D T5
if ErrorLevel
 return
WinClose, COM Sniffer
return

; shortcut to run program if in Clion, IDLE, etc.
#IfWinActive ahk_exe pythonw.exe
+CapsLock::Send {F5}


#IfWinActive ahk_exe Obsidian.exe

; Obsidian.md change #tag to [[link]]
^CapsLock::
Send {del}
Sleep 50
Send ^+{right}
Sleep 50
Send {[ 2}
return

; Obsidian.md text expander for page break
:*:pgbreak::
Send {enter}
Send {<}div style{=}{"}page-break-after: always{;}{"}{>}{<}{/}div{>} 
Send {enter}
Send {enter}
return

:*:hidesec::<details>
:*:shidesec::</details>


#IfWinActive ahk_exe MATLAB.exe
+CapsLock::Send {F5}
;dock figure
~!d:: ;Send !d
Sleep 50
Send {down}{space}
return

#IfWinActive ahk_exe clion64.exe
+CapsLock::Send {Ctrl down}{F5}{Ctrl up} ; clion re-run program

#IfWinActive ahk_exe VSCodium.exe
+CapsLock:: Run P_VSCodiumRunCode.ahk
!e::Send exit
#If

#IfWinActive ahk_exe SLDWORKS.exe
; solidworks save as STL shortcut
+CapsLock::Run P_SolidWorks_STL.ahk
; override alt v hotkey used elsewhere
~!v::return

#IfWinActive ahk_exe infinifactory.exe
; infinifactory alternate
CapsLock::
Loop 7
{
Send {LButton}  
Sleep 30
Send {Click WU}
Sleep 30
Send {LButton}
Sleep 30
Send {Click WD}
Sleep 30
}
return

#If

;/*** general ***/

; windows
^+w::Send !{F4} ;close window
PrintScreen & -::Send {blind}^w

; copy paste
RShift & PgDn:: Send ^v
RShift & PgUp:: Send ^c
RShift & PrintScreen:: Send ^a

; switch tabs (alternate)
PrintScreen & PgUp:: AltTab
PrintScreen & PgDn:: shiftAltTab

; super operators
RShift & NumpadDiv:: Send {`%}
RShift & NumpadMult:: Send {^}
RShift & NumpadAdd:: Send {&}
RShift & NumpadSub:: Send {_}
RShift & NumpadEnter:: Send {,}
NumpadPgDn::
if( GetKeyState("NumLock", "T") ) {
  Send {blind}3 ;#
} else {
  Send {PgDn}
}
return
NumpadPgUp::
if( GetKeyState("NumLock", "T") ) {
  Send {blind}4
} else {
  Send {PgUp}
}
return


NumpadClear:: Send {space}
;NumpadClear:: Send {RShift up}{s} ;requires releasing RShift to start again
;NumpadClear:: Send {RShift up}{s}{RShift down} ;can keep going forever but more buggy

RShift & Backspace:: Send {Tab}
RShift & Del:: Send {blind}{Tab}




; change screen brightness more precisely
!F5::
  AdjustScreenBrightness(-3)
return

!F6::
  AdjustScreenBrightness(3)
return

AdjustScreenBrightness(step) {
    service := "winmgmts:{impersonationLevel=impersonate}!\\.\root\WMI"
    monitors := ComObjGet(service).ExecQuery("SELECT * FROM WmiMonitorBrightness WHERE Active=TRUE")
    monMethods := ComObjGet(service).ExecQuery("SELECT * FROM wmiMonitorBrightNessMethods WHERE Active=TRUE")
    minBrightness := 0  ; level below this is identical to this

    for i in monitors {
        curt := i.CurrentBrightness
        break
    }
	; ensure brightness stays within valid range
    if (curt < minBrightness)
        curt := minBrightness
    toSet := curt + step
    if (toSet > 100)
        return
    if (toSet < minBrightness)
        toSet := minBrightness

	; set brightness on all monitors
    for i in monMethods {
        i.WmiSetBrightness(1, toSet)
        break
    }
}
return

;https://www.autohotkey.com/boards/viewtopic.php?t=69537
;PrintScreen & l::Send {blind} #l
;PrintScreen & l::DllCall("LockWorkStation")  


;/** Window position manipulation with PrtScr **/

SetKeyDelay, 5  ;using delay and SendEvent to slow down keystrokes for windows menus (to prevent visual fragmenting bug)
TIMEOUT := "T1" ;the following KeyWaits have timeout and throttle of 1 second. BUG: waits infinite time
CtrlWait() {
	; wait for multiple keys to have temporary hotkeys:
	; https://www.autohotkey.com/docs/commands/Hotkey.htm
	; or https://www.autohotkey.com/board/topic/101970-keywait-for-either-one-of-two-keys/
	
	;for TIMEOUT seconds it waits for Ctrl:
	KeyWait, RCtrl, D %TIMEOUT%
	if ( ErrorLevel == 0 ){
		SendEvent, {esc} ;Esc gets back to normal window view after pressing win left.
	}
	return
}

#MaxThreadsPerHotkey 6 ; allow PrtSc commands to work 6 times without CtrlWait
PrintScreen up::
Send {PrintScreen}
CtrlWait()
return

^PrintScreen::AppsKey ;context menu - simulated rightclick

; hotkeys to move windows within the screen
; arrows (up,down,left,right) have ~ to let through to avoid ghost PrintScreen bug.
;  todo: kill ghost bug by setting timeout if PrintScreen has been held too long.
PrintScreen & ~Up::
SendEvent {blind}{RWin down}{Up}{RWin up} ; send keys
CtrlWait()  ; allow ctrl to exit the selection menu after
SendEvent {PrintScreen up} ; release prtscrn to avoid ghost bugs
return

PrintScreen & ~Down::
SendEvent {blind}{RWin down}{Down}{RWin up}
CtrlWait()
SendEvent {PrintScreen up}
return

PrintScreen & ~Left::
SendEvent {blind}{RWin down}{Left}{RWin up}
CtrlWait()
SendEvent {PrintScreen up}
return

PrintScreen & ~Right:: 
SendEvent {blind}{RWin down}{Right}{RWin up}
CtrlWait()
SendEvent {PrintScreen up}
return

#MaxThreadsPerHotkey 1 ; end prtSc multi thread


;/** special **/

; calculator toggle
PrintScreen & =::
ToggleCalculator() {
  if WinExist("Calculator","Calculator") {    ; if calculator open ...
    if WinActive("Calculator","Calculator") { ; ... and active: close it.
      WinClose
    } else {                            ; ... and inactive: switch to it.
      WinActivate
    }
  } else { ; otherwise start calculator
      Run calc
  }
  return
}
return

; C++ coding
RShift & <::<<
RShift & >::>>
RShift & |::Send {|}{|} ; ||
; ::thss::this->

;volume control
;RShift & (:: Volume_Down  ;disabled for now bc it prevents typing brackets.
;RShift & ):: Volume_Up
/*SC00D::  ; equals sign, using ScanCode for reliability? still not working properly.
 KeyIsDown := GetKeyState(RShift , T)
 if (KeyIsDown != 0) {
   Send {Volume_Mute}
 } else {
   Send {=}
 }
return
*/

;/** web browser tasks **/

;remove `view-source:` from address bar.
PrintScreen & M::
Send !d
Sleep 50
Send {left}
Sleep 50
Send {delete 12}
Sleep 50
Send {enter}
return

; add row/column to excel/google sheets
!a::
Send {RButton}
Sleep 50
Send {Down 5}
Sleep 50
Send {Enter}
Sleep 50
return

; shortcut to references folder
::!ref::
run "C:\Users\jelly\Desktop\reference"
return

