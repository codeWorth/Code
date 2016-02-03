def merjSort(array):
    if len(array) == 1:
        return array
    else:
        pL = len(array)/2
        print array[:pL]
        print array[pL:]
        print "--------"
        p1 = merjSort(array[:pL])
        p2 = merjSort(array[pL:])
        print p1
        print p2
        print "+++++++"
        n1 = 0
        n2 = 0
        pL2 = len(p2)
        nL = []
        while n1 < pL and n2 < pL2:
            if (p1[n1]<p2[n2]):
                nL.append(p1[n1])
                n1 += 1
                
            else:
                nL.append(p2[n2])
                n2 += 1

        if n1 == pL:
            if n2 < pL + 1:
                nL.extend(p2[n2:])

        else:
            nL.extend(p1[n1:])

        return nL

while True:
    array = []
    num = raw_input("Value: ")
    while (num != ""):
        array.append(int(num))
        num = raw_input("Value: ")
    
    print array
    print "--------"
    end = merjSort(array)
    print "Result:"
    print end
