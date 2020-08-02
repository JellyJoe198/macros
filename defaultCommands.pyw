import time
from pyautogui import click
import pydirectinput 
##from pynput.keyboard import Controller , Key

"""This is used in the empty buckets macro and some others.
"""

def tripleClick(delay = .1):
    for i in range(0,3):
        click()
        time.sleep(delay)
##        print('click')


# pydirectinput works without any special tricks
def pressKey(key, delay = .05):
    pydirectinput.keyDown(key)
    time.sleep(delay)
    pydirectinput.keyUp(key)


if __name__ == "__main__":
    time.sleep(3)
    pressKey('e')
