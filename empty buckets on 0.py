##on press of 0 (numpad zero) it will press 9, click,  8 click, so on to 3
##https://pypi.org/project/pynput/

import time
import threading
from pynput.mouse import Button
from pynput.mouse import Controller as mouseController
from pynput.keyboard import Listener, KeyCode, Key
##from pynput.keyboard import Controller as keyboardController

from defaultCommands import tripleClick, pressKey

button = Button.right
button_l = Button.left
exit_key = Key.esc # stop when Escape pressed
start_stop_key = KeyCode(96) # 96 = Numpad0 (Zero)
repeats = 9 # how many times will it repeat? (how many buckets to empty?)
inventory_key = 'e' # key to open inventory
hotbar_key = '2' # hotbar slot to use

delay = .05
start_delay = .2
middle_delay = .2

def wait(seco = delay):
    time.sleep(seco)

def clicky(but=button):
##    print('click')
    mouse.click(but)
    wait(.01)

def on_press(key):
    if key == exit_key:
        listener.stop()
        global running
        running = False
        print("stopped by user\n")
    elif key == start_stop_key:
        print('macro started')
        wait(start_delay)
        for i in range(repeats):
            mouse.scroll(0,-2)
            wait()
            clicky()
            wait()
        # As of now it has emptied buckets and will do inventory part next.
##        print('done part 1')
        wait(start_delay)
        pressKey(inventory_key)
        pressKey(hotbar_key) # take a bucket from hotbar
        tripleClick(.05) # take all buckets
        wait()
        pressKey(hotbar_key) # put the buckets back in hotbar
        wait()
        pressKey(inventory_key) # exit inventory
        print('macro finished\n')

mouse = mouseController()

# put this thread inside a try function to keep parent thread alive
running = True
try:
    #Collect events in a non-blocking fashion:
    listener = Listener(
        on_press=on_press)
    listener.start()
    print("program started")
    while running:
        if False:
            print("your computer is broken")
finally:
    print('parent thread ended\n')
