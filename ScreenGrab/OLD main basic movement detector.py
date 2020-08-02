##https://pythonprogramming.net/game-frames-open-cv-python-plays-gta-v
import numpy as np
from PIL import ImageGrab
import cv2
import time

from DirectXKeyCodes import *
W= DIK_W
A= DIK_A
S= DIK_S
D= DIK_D
from sendkeys import PressKey, ReleaseKey

"""this program currently takes about 25 minutes to mine 1 full layer
(5 auto layers. user must prepare first 2 layers) that is not including
time lost from items getting stuck, bc it freezes if it sees moving item,
also it does not account for gravel falling and moving player's position,
but does not fatally break in eiher case.
Minecraft player must be facing exactly at -0.0 or 90.0 and point up
press F3 to make it freeze bc it will detect the numbers changing
"""

def sendinput(key, delay=.15):
    PressKey(key)
    time.sleep(delay)
    ReleaseKey(key)

def process_img(image):
    ##NOTE TO SELF: add ROI mask to avoid reading hotbar bubbles and chat
    processed_img = image
    # convert to gray
    processed_img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # edge detection
##    processed_img =  cv2.Canny(processed_img, threshold1 = 200, threshold2=300)
    return processed_img


def screen_record():
    last_time = time.time()
    same_count = 0
    key = A #key will switch between A, W, and D
    while True:
        screen =  np.array(ImageGrab.grab(bbox=(560,240,800+560,600+240)))
##        print('Frame took {} seconds'.format(time.time()-last_time))
##        #print('Framerate: {}fps'.format(1/(time.time()-last_time)))
        last_time = time.time()
        new_screen = process_img(screen)
        try: # this is in try bc it uses old_screen before it's defined
            # compare the 2 arrays, see if they are within tolerance
            # abs(a - b) <= (atol + rtol * abs(b))
            if np.allclose(old_screen, new_screen, rtol=2, atol=10):
##                print("screens are same")
                #count how many similar frames in a row to avoid flukes
                same_count += 1
                print(same_count,end='')
                if True:
                    pass#temporarily stop keys from being pressed
                elif same_count >= 7:
                    # if stopped on edge go forward
                    sendinput(W, delay=.2)
                    # toggle movement direction
                    if key==A:
                        key = D
                    elif key==D:
                        key = A
                        
                elif same_count >= 3:
                    sendinput(key) # go left or right when screen doesn't change
            else:
                same_count = 0 # reset count if change occurs
        except:
            pass
        old_screen = new_screen.copy()
        cv2.imshow('window', new_screen)
##        cv2.imshow('window',cv2.cvtColor(screen, cv2.COLOR_BGR2RGB))
        if cv2.waitKey(25) & 0xFF == ord('q'):
            cv2.destroyAllWindows()
            break

if __name__=="__main__":
    screen_record()
