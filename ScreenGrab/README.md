## Movement detector macro
 This is a macro  designed to make mining large areas in Minecraft easier.
To use, Minecraft player must be facing exactly at -0.0 or 90.0 and point straight up, and hold the mining button (can be done in 1.14+ with the F3 + T trick).
Run `MAIN masked movement detector.py` to start the macro, and then switch to the Minecraft tab. You could also use `OLD main basic movement detector.py` for a more basic version without masking, but it is not as reliable.
Currently the best way to pause it is to press F3 because the program will detect changes in the numbers (memory, particles, ect) and not move.  
 The mask_vertices file contains the regions on the screen that will be considered in determining if the screen is changing;
It is designed for a 800x600 window*, so you may have to change the numbers around for different sized monitors.
 *designed to be in the center of my 1920x1080 monitor, but should also work on different sized monitors.

### Requirements
* Python 3.7 or later
  - numpy 	`pip install numpy`
  - PIL 	`pip install pillow`
  - cv2 	`pip install opencv-python`
  - ctypes (built-in)
  - time (built-in)
* Minecraft (for its current use but it could be easily modified for other purposes)
* Windows computer? for screen reading api

### Speed
It takes about 25 minutes for this to mine 1 full layer of one 16x16 chunk (this means 5 automatic layers; user must prepare first 2 layers so this can move through them). It is more time efficient to mine larger areas as the program spends less time on the edges.
This estimate does not include time lost from items getting stuck (it may freeze if it sees a moving item), and does not account for gravel, water, or lava falling and moving the player.

### How it works
It reads the screen, applies a mask to prioritize certain regions, then if there is no change in the screen for a certain amount of time/frames
it will press `a` or `d` to move left or right, and if it doesn't change after that it means the player is on a wall, so it moves forward 1 block (presses `w`) and changes direction.

### Inspiration
This macro is heavily based on the GTA5 auto driver at https://pythonprogramming.net/game-frames-open-cv-python-plays-gta-v/  
and you should go there if you intend to do something similar. This program is just a simplified fork for this specific purpose.
