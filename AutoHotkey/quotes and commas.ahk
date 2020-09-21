#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.


CapsLock::
loop 26
Send '{right}',
return

^CapsLock::
loop 26
Send {Delete}{Down}
return

; !CapsLock::
; loop 26
; Send {BS}{Left 2}
; return

