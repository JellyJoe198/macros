﻿; This macro set [GitHub link](https://github.com/JellyJoe198/macros/tree/master/AutoHotkey) is designed to be used with an external numpad, like [this link](https://www.amazon.com/Bluetooth-Rechargeable-Jelly-Comb-Shortcuts/dp/B07PTCDXBH/)
; a few of these may seem weird but this is just what I found useful. I tried to keep the hotkeys similar in location to a standard keyboard, but had to keep full Numpad fuctionality.

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
;SendMode InputThenPlay
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force ; Close previous instance when new instance starts.
#Keyhistory 40 ; How many keystrokes to store in the history.

; ^ = Ctrl
; + = Shift
; ! = Alt
; # = Windows
; ~ lets key through while activating macro.
; * wildcard - other keys do not affect it

TyperName := "ThumbScript"
Try {
    TyperFile := "ThumbScript.ahk"
} catch erro {
    MsgBox, There was an issue with finding the typer script:`n%erro%
}
Run, %TyperFile%

TypeSuspended = False
Sleep 200
GoTo SuspendTyper1
;return

/*
OnExit(KillThumbScript())
KillThumbScript()
{
    WinClose %TyperFile% - AutoHotkey
}
*/

SuspendTyper()
{
    ;from the help docs
    DetectHiddenWindows, On
    WM_COMMAND := 0x111
    ID_FILE_SUSPEND := 65404
    PostMessage, WM_COMMAND, ID_FILE_SUSPEND,,, %TyperName% ahk_class AutoHotkey
    TypeSuspended := !TypeSuspended
}

#InputLevel 0 ; using input levels to make these modifiers work outisde of hotkeys, not working yet. lower numbers are higher precedence?
; these all have issues with not affecting the scripts below it.
NumpadClear:: Ctrl
NumpadIns:: Shift
NumpadDel:: Alt

;NumpadIns:: Space

NumpadCompensate:
NumpadIns & Esc:: ; set numlock to current state of external numpad. (compensating for lack of toggle)
Numpad0 & Esc:: 
state := GetKeyState("NumLock", "T")
GoSub SuspendTyper1
keywait, Esc, T2
Sleep 200
SetNumLockState %state%
return

SuspendTyper1:
Suspend
SuspendTyper()
;TypeSuspended := !TypeSuspended
Sleep 200
Suspend Off
return
Numpad0:: Numpad0

CapsLock:: ; will be the menu system to toggle certain features in the future. For now it activates a plugin.
Suspend ;suspend other hotkeys while this subprogram runs. (Not actually necessary just cleaner)
if !TypeSuspended
    SuspendTyper()
RunWait, % A_WorkingDir . "\plugins\wait to click.ahk"
;, , UseErrorLevel

;MsgBox, Plugin ended with code %ErrorLevel%
/*
WaitingprogramLabel: ;if the subroutine "wait to click" is open, stay in this loop. openFold
loop 2 { ; repeat twice to avoid accidental errors
    Sleep 1000
    if WinExist("wait to click")
        GoTo WaitingprogramLabel
} ; closeFold
*/
Reload
Sleep 1000
ExitApp 1 ;if failed to reload, close app.
return

;Numpad0::Numpad0  ; uncomment to disable hotstrings

*^q:: Send !+5  ; ctrl q = ctrl alt 5  for strikethrough in google docs.

#InputLevel 1
; browser commands
NumpadClear & Esc:: Send ^w
NumpadClear & NumpadPgUp:: Send {blind}^t
NumpadClear & Tab:: Send {blind}^{tab}
NumpadClear & NumpadAdd:: Send {blind}^{+} ; zoom in
NumpadClear & NumpadSub:: Send {blind}^{-} ; zoom out
NumpadClear & NumpadPgDn:: ^r

NumpadDel & NumpadLeft:: Send !{left} ; webpage back
NumpadDel & NumpadRight:: Send !{right} ; webpage right

NumpadIns & NumpadPgDn:: ^f
NumpadIns & NumpadPgUp:: Send {F6} ;!d ; go to address bar in chromium
; NumpadIns & NumpadPgUp:: Send {blind}+^t  ; ctrl+shift+t is redundant

NumpadIns & NumpadEnter:: Send +{enter}  ; mostly for the find menu

; text editing commands

NumpadClear & (:: Send ^z
NumpadClear & ):: Send ^y
NumpadClear & $:: Send ^s
NumpadClear & =:: Send ^x ; cut
NumpadClear & NumpadDiv:: Send {blind}^c ; copy
NumpadClear & NumpadMult:: Send {blind}^v

NumpadClear & NumpadHome:: Send ^{Home} ; these shouldn't be needed but it didn't work without.
NumpadClear & NumpadEnd:: Send ^{End}
NumpadClear & NumpadRight:: Send, {blind}^{Right} ; Ctrl right
NumpadClear & NumpadLeft:: Send, {blind}^{Left} ; Ctrl left
NumpadClear & NumpadUp:: Send, {blind}^{Up} ; Ctrl Up
NumpadClear & NumpadDown:: Send, {blind}^{Down} ; Ctrl Down
; text selection. these shouldnt be needed but it didn't work without.
NumpadIns & NumpadHome:: Send +{Home}
NumpadIns & NumpadEnd:: Send +{End}
NumpadIns & Tab:: Send {blind}+{Tab}
NumpadIns & NumpadRight:: Send {blind}+{Right}
NumpadIns & NumpadLeft:: Send {blind}+{Left}
NumpadIns & NumpadDown:: Send {blind}+{down}
NumpadIns & NumpadUp:: Send {blind}+{up}
NumpadClear & Backspace:: Send {blind}^{Backspace}
NumpadClear & Del:: Send {blind}^{Del}

NumpadDel & Esc:: Send !{F4} ; close the window
NumpadDel & Tab:: AltTab

; make app button toggle calculator instead of open new.
Launch_App2::
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

/*; math (conflict: window size)
NumpadDel & NumpadUp:: Send {^} ; power sign
NumpadDel & NumpadPgUp:: Send pi
NumpadDel & NumpadDown:: Send {x}
NumpadDel & NumpadPgDn:: Send {y}
*/

; window size
NumpadDel & NumpadUp:: Send #{up}
NumpadDel & NumpadPgUp:: Send #{right}
NumpadDel & NumpadDown:: Send #{down}
NumpadDel & NumpadPgDn:: Send #{left}

NumpadDel & NumpadEnd:: Send ^#{left}
NumpadDel & NumpadHome:: Send ^#{right}

/*; bracket shortcuts
NumpadIns & $:: Send {:} ; colon :
NumpadIns & (:: Send {`{} ; left curly bracket {
NumpadIns & ):: Send {`}} ; right curly bracket }
; alternate bracket shortcuts
NumpadIns & $:: Send {`;} ; semicolon ;
NumpadIns & (:: Send {`[} ; left bracket [
NumpadIns & ):: Send {`]} ; right bracket ]
*/

; music
NumpadDel & =:: Send {Media_Prev}
NumpadDel & NumpadDiv:: Send {Media_Play_Pause}
NumpadDel & NumpadMult:: Send {Media_Next}
NumpadDel & (:: Send {Volume_Down}
NumpadDel & ):: Send {Volume_Up}
NumpadDel & $:: Send {Volume_Mute}
#If WinActive("Spotify") ; openFold spotify: navigate ±15 sec
  NumpadDel & NumpadLeft:: Send ^+{left}  ; ctrl shift left
  NumpadDel & NumpadRight::Send ^+{right}

#If WinExist("ahk_class Winamp v1.x") ; endFold openFold WinAmp
; the WinExist above has set the "last found" window for use below.
NumpadDel & =:: ControlSend, ahk_parent, z  ; back
NumpadDel & NumpadDiv:: ControlSend, ahk_parent, c  ; Pause/Unpause
NumpadDel & NumpadMult:: ControlSend, ahk_parent, b  ; next
NumpadDel & Backspace:: ControlSend, ahk_parent, ^v  ; stop after current track
#If ; endFold WinAmp

; mouse
NumpadIns & ,:: LButton ; click
NumpadDel & ,:: AppsKey ; context menu (simulated right click)


:*:]p::
FormatTime, CurrentDateTime,, yy.MM.dd ; 19.02.13
SendInput %CurrentDateTime%
return

:*:]o::
FormatTime, CurrentDateTime,, MM/dd/yyyy ; 9/1/2005
SendInput %CurrentDateTime%
return

:*:]i::
FormatTime, CurrentDateTime,, HH:mm ; 15:53
SendInput %CurrentDateTime%
return


:*:]w::  ; This hotstring replaces "]t" with current date and time.
FormatTime, CurrentDateTime,, MM/dd/yyyy HH:mm ; 9/1/2005 15:53
SendInput %CurrentDateTime%
return

:*:]q::  ; This hotstring replaces "]q" with the current date in words.
FormatTime, CurrentDateTime,, MMMM d  ; September 4
SendInput %CurrentDateTime%
return

; the next section is hotstrings corresponding to alt codes. generated by Python, may be wrong.
/*
#Hotstring ? O ;allow other chars before, don't show endChar if used
#Hotstring EndChars .`n `t+*-/=

#Hotstring *0 ; some hotstrings must have an endChar so they don't interfere with longer hotstrings.
 ; note: brackets `{}` ensure UTF-8 formatting.
::001::{☺}
::002::{☻}
::003::{♥}
::004::{♦}
::005::{♣}
::006::{♠}
::007::{•}
::008::{◘}
::009::{○}

::0010::{◙}
::0011::{♂}
::0012::{♀}
::0013::{♪}
::0014::{♫}
::0015::{☼}
::0016::{►}
::0017::{◄}
::0018::{↕}
::0019::{‼}
::0020::{¶}
::0021::{◙}
::0022::{▬}
::0023::{↨}
::0024::{↑}
::0025::{↓}
*/

/*#Hotstring * ;hotstrings below this will not need an endChar.

::0026::{→}
::0027::{←}
::0028::{∟}
::0029::{↔}
::0030::{▲}
::0031::{▼}

::0032::{space}
::0033::{!}
::0034::{"}
::0035::{#}
::0036::{$}
::0037::{%}
::0038::{&}
::0039::{'}
::0040::{(}
::0041::{)}
::0042::{*}
::0043::{+}
::0044::{,}
::0045::{-}
::0046::{.}
::0047::{/}
::0048::{0}
::0049::{1}
::0050::{2}
::0051::{3}
::0052::{4}
::0053::{5}
::0054::{6}
::0055::{7}
::0056::{8}
::0057::{9}
::0058::{:}
::0059::{;}
::0060::{<}
::0061::{=}
::0062::{>}
::0063::{?}
::0064::{@}
*/

/*
; included shortcut: 4 zeros instead of 2 makes letter capital. You don't have to remember as many codes or do math.
;#Hotstring *
::000065::{A}
::000066::{B}
::000067::{C}
::000068::{D}
::000069::{E}
::000070::{F}
::000071::{G}
::000072::{H}
::000073::{I}
::000074::{J}
::000075::{K}
::000076::{L}
::000077::{M}
::000078::{N}
::000079::{O}
::000080::{P}
::000081::{Q}
::000082::{R}
::000083::{S}
::000084::{T}
::000085::{U}
::000086::{V}
::000087::{W}
::000088::{X}
::000089::{Y}
::000090::{Z}
::0065::{a}
::0066::{b}
::0067::{c}
::0068::{d}
::0069::{e}
::0070::{f}
::0071::{g}
::0072::{h}
::0073::{i}
::0074::{j}
::0075::{k}
::0076::{l}
::0077::{m}
::0078::{n}
::0079::{o}
::0080::{p}
::0081::{q}
::0082::{r}
::0083::{s}
::0084::{t}
::0085::{u}
::0086::{v}
::0087::{w}
::0088::{x}
::0089::{y}
::0090::{z}

;#Hotstring *
; the next characters
::0091::{[}
::0092::{\}
::0093::{]}
::0094::{^}
::0095::{_}
::0096::{`}
::0097::{A}
::0098::{B}
::0099::{C}
::00100::{D}
::00101::{E}
::00102::{F}
::00103::{G}
::00104::{H}
::00105::{I}
::00106::{J}
::00107::{K}
::00108::{L}
::00109::{M}
::00110::{N}
::00111::{O}
::00112::{P}
::00113::{Q}
::00114::{R}
::00115::{S}
::00116::{T}
::00117::{U}
::00118::{V}
::00119::{W}
::00120::{X}
::00121::{Y}
::00122::{Z}
::00123::{{}
::00124::{|}
::00125::{}}
::00126::{~}
::00127::{⌂}


::00128::{Ç}
::00129::{ü}
::00130::{é}
::00131::{â}
::00132::{ä}
::00133::{à}
::00134::{å}
::00135::{ç}
::00136::{ê}
::00137::{ê}
::00138::{è}
::00139::{ï}
::00140::{î}
::00141::{ì}
::00142::{Ä}
::00143::{Å}
::00144::{É}
::00145::{æ}
::00146::{Æ}
::00147::{ô}
::00148::{ö}
::00149::{ò}
::00150::{û}
::00151::{ù}
::00152::{ÿ}
::00153::{Ö}
::00154::{Ü}
::00155::{¢}
::00156::{£}
::00157::{¥}
::00158::{₧}
::00159::{ƒ}
::00160::{á}
::00161::{í}
::00162::{ó}
::00163::{ú}
::00164::{ñ}
::00165::{Ñ}
::00166::{ª}
::00167::{º}
::00168::{¿}
::00169::{⌐}
::00170::{¬}
::00171::{½}
::00172::{¼}
::00173::{¡}
::00174::{«}
::00175::{»}
::00176::{░}
::00177::{▒}
::00178::{▓}
::00179::{│}
::00180::{┤}
::00181::{╡}
::00182::{╢}
::00183::{╖}
::00184::{╕}
::00185::{╣}
::00186::{║}
::00187::{╗}
::00188::{╝}
::00189::{╜}
::00190::{╛}
::00191::{┐}
::00192::{└}
::00193::{┴}
::00194::{┬}
::00195::{├}
::00196::{─}
::00197::{┼}
::00198::{╞}
::00199::{╟}
::00200::{╚}
::00201::{╔}
::00202::{╩}
::00203::{╦}
::00204::{╠}
::00205::{═}
::00206::{╬}
::00207::{╧}
::00208::{╨}
::00209::{╤}
::00210::{╥}
::00211::{╙}
::00212::{╘}
::00213::{╒}
::00214::{╓}
::00215::{╫}
::00216::{╪}
::00217::{┘}
::00218::{┌}
::00219::{█}
::00220::{▄}
::00221::{▌}
::00222::{▐}
::00223::{▀}
::00224::{α}
::00225::{ß}
::00226::{Γ}
::00227::{π}
::00228::{Σ}
::00229::{σ}
::00230::{µ}
::00231::{τ}
::00232::{Φ}
::00233::{Θ}
::00234::{Ω}
::00235::{δ}
::00236::{∞}
::00237::{φ}
::00238::{ε}
::00239::{∩}
::00240::{≡}
::00241::{±}
::00242::{≥}
::00243::{≤}
::00244::{⌠}
::00245::{⌡}
::00246::{÷}
::00247::{≈}
::00248::{°}
::00249::{∙}
::00250::{·}
::00251::{√}
::00252::{ⁿ}
::00253::{²}
::00254::{■}
::00255::{ }
*/
/* ; This is Ctrl letters with 1-26
::00,01::^{a}
::00,02::^{b}
::00,03::^{c}
::00,04::^{d}
::00,05::^{e}
::00,06::^{f}
::00,07::^{g}
::00,08::^{h}
::00,09::^{i}
::00,10::^{j}
::00,11::^{k}
::00,12::^{l}
::00,13::^{m}
::00,14::^{n}
::00,15::^{o}
::00,16::^{p}
::00,17::^{q}
::00,18::^{r}
::00,19::^{s}
::00,20::^{t}
::00,21::^{u}
::00,22::^{v}
::00,23::^{w}
::00,24::^{x}
::00,25::^{y}
::00,26::^{z}
*/

/* ; and This is Ctrl letters with the same codes as above
::00,65::^{a}
::00,66::^{b}
::00,67::^{c}
::00,68::^{d}
::00,69::^{e}
::00,70::^{f}
::00,71::^{g}
::00,72::^{h}
::00,73::^{i}
::00,74::^{j}
::00,75::^{k}
::00,76::^{l}
::00,77::^{m}
::00,78::^{n}
::00,79::^{o}
::00,80::^{p}
::00,81::^{q}
::00,82::^{r}
::00,83::^{s}
::00,84::^{t}
::00,85::^{u}
::00,86::^{v}
::00,87::^{w}
::00,88::^{x}
::00,89::^{y}
::00,90::^{z}
*/


