"""This program decreases Windows volume by a certain amount after a certain key is pressed,
   then brings it back up after a certain time or after a certain button is pressed.
   You can also press another button to bring up the console dialogue to change the amount.
   Also it exits if a different certain key is pressed.
   These keys can be seen in veriables: `exit_key` `down_key` `up_key` `change_key`
"""

import time
##import pyautogui
##print(pyautogui.KEYBOARD_KEYS)
from pyautogui import press
from pynput.keyboard import Listener, Key, KeyCode

##import logging
import threading
event = threading.Event

##times = 4
# start by asking user how far to go each time
def change_times():
    # ask for user input and strip noise characters to get number
    global times
    try:
        gotten = input("how many times to change? ")
        times = int(gotten.strip('*/-'))
    except:
        print("there was a problem with your input. times set to 4")
        times = 4
##    print('times = {}'.format(times))
change_times()
##print('global times = {}'.format(times))

lowered = False
def downer(delay=1):
    global lowered
    if lowered:
        return
    # go down
    print("going down")
    lowered = True
    for i in range(times):
        press('volumedown')
        # wait every 6th time to stop windows from skipping volume numbers
        if not (i+1)%6:
##            print("modulus active on i={}".format(i))
            time.sleep(.2)
    
    # wait by making a new thread to free up this thread for new inputs
    x = threading.Thread(target=thread_function, args=(1,delay))
    x.start()
    # x.join() 

def thread_function(name, delay):
##    logging.info("Thread %s: starting", name)
    time.sleep(delay)
##    logging.info("Thread %s: finishing", name)
    # go back up
    uppinator()

def uppinator():
    global lowered
    if lowered:
        lowered = False
        print("going up")
        for i in range(times):
            press('volumeup')

exit_key = KeyCode(192) # '~' is 192, Esc is 27 or Key.esc
down_key = KeyCode(111)#'/'
up_key = KeyCode(106)#'*'
change_key = KeyCode(109)#'-'

def on_press(key):
    if key == exit_key:
        listener.stop()
        global running
        running = False
        print("stopped by user\n",end='')
    elif key == down_key:
        downer(90)
    elif key == up_key:
        uppinator()
    elif key == change_key:
        change_times()
    # i want to be able to update the times var based on user changing volume,
    # but that could lead to unintended consequences.


# put this thread inside a try function to keep parent thread alive
running = True
try:
    #Collect events in a non-blocking fashion:
    listener = Listener(
        on_press=on_press)
    listener.start()
    print("program started")
    # wait untill child thread dies
    while True:
        if not running:
            break
finally:
    listener.stop() # retroactively kill child thread
    print('parent thread ended\n',end='')
