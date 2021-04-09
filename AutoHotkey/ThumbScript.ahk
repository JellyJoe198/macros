; Thumbscript By Conquer http://thumbscript.com/howitworks.html
; AHK script based on https://autohotkey.com/board/topic/27198-beta-thumbscript-ahk/
; improved by [Joseph Brownlee](http://github.com/jellyjoe198)

#NoEnv
#SingleInstance,Force
FileEncoding UTF-8
SendMode,Input
SetKeyDelay,-1

gosub BuildList  ; Assign all the letters to variables for later

keys=0
Caps = false

CapsTip = True  ; Show traytip when toggling caps state
TipDelay = 1000 ; Milliseconds to show traytip for

Numpad1::NumCom(1)
Numpad2::NumCom(2)
Numpad3::NumCom(3)
Numpad4::NumCom(4)
Numpad5::NumCom(5)
Numpad6::NumCom(6)
Numpad7::NumCom(7)
Numpad8::NumCom(8)
Numpad9::NumCom(9)
;NumPad0::Space
;NumPadSub::Backspace

CapsLockToggle:
;NumpadAdd::
disp := Caps("Toggle")
If CapsTip = True
{
  Traytip,Thumbscript,%Disp%,10,1
  SetTimer,TrayTipClear,%TipDelay%
}
return

TrayTipClear:
SetTimer,TrayTipClear,Off
TrayTip
return

Caps(state)  
; Caps(On/True)|Caps(Off/False)|Caps(Toggle)
{
  global
  if state = toggle
  {
    if caps = true
    {
      caps = false
      return "caps"
    }
    if caps = false
    {
      caps = true
      return "CAPS"
    }
  }
  if state = on
    state = true
  if state = off
    state = false
  Caps = %State%
  If Caps = True
    return "CAPS"
  Else If Caps = False
  return "caps"
}

NumCom(key)
{
  global
  keys += 1
  If Keys < 3
    keeptrack=%keeptrack%%key%
  ;Msgbox %Keys%/%Key%`n%Keeptrack%`n%Char%
  If Keys > 1
    gosub SetKey
  return
}

SetKey:
;Tooltip Com: %Keeptrack%`n`nChar: %Char%
;sleep 1000
;ToolTip

Char := Char%KeepTrack% ; sets Char to reference Char## (characters at bottom)

/*
If ( Char = "{Enter}" or Char = "." )
  CapsSet = 1   ; (For Mode 3) Time to use a new capital
WinGetActiveTitle,CurrentWin
If CurrentWin <> %OldWin%
{
  CapsSet = 1   ; (For Mode 3) New window is active, so use a capital
  OldWin := CurrentWin
}
*/
If Caps = True
  StringUpper,Char, Char
If Caps = 3
{
  Char := Char%KeepTrack%
  If ( CapsSet = "True" or CapsSet = "3" )
    StringUpper, Char, Char
  If CapsSet = 1  ; Capital for beginning of sentence
    Capset = 0
}
;return

Send:
If Char = CapsLockToggle
{
  GoSub CapsLockToggle ;toggle caps setting then continue here
  goto Cleanup
}
If Char =  ; Invalid combo, clean up the com
  goto Cleanup
Send %Char%
;goto Cleanup
;return
Cleanup: ;clear the variables
~NumPadDiv:: ;slash will clean keys but ~ lets slash through.
keeptrack=
keys=0
Char =
return

BuildList:
; Letters, all on the outer 9 pad target
; Vowels all cross the middle in an unbent line
Char13 = a
Char83 = b
Char93 = c
Char81 = d
Char91 = e
Char92 = f
Char96 = g
Char43 = h
Char82 = i
Char84 = j
Char89 = k
Char86 = l
Char12 = m
Char42 = n
Char46 = o
Char74 = p
Char76 = q
Char23 = r
Char63 = s
Char62 = t
Char73 = u
Char78 = v
Char79 = w
Char71 = x
Char72 = y
Char41 = z

; Commands: 
; Single Tap (Planned feature) or Double tap to use
;Char1 = ,
Char11 = ,
;Char2 = {space}
Char22 = {space}
;Char3 = .
Char33 = .
;Char4 = {Tab}
Char44 = {Tab}
;Char6 = {Enter}
Char66 = {Enter}  ; Note that Numpad Enter also works.
;Char7 = {ctrl}
;Char77 = {ctrl}  ; Note: this will require more logic to be functional
;Char8 = CapsLockToggle
Char88 = CapsLockToggle ; uses special check for CapsLockToggle
;Char9 = {BackSpace}
Char99 = {BackSpace}

; Numbers:
; Start by pressing 5 then press 
; the number you want to type
; Note that this is different then the normal Thumpad's method. swapped post download
; Char05 = 0
Char15 = 1
Char25 = 2
Char35 = 3
Char45 = 4
Char55 = 5
Char65 = 6
Char75 = 7
Char85 = 8
Char95 = 9
Char64 = 0 
; Backwards combo of O (letter) produces 0 if you hate using the 0 button
; also include backwards
Char51 = {!}
Char52 = @
Char53 = {#}
Char54 = $
;Char55 = 5
Char56 = {^}
Char57 = &
Char58 = *
Char59 = `%

; Symbols:
Char31 = _
Char39 = (
Char18 = ?
Char19 = /
Char29 = {`{}
Char69 = <
Char28 = |
Char48 = =
Char98 = '
Char68 = {+}
Char21 = ~
Char24 = ]
Char47 = >
Char67 = {ESC}
Char32 = -
Char36 = :
Char26 = [
Char37 = \
Char87 = {``}
Char97 = {"}
Char17 = )
Char27 = {`}}
Char14 = `;

; unofficial shortcuts
Char38 = ¿ ;mirror of 18? is 38¿
Char34 = {space}
Char16 = ?authuser=1 ;switch google user
Char61 = `%2B ;plus sign
return
