##auto clicker from
##https://nitratine.net/blog/post/python-auto-clicker/
##modified to click in random time intervals to test a Minecraft door

import time
import threading
from pynput.mouse import Button, Controller
from pynput.keyboard import Listener, KeyCode
import random


min_delay = .01
max_delay = 1.1
button = Button.right
start_stop_key = KeyCode(char='n')
exit_key = KeyCode(char='e')

print("press %s to start/stop and %s to exit" % (start_stop_key, exit_key))

class ClickMouse(threading.Thread):
    def __init__(self, button):
        super(ClickMouse, self).__init__()
##        self.delay = delay
        self.button = button
        self.running = False
        self.program_running = True


    def start_clicking(self):
        self.running = True

    def stop_clicking(self):
        self.running = False

    def exit(self):
        self.stop_clicking()
        self.program_running = False


    def run(self):
        while self.program_running:
            while self.running:
                mouse.click(self.button)
                delay = random.uniform(min_delay, max_delay)
                print(delay)
                time.sleep(delay)
            time.sleep(0.1)

mouse = Controller()
click_thread = ClickMouse(button)
click_thread.start()


def on_press(key):
    if key == start_stop_key:
        if click_thread.running:
            click_thread.stop_clicking()
            print('not clicking')
        else:
            click_thread.start_clicking()
            print('clicking')
    elif key == exit_key:
        click_thread.exit()
        listener.stop()
        print('stopped')


with Listener(on_press=on_press) as listener:
    listener.join()



