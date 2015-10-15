numOfRings = int(raw_input("How manny pins do you want: "))
tempRingList = list()
zeros = list()
zeros2 = list()
for i in range(numOfRings):
    tempRingList.append(numOfRings-i)
    zeros.append(0)
    zeros2.append(0)

pinList = [tempRingList, zeros, zeros2]

def otherPin(pin1, pin2):
    pin3 = -1
    if(pin1 == 0 and pin2 == 1 or pin2 == 0 and pin1 == 1):
        pin3 = 2
    elif(pin1 == 0 and pin2 == 2 or pin2 == 0 and pin1 == 2):
        pin3 = 1
    elif(pin1 == 1 and pin2 == 2 or pin2 == 1 and pin1 == 2):
        pin3 = 0
    return pin3

def pinsAbove(pinNum, ringNum):
    above = 0
    for i in range(ringNum+1,numOfRings):
        if(not(pinList[pinNum][i] == 0)):
            above = above + 1
        
    return above

def move(ringPin, targetPin):
    if not(0 in pinList[ringPin]):
        pinList[targetPin][pinList[targetPin].index(0)] =  pinList[ringPin][numOfRings-1]
        pinList[ringPin][numOfRings-1] = 0
    else:
        pinList[targetPin][pinList[targetPin].index(0)] =  pinList[ringPin][pinList[ringPin].index(0)-1]
        pinList[ringPin][pinList[ringPin].index(0)-1] = 0
        
    print pinList

def towerSolve(ringPin, ringNumber, targetPin):
    if(ringNumber >= numOfRings-1):
        move(ringPin, targetPin)
    elif(pinList[ringPin][ringNumber+1] == 0):
        move(ringPin, targetPin)
    else:
        emptyPin = otherPin(ringPin, targetPin)
        numOfPinsAbove = pinsAbove(ringPin, ringNumber) 
        towerSolve(ringPin, ringNumber+1, emptyPin)
        move(ringPin, targetPin)
        towerSolve(emptyPin, pinsAbove(emptyPin, 0)+1-numOfPinsAbove, targetPin)


print pinList
towerSolve(0,0,2)
