import time
from pyautogui import click
import pydirectinput 
##from pynput.keyboard import Controller , Key

def tripleClick(delay = .1):
    for i in range(0,3):
        click()
        time.sleep(delay)
##        print('click')


### note: key = '2' is not the same as the user pressing 2.
### you have to set the controls in Minecraft if you want to use this. 
##def pressKey(key, delay = .05):
##    board = Controller()
####    print('i am testfunction')
##    board.press(key)
##    time.sleep(delay)
##    board.release(key)

# pydirectinput works without any tricks. YAY
def pressKey(key, delay = .05):
    pydirectinput.keyDown(key)
    time.sleep(delay)
    pydirectinput.keyUp(key)


if __name__ == "__main__":
    time.sleep(3)
    pressKey('e')
