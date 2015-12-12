file percents = open("percents.txt", "w+")

numOfFiles = 1

i = 0
while (i < numOfFiles):
    file inputFile = open("file"+i+".txt", "r");

    fileStr = inputFile.read()
    j = 0
    while (j < len(fileStr)):
        curWord = ""
        curChar = ""
    
        while (curChar == " "):
            curChar = fileStr[j]
            curWord += curChar
            j++

        k = 0 
        while (k < len(curWord)):
            #doStuff

    i++
    
