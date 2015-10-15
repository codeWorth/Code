thisInput = raw_input("lerp: ")
lap = [];
while thisInput != "":
    newInput = ""
    for char in thisInput:
        if (char == " "):
            newInput = newInput + "%20"
        else:
            newInput = newInput + char

    
    lap.append(newInput);
    thisInput = raw_input("")


text = ""
for laa in lap:
    text = text + "http://img.dafont.com/preview.php?text=" + laa + "&ttf=dust_west0&ext=1&size=55&psize=l&y=56\n"

print text
