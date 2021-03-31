#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; This is designed to be a plugin for other AHK scripts.
; When run, it uses a dialogue box to let user choose how long to wait before the program sends a click.
;capslock::
InputBox, delay,, Input the delay in minutes to wait before automatic click.`nEnter 0 (zero) for more options (currently exits).`nPress Cancel or Escape to exit.,,,,,,,,4.5 ; default to 4.5 minute

if ErrorLevel { ; if timeout or cancelled, exit program.
    Exit
} else if (delay) {
    Sleep % (delay*60000) ; convert minutes to miliseconds
    Send {Lbutton}
} else
    MsgBox program will exit.
    Exit
;return