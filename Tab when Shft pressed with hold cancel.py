##pynput documentation:
##https://pypi.org/project/pynput/
##https://realpython.com/python-sleep/  #adding-a-python-sleep-call-with-threads
## ^^ this is another way of non blocking sleep that I decided not to use ^^

##This program listens to keyboard, and when shift is pressed it:
##presses the TAB button.
##this was designed to make canvas quizzes more erganomic

import time
##import threading
##from pynput.mouse import Button, Controller
from pynput import keyboard
from pynput.keyboard import Key, Controller


delay = .01 ##how much time between release shift and click
cancel_delay = .3 ##after how much holding time will it cancel the click

input_key = keyboard.Key.shift_r
output_key = Key.tab



print('program started')
board = Controller()

waiting = False
def ress(key):
    if(key == input_key):
        print('shift received')
        # to get around multiple shift inputs from 1 press, this will-
        # set a waiting tag to true to ignore any inputs after the first press.
        global waiting
        if(not waiting):
            # record time for ability to cancel later
            global presstime
            presstime = time.time() 
            waiting = True  #set waiting tag to true
##            print(presstime)

def lease(key):
##    print('{0} released'.format(
##        key))
    if key == keyboard.Key.esc:
        print('user stop')
        # Stop listener
        return False
    if(key == input_key):
        # cancel the click if delay is too big
        if(time.time() - presstime > cancel_delay): 
            print('cancelled')            
        else:
            time.sleep(delay)
            # Press and release tab
            board.press(output_key)
            board.release(output_key)
            print('tab press')
        # set waiting tag to allow another input
        global waiting
        waiting = False
##        print(waiting)


#Collect events until released in a non-blocking fashion:
listener = keyboard.Listener(
    on_press=ress,
    on_release=lease)
listener.start()

#keep paretn thread alive so it can work outside of IDLE
listener.join()

