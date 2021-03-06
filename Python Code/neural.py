import numpy as np
import sys
import scipy.misc as misc

imgs = [misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/shoe1.jpg",True).flatten()/255]
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/shoe2.jpg",True).flatten()/255)
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/shoe3.jpg",True).flatten()/255)
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/shoe4.jpg",True).flatten()/255)
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/surfboard.jpg",True).flatten()/255)
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/cat.jpg",True).flatten()/255)
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/dog.jpg",True).flatten()/255)
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/box.jpg",True).flatten()/255)
imgs.append(misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/shoe5.jpeg",True).flatten()/255)

test = misc.imread("/Users/andrew/Code Github/Python Code/Neural Net/mouse.jpg",True).flatten()/255

def sigmoid(x): #sigmoid function
    return 1/(1 + np.exp(-x))

def d_sigmoid(y): #derivative of the sigmoid function, takes the output of a sigmoid and returns the slope at that point's x
    return y * (1 - y)

def feedforward(inputArr): #uses the input layer and synapses' weights to return the output layer as calculated by the net
    if (x.shape[1] != inputArr.shape[1]):
        print("Invalid input to feedforward")
        print("X inputs: " + str(x.shape[1]) + " -- Given inputs: " + str(inputArr.shape[1]))
        sys.exit(0)
    
    l = sigmoid(np.dot(inputArr,syn[0]))

    for i in range(len(btwn)):
        btwn[i] = l
        l = sigmoid(np.dot(l,syn[i+1]))

    return l



#input matrix, each entry is one instance of inputs
x = np.asarray(imgs)
print(x.shape)
xlen = x.shape[1] #number of inputs per entry

#output matrix, each entry is one instance of outputs
y = np.array([ [1,0],
               [1,0],
               [1,0],
               [1,0],
               [0,1],
               [0,1],
               [0,1],
               [0,1],
               [1,0] ])
ylen = y.shape[1] #number of outputs per entry


if (x.shape[0] != y.shape[0]): #if the input of output matricies don't have an equal number of entries, then the data is bad
    print("Mismathed input/output matricies")
    sys.exit(0)
    
elif (x.dtype == "O"): #if the input array has entries with differing numbers of inputs
    print("Invalid input matrix")
    sys.exit(0)
    
elif (y.dtype == "O"): #if the output array has entries with differing numbers of outputs
    print("Invalid output matrix")
    sys.exit(0)



gamma = 1 #net learning rate

layers = [100]; #the number of neurons in each layers between x and y
btwn = [] #the neurons between x and y

for i in range(len(layers)):
    btwn.append(np.zeros((layers[i]))) #fill it with zeros for now

syn = []; #the synapses between each layer

if (len(layers) == 0): #if there are no layers between x and y connect them directly
    syn.append(np.zeros((xlen,ylen)))
    
else: #if there is at least one layers between, make synapses between each layers
    syn.append(2*np.random.random((xlen,layers[0]))-1) #synpases from x to first layer

    for i, size in enumerate(layers[:-1]): #layers that will be interconnected
        nextSize = layers[i+1]
        syn.append(2*np.random.random((size,nextSize))-1)

    syn.append(2*np.random.random((layers[-1],ylen))-1) #synapses from last layer to y


iterations = 10000 #number of times to perform learning algorithim
for i in range(iterations):
    l = feedforward(x) #propogate forward through our neural net to find what output it calculated

    error = y - l #how much did our calculation differ from what it should be?
    delta = error*d_sigmoid(l) #an array of percent changes based on how much we missed and how confident the net was

    if ((i % 500) == 0): #print the current mean error every 200 iterations
        print("Error:" + str(np.mean(np.abs(error))))

    for wrongI, thisSyn in enumerate((syn[1:])[::-1]): #iterate over all of the synapse layers (except the first one) in reverse (aka starting at the end)
        i = len(syn)-wrongI-1 #calculate the actual index of the current synapse that is selected
        error = delta.dot(thisSyn.T) #using the error from before, see how much error there is on each of these neurons

        l = btwn[i-1] #select the layer of neurons that these synpases start at
        syn[i] += gamma * l.T.dot(delta) #update these synapses using the delta calculated before and the current layer of neurons        

        delta = error*d_sigmoid(l) #find the new delta to be used next cycle

    syn[0] += gamma * x.T.dot(delta) #update the last batch of synapses using the input layer and the delta calculated during the for loop        

print("Should be: (0,1)")
print(feedforward(np.array([test]))) #print what our network calculated the output should look like

    

    
        

    


