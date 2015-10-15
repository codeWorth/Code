gridSize = int(raw_input("Max width of diamond: "))
symbol1 = raw_input("Symbol 1: ")
symbol2 = raw_input("Symbol 2: ")
sym1W = int(raw_input("Stripe width of symbol 1: "))
sym2W = int(raw_input("Stripe width of symbol 2: "))
combW = sym1W + sym2W
offset = gridSize/2 

for i in range(gridSize):
    print ""
    for j in range(gridSize):
        count = (j + (i % combW) - offset) % combW #position within the sym1 plus sym2 pattern
        bounceI = abs(i - offset) #computes the padding (how much to cut away)
        if j >= bounceI and j < (gridSize - bounceI): #if between padding
            if (count < sym1W):
                print symbol1,
            else:
                print symbol2,

        else:
             print " ",




