#More compact and unreadable solution

gridSize = int(raw_input("Max width of diamond: "))
symbol1 = raw_input("Symbol 1: ")
symbol2 = raw_input("Symbol 2: ")
sym1W = int(raw_input("Stripe width of symbol 1: "))
sym2W = int(raw_input("Stripe width of symbol 2: "))

for i in range(gridSize):
    print ""
    for j in range(gridSize):
        if j >= abs(i - gridSize/2) and j < (gridSize - abs(i - gridSize/2)):
            if (((j + (i % (sym1W + sym2W)) - gridSize/2) % (sym1W + sym2W)) < sym1W):
                print symbol1,
            else:
                print symbol2,

        else:
            print " ",
