## movement detector macro
This is a macro  designed to make mining large areas in Minecraft easier.
To use, Minecraft player must be facing exactly at -0.0 or 90.0 and point straight up, and hold the mining button (can be done in 1.16 with the F3 + T trick).
Currently the best way to pause it is to press F3 because the program will detect changes in the numbers (memory, particles, ect) and not move.
The mask_vertices file contains the regions on the screen that will be considered in determining if the screen is changing;
It is designed for a 800x600 window in the center of my 1920x1080 monitor, so you may have to change the numbers around for different sized monitors.

### Speed
It takes about 25 minutes for this to mine 1 full layer of one 16x16 chunk (this means 5 automatic layers, user must prepare first 2 layers so this can move through them).
That estimate is not including time lost from items getting stuck (it may freeze if it sees a moving item), and does not account for gravel falling and moving the player's position.

### How it works
It reads the screen, applies a mask to prioritize certain regions, then if there is no change in the screen for a certain amount of time/frames
it will press `a` or `s` to move left or right, and if it doesn't change after that it means the player is on a wall, so it moves forward 1 block (presses `w`) and cahnges direction.

