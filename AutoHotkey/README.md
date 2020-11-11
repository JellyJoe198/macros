## Numpad Hotkeys
This macro adds more functionality to my numpad, such as opening and closing browser tabs, copy/paste, ctrl z/y, music controls, and typing letters through keycodes. For a full list of the included macros, see the `.ahk` file.<br>
The layout of my numpad is shown below.

<img src="https://github.com/JellyJoe198/python-macros/blob/master/AutoHotkey/Numpad%20layout.png?raw=true" alt="numpad layout" width="300"/>

### alt codes hotstrings.py
I used Python to generate the hotstrings for typing letters and characters by inputting the alt code preceded by `00`, or `0000` for capital letters (I switched the lowercase letters to 65-90 bc they are used more). This feature has the first 255 unicode windows alt codes.  
Note: Some characters require an end character such as `.` or `enter` in order to allow 3 digit alt codes as well.  
Examples:  
`0038` to `&`  
`001.` to `☺`  
`0025.` to `↓`  
`00159` to `ƒ`  
`0069` to `e`  
`000069` to `E`  

## quotes and commas
this is related to Python and coding faster, like making a quoted list from just a bunch of characters. Example:  
`abcdefghijklmnopqrstuvwxyz`  
goes to  
`'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',`

## AutoHotkey.xml
This is my style sheet for editing AHK in Notepad++ it has a bunch of shortcuts taken. (feel free to pull request if you fix them)
