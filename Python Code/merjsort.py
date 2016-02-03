def merjSort(array):
    if len(array) == 1:
        return array
    else:
        pL = len(array)/2
        p1 = merjSort(array[:pL])
        p2 = merjSort(array[pL:])
        n1 = 0
        n2 = 0
        nL = []
        while n1 < pL and n2 < pL + 1:
            if (p1[n1]<p2[n2]):
                nL.append(
