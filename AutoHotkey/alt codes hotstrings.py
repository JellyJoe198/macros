characters116 =['☺','☻','♥','♦','♣','♠','•','◘','○','◙','♂','♀','♪','♫','☼','►','◄','↕','‼','¶','§','▬','↨','↑','↓','→','←','∟','↔','▲','▼','space','!','"','#','$','%','&',"'",'(',')','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',':',';','<','=','>','?','@','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
def LOGICcharacters116(i):
    if i<9:
        return str(i+1)
        #return '0'+ str(i+1) #add extra 0 to make it 4 characters
    elif i<90:
        return str(i+1) #normal case
    else:
        return '00'+ str(i-25) #add extra 00 shortcut for capital letters


alpha =['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z']
def LOGICalpha(i):
    h= i+64 # add 64 bc that is where the letters start in unicode
    return LOGICcharacters116(h) # uses same 


chars91u127 = ['[','\\',']','^','_','`','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','{','|','}','~','⌂']
def LOGICchars91u127(i):
    h= i+91
    return h

chars128u255 = ['Ç','ü','é','â','ä','à','å','ç','ê','ê','è','ï','î','ì','Ä','Å','É','æ','Æ','ô','ö','ò','û','ù','ÿ','Ö','Ü','¢','£','¥','₧','ƒ','á','í','ó','ú','ñ','Ñ','ª','º','¿','⌐','¬','½','¼','¡','«','»','░','▒','▓','│','┤','╡','╢','╖','╕','╣','║','╗','╝','╜','╛','┐','└','┴','┬','├','─','┼','╞','╟','╚','╔','╩','╦','╠','═','╬','╧','╨','╤','╥','╙','╘','╒','╓','╫','╪','┘','┌','█','▄','▌','▐','▀','α','ß','Γ','π','Σ','σ','µ','τ','Φ','Θ','Ω','δ','∞','φ','ε','∩','≡','±','≥','≤','⌠','⌡','÷','≈','°','∙','·','√','ⁿ','²','■',' ']
def LOGICchars128u255(i):
    return i+128

##from AltCodesAlpha import alphacodes


chars = chars128u255
altCode = LOGICchars128u255

def allChars():
    for y in range(0, len(chars)+1):
        try:
            j = altCode(y)
            file.write("::00%s::{%s}\n" % (j, chars[y]))
##            file.write("%s: '%s',\n" % (j, chars[i]))
            print(y, end=', ')
        except:
            print("%s failed" % (y))
            raise


with open("Output.txt" , 'w', encoding='utf8') as file:
    allChars()
