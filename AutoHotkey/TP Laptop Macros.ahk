#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; AHK program
^+CapsLock::Reload
CapsLock::CapsLock

^CapsLock::Send {Tab 3}
;+CapsLock::Send {Shift down}{Tab 3}{Shift up}
+CapsLock::Send {Ctrl down}{F5}{Ctrl up} ;clion run program

;temp for numpad with space
;Enter::Space

; should I add Tab shortcut with shift?
; https://github.com/JellyJoe198/macros/blob/master/Tab%20when%20Shft%20pressed%20with%20hold%20cancel.py

; windows
^+w::Send !{F4} ;close window

;PrintScreen & l::Send {blind} #l
PrintScreen & l::DllCall("LockWorkStation")  ;https://www.autohotkey.com/boards/viewtopic.php?t=69537

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

PrintScreen::
Send {PrintScreen}
CtrlWait()
return

^PrintScreen::AppsKey ;context menu - simulated rightclick

; hotkeys to move windows within the screen
PrintScreen & Up::
SendEvent {blind}{RWin down}{Up}{RWin up} ; send keys
CtrlWait()  ; allow ctrl to exit the selection menu after
SendEvent {PrintScreen up} ; release prtscrn to avoid ghost bugs
return

PrintScreen & Down::
SendEvent {blind}{RWin down}{Down}{RWin up}
CtrlWait()
SendEvent {PrintScreen up}
return

PrintScreen & Left::
SendEvent {blind}{RWin down}{Left}{RWin up}
CtrlWait()
SendEvent {PrintScreen up}
return

PrintScreen & Right:: 
SendEvent {blind}{RWin down}{Right}{RWin up}
CtrlWait()
SendEvent {PrintScreen up}
return


RShift & PgDn:: Send ^v
RShift & PgUp:: Send ^c

NumpadClear & NumpadHome:: ^Home
NumpadClear & NumpadEnd:: ^End

; super operators
RShift & NumpadDiv:: Send {`%}
RShift & NumpadMult:: Send {^}
RShift & NumpadAdd:: Send {&}
RShift & NumpadSub:: Send {,}

;RShift & Backspace:: Send {blind}{RShift up}{Del}
RShift & Backspace:: Send {Tab}

; C++ coding macros.
; <+Shift::MsgBox hi  ; LShift and RShift::hi.  doesn't work with & operator. look up: 3 key hotkeys
RShift & <::<<
RShift & >::>>

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


;special macros
;remove `view-source:` from address bar.
RCtrl & M::
Send !d
Sleep 50
Send {left}
Sleep 50
Send {delete 12}
Sleep 50
Send {enter}
return



/*	ThumbScript area
	a hotkey will initialize a textbox where user can type in numpad ThumbScript.
	then a key to escape that textbox and paste the typed stuff.
*/

