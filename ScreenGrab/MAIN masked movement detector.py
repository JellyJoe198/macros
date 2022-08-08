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

"""this program currently takes about ?25 minutes? to mine 1 full layer
(5 auto layers. user must prepare first 2 layers) that is not including
time lost from items getting stuck, (it may freeze if it sees a moving item)
also it does not account for gravel falling and moving player's position,
but does not fatally break in eiher case.
Minecraft player must be facing exactly at -0.0 or 90.0 and point up
press F3 to freeze program bc it will detect the changes in the numbers
"""

def sendinput(key, delay=.16):
    PressKey(key)
    time.sleep(delay)
    ReleaseKey(key)

from mask_vertices import *
#docs.opencv.org/master/d0/d86/tutorial_py_image_arithmetics.html
#https://stackoverflow.com/a/50159769/12541334
#https://docs.opencv.org/2.4/modules/core/doc/operations_on_arrays.html#absdiff
def roi_priority(img):
    #blank mask (block everything)
    mask = np.full_like(img, 255) #it looks like alpha channel is useless
    #clear the priority sections from the mask
    for current in priorities:
        cv2.fillPoly(mask, np.array([current]), 0)
    #combine mask with image
    masked = cv2.bitwise_or(img, mask)
    return masked

def roi_block(img, vertices):
    mask = np.full_like(img, 255) # blank canvas
    cv2.fillPoly(mask, vertices, 0) # fill the mask with black
    masked = cv2.bitwise_and(img, mask) # show img except for the mask
    return masked

def process_img(image):
    ## adds ROI mask to avoid reading hotbar bubbles and chat
    # processed_img = image
    # convert to gray
    processed_img = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    # add mask
    processed_img = roi_priority(processed_img) #, [np.array(priority_mask)])
    processed_img = roi_block(processed_img, [np.array(inventory_mask)])
    # edge detection
    #processed_img =  cv2.Canny(processed_img, threshold1 = 100, threshold2=200)
    return processed_img


def screen_record():
    last_time = time.time()
    same_count = 0
    diff_count = 0
    key = A #key will switch between A, W, and D
    while True:
        screen =  np.array(ImageGrab.grab(bbox=ScreenBBox))
##        print(end='.')
##        print('{} seconds'.format(round(time.time()-last_time, 3)))
##        print('Framerate: {}fps'.format(round(1/(time.time()-last_time), 3)))
        last_time = time.time()
        new_screen = process_img(screen)
        try: # this is in try bc it uses old_screen before it's defined
            # compare the 2 arrays, see if they are within tolerance
            # abs(a - b) <= (atol + rtol * abs(b))
            if np.allclose(old_screen, new_screen, rtol=2, atol=10):
##                print("screens are same")
                #count how many similar frames in a row to avoid flukes
                same_count += 1
                print(same_count,end=' -- ')
                if same_count >= 7:
                    pass #stop keys from being pressed too often
                elif same_count >= 5:
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
                diff_count += 1
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
