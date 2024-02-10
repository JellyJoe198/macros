General note: I would not earnestly reccomend anyone to use these hotkeys exactly as they are. These are shared so that you can learn from them and create scripts that suit your own needs. If you have questions about any of these scripts or need help setting up your own script, please reach out. I'm happy to help.  

Future project idea: I am interested in a program that lets you customize your macros through a GUI. This could be programmed entirely within AutoHotkey with the built-in dialogue boxes, but it would take a lot of time to get right.   

## Numpad Hotkeys
This macro adds more functionality to my numpad, such as opening and closing browser tabs, copy/paste, ctrl z/y, music controls, and typing letters through Thumbscript (previously unicode). For a full list of the included hotkeys, see the `.ahk` file.<br>
The layout of the intended numpad is shown below.

<img src="/AutoHotkey/Images/Numpad%20layout.png?raw=true" alt="numpad layout" width="300"/>

You can disable ThumbScript by pressing `NumpadIns & Esc`, or by removing the `Thumbscript.ahk` file from your copy.

## Thumbscript.ahk
http://thumbscript.com/howitworks.html  
<img src="http://thumbscript.com/images/abcd.gif" alt="ABCD Thumbscript example" height=50></img>

ThumbScript is a typing system that allows you to press any letter by drawing its shape with 2 presses on the numpad.  
This is my improved version of the [beta thumbscript autohotkey script](http://autohotkey.com/board/topic/27198-beta-thumbscript-ahk). I added a few commands that were indicated on the [thumbscript wiki](http://thumbscript.com/howitworks.html) but not the beta script.  
I also added a few unofficial shortcut keys:  

Keys   |  character     | note | purpose  
--     |  --            | -- | --
Char38 | `¿`            |  mirror image of `?`, reversed `b`  
Char34 | `{space}`      |  reversed `h` | redundant by Char22 but this evens out key wear.  
Char16 | `?authuser=1`  | mirrored `h` | Google switch accounts  
Char61 | `%2B`          | mirrored and reversed `h` | html plus sign  

Note: the mirror of `h` and `q` are unused combinations. They could be used as special characters in other languages or as hotkeys.

Functions not yet implemented:  
* single tap commands (for now just double tap the key)
* Control key (currently does nothing)(I plan to make it behave like ctrl+letter, which is different from the website but IMO more useful for desktop use)

## alt codes hotstrings.py
**Depricated. Using Thumbscript instead.**  
I used Python to generate the hotstrings for typing letters and characters by inputting the alt code preceded by `00`, or `0000` for capital letters (I switched the lowercase letters to 65-90 bc they are used more). This feature has the first 255 unicode windows alt codes.  
Note: Some characters require an end character such as `.` or `enter` in order to allow 3 digit alt codes as well. May require UTF-8 to correctly show emojis. Examples below.  

Input | character  
-- | --
`0038` | `&`  
`001.` | `☺`  
`0025.` | `↓`  
`00159` | `ƒ`  
`0069` | `e`  
`000069` | `E`  

There are also some pictures to help you with the windows alt codes, titled `unicode guide ... .png`. Choose the version that suits you better, and if you like them you could even set it as your desktop for easy reference.

## quotes and commas
this is related to Python and coding faster, like making a quoted list from just a bunch of characters. Example:  
`abcdefghijklmnopqrstuvwxyz`  
goes to  
`'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',`

## AutoHotkey.xml
This is my style sheet for editing AHK in Notepad++ (doesn't have all keywords yet)
