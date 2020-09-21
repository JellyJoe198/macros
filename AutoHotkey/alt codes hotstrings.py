characters116 =['☺','☻','♥','♦','♣','♠','•','◘','○','◙','♂','♀','♪','♫','☼','►','◄','↕','‼','¶','◙','▬','↨','↑','↓','→','←','∟','↔','▲','▼','space','!','"','#','$','%','&',"'",'(',')','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',':',';','<','=','>','?','@','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

alpha =['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']

##from AltCodesAlpha import *

chars = alpha

def allChars():
    for y in range(0, len(chars)+1):
        try:
            i= y+64 # this is for alpha characters only. i=y if starting at 01
            if i<9:
                j= '0'+ str(i+1) #add extra 0 to make it 4 characters
            elif i<90:
                j= str(i+1) #normal
            else:
                j= '00'+ str(i-25) #add extra 00 shortcut for capital letters
            file.write(":*:00,%s::^{%s}\n" % (j, chars[y]))
##            file.write("%s: '%s',\n" % (j, chars[i]))
            print(i, end=', ')
        except:
            print("%s failed" % (i))


with open("Output.txt" , 'w', encoding='utf8') as file:
    allChars()
