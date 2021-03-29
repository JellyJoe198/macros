## Numpad Hotkeys
This macro adds more functionality to my numpad, such as opening and closing browser tabs, copy/paste, ctrl z/y, music controls, and typing letters through keycodes (will be thumbscript in future version). For a full list of the included macros, see the `.ahk` file.<br>
The layout of my numpad is shown below.

<img src="https://github.com/JellyJoe198/python-macros/blob/master/AutoHotkey/Numpad%20layout.png?raw=true" alt="numpad layout" width="300"/>

Note: I am currently working on a system that lets you customize your macros through AutoHotkey's GUI system.

### alt codes hotstrings.py
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

Note: ThumbScript will be implemented in a future version for typing letters by shape. http://thumbscript.com/howitworks.html

## quotes and commas
this is related to Python and coding faster, like making a quoted list from just a bunch of characters. Example:  
`abcdefghijklmnopqrstuvwxyz`  
goes to  
`'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',`

## AutoHotkey.xml
This is my style sheet for editing AHK in Notepad++ (doesn't have all keywords yet)
