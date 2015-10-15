from Tkinter import *
import tkFont
import numpy as np
import random
import mnist_loader

app = Tk()
app.title("Artificial Intelligence")
canv = Canvas(app, width=1400, height=820)
canv.pack()

relXPos = -700
relYPos = -70

lineDrawI = -1
lineDrawJ = -1

size = 20
spacing = size*1.8
relX = 0;
relY = 0;

moveInc = 40

ySpread = 300

values = []

imgData = [];

def hsvToHex(H,S,V):
    M = 255*V
    m = M*(1-S)

    R = 0
    G = 0
    B = 0

    z = (M-m)*(1 - abs((H/60) % 2 - 1))

    if (0 <= H and H < 60):
        R = M
        G = z + m
        B = m
    elif (60 <= H and H < 120):
        R = z + m
        G = M
        B = m
    elif (120 <= H and H < 180):
        R = m
        G = M
        B = z + m
    elif (180 <= H and H < 240):
        R = m
        G = z + m
        B = M
    elif (240 <= H and H < 300):
        R = z + m
        G = m
        B = M
    elif (300 <= H and H < 360):
        R = M
        G = m
        B = z + m

    return "#"+format(int(R), '#04x')[2:]+format(int(G), '#04x')[2:]+format(int(B), '#04x')[2:]

def drawNum(num):
    font = tkFont.Font(family="Helvetica",size=400)  
    canv.delete("all")
    drawWeightsForBias()    
    moveRelative()
    canv.create_text(700,410,text=num,font=font)

def hFromNum(n):
    thresh = 1.5
    if (n < -thresh): 
        return 240
    elif (n>thresh):
        return 0
    else:
        return (120/thresh)*(-n + thresh)
    
def moveCanvUp(e):
    global relYPos
    relYPos += -moveInc
    canv.delete("all")
    drawWeightsForBias()    
    moveRelative()
    
def moveCanvDown(e):
    global relYPos
    relYPos += moveInc 
    canv.delete("all")
    drawWeightsForBias()    
    moveRelative()

def moveCanvRight(e):
    global relXPos
    relXPos += moveInc
    canv.delete("all") 
    drawWeightsForBias()    
    moveRelative()
    
def moveCanvLeft(e):
    global relXPos
    relXPos += -moveInc
    canv.delete("all") 
    drawWeightsForBias()    
    moveRelative()

    
#npImgData = np.array(imgData);
#npImgData = np.reshape(npImgData, (784, 1));

#myPic = (npImgData, 5);

def resetValues():
    for i in range(len(net.sizes)):
        values.append([])
        for j in range(net.sizes[i]):
            values[i].append(1)

def listizeBiases(biases):
    newBias = []
    for i in xrange(len(biases)):
        newBias.append([]);
        for anItem in biases[i].tolist():
            newBias[i].append(anItem[0])

    return newBias


def moveRelative():
    x = 0;
    multFactor = 10;
    for j in range(784):
        canv.create_arc(xPosForIndex(0,j), yPosForIndex(0), xPosForIndex(0,j) + size, yPosForIndex(0) + size, fill=hsvToHex(hFromNum(0),1,values[0][j]), extent="359", outline=hsvToHex(hFromNum(0),1,values[0][j]));
        
    biases = listizeBiases(net.biases);

    for i in [1,2]:
        for j in range(len(biases[i-1])):
            canv.create_arc(xPosForIndex(i,j), yPosForIndex(i), xPosForIndex(i,j) + size, yPosForIndex(i) + size, fill=hsvToHex(hFromNum(biases[i-1][j]),1,values[i][j]), extent="359", outline=hsvToHex(hFromNum(biases[i-1][j]),1,values[i][j]));        
    
    font = tkFont.Font(family="Helvetica",size=36)  
    canv.create_text(700,-20-relYPos,text="Input Layer", font=font)
    font = tkFont.Font(family="Helvetica",size=24) 
    canv.create_text(-relXPos,650-relYPos,text="Output Layer", font=font)
    
def clickOnNeuron(e):
    global lineDrawI
    global lineDrawJ    
    pos = findClickedNeuron(e)
    if (pos[0] == -1):
        if (lineDrawI >= 0):
            lineDrawI = -1
            canv.delete("all")  
            drawWeightsForBias()
            moveRelative()                
    else:
        lineDrawI = pos[0]
        lineDrawJ = pos[1]
        canv.delete("all")        
        drawWeightsForBias()
        moveRelative()          
            
def findClickedNeuron(e):
    for i in range(len(net.sizes)):
        y = yPosForIndex(i)        
        if (e.y > y-size*0.5  and e.y < y+size*1.5):
            for j in range(net.sizes[i]):
                x = xPosForIndex(i,j)
                if (e.x >  x-size*0.5 and e.x < x+size*1.5):
                    return (i,j)
                
    return (-1,-1)
            
    
def drawWeightsForBias():
    i = lineDrawI
    j = lineDrawJ
    if (i == 0):
        #draw lines from j in first part of biases to all in second part of biases
        for n in range(net.sizes[1]):
            startX = xPosForIndex(i,j)+size/2
            startY = yPosForIndex(i)+size/2
            endX = xPosForIndex(i+1,n)+size/2
            endY = yPosForIndex(i+1)+size/2
            canv.create_line(startX, startY, endX, endY, fill=hsvToHex(hFromNum(net.listWeights[i][n][j]),1,1), width=1)
            
    elif (i == len(net.sizes)-1):
        for n in range(net.sizes[i-1]):
            startX = xPosForIndex(i-1,n)+size/2
            startY = yPosForIndex(i-1)+size/2
            endX = xPosForIndex(i,j)+size/2
            endY = yPosForIndex(i)+size/2
            canv.create_line(startX, startY, endX, endY, fill=hsvToHex(hFromNum(net.listWeights[i-1][j][n]),1,1), width=1)   
            
    elif (i>0):
        #layer below
        for n in range(net.sizes[i+1]):
            startX = xPosForIndex(i,j)+size/2
            startY = yPosForIndex(i)+size/2
            endX = xPosForIndex(i+1,n)+size/2
            endY = yPosForIndex(i+1)+size/2
            canv.create_line(startX, startY, endX, endY, fill=hsvToHex(hFromNum(net.listWeights[i][n][j]),1,1), width=1)
            
        #layer above    
        for n in range(net.sizes[i-1]):
            startX = xPosForIndex(i,j)+size/2
            startY = yPosForIndex(i)+size/2
            endX = xPosForIndex(i-1,n)+size/2
            endY = yPosForIndex(i-1)+size/2
            canv.create_line(startX, startY, endX, endY, fill=hsvToHex(hFromNum(net.listWeights[i-1][j][n]),1,1), width=1)         
        
def xPosForIndex(i,j):
    if (i == 0):
        return (j - 784/2)*spacing+10 - relXPos
    else:
        return (j - len(net.biases[i-1])/2)*spacing+10 - relXPos

def yPosForIndex(i):
    return  i*ySpread + 10 - relYPos
    
        
class Network():

    def __init__(self, sizes):
        """The list ``sizes`` contains the number of neurons in the
        respective layers of the network.  For example, if the list
        was [2, 3, 1] then it would be a three-layer network, with the
        first layer containing 2 neurons, the second layer 3 neurons,
        and the third layer 1 neuron.  The biases and weights for the
        network are initialized randomly, using a Gaussian
        distribution with mean 0, and variance 1.  Note that the first
        layer is assumed to be an input layer, and by convention we
        won't set any biases for those neurons, since biases are only
        ever used in computing the outputs from later layers."""
        self.num_layers = len(sizes)
        self.sizes = sizes
        self.biases = [np.random.randn(y, 1) for y in sizes[1:]]
        self.weights = [np.random.randn(y, x) 
                        for x, y in zip(sizes[:-1], sizes[1:])]
        self.listWeights = [np.random.randn(y, x).tolist() 
                        for x, y in zip(sizes[:-1], sizes[1:])]
        
        ''' weights contains a list for each space between the layers (weights[0] is between biases[0] and biases[1], weights[1] is between biases[1] and biases[2]).
        each list in weights is an y by x 2-d array (y being size of second layer, x being size of first layers). 
        Therefore, weights[0][0][0] is the connection between biases[0][0] and biases[1][0]. 
        Weights[0][1][0] is the connection between biases[0][0] and biases[1][1].
        Weights[i][j][l] is the connection between biases[i][l] and biases[i+1][j]
        '''
        
    def feedforward(self, a):
        """Return the output of the network if ``a`` is input."""
                    
        for i in range(len(zip(self.biases, self.weights))):
            a = sigmoid_vec(np.dot(self.weights[i], a)+self.biases[i])
                          
        return np.argmax(a)

    def SGD(self, training_data, epochs, mini_batch_size, eta,
            test_data=None):
        """Train the neural network using mini-batch stochastic
        gradient descent.  The ``training_data`` is a list of tuples
        ``(x, y)`` representing the training inputs and the desired
        outputs.  The other non-optional parameters are
        self-explanatory.  If ``test_data`` is provided then the
        network will be evaluated against the test data after each
        epoch, and partial progress printed out.  This is useful for
        tracking progress, but slows things down substantially."""
        if test_data: n_test = len(test_data)
        n = len(training_data)
        for j in xrange(epochs):
            random.shuffle(training_data)
            mini_batches = [
                training_data[k:k+mini_batch_size]
                for k in xrange(0, n, mini_batch_size)]
            for mini_batch in mini_batches:
                self.update_mini_batch(mini_batch, eta)
            if test_data:
                print "Epoch {0}: {1} / {2}".format(
                    j, self.evaluate(test_data), n_test)
            else:
                print "Epoch {0} complete".format(j)

        #print np.argmax(self.feedforward(myPic[0]));

    def update_mini_batch(self, mini_batch, eta):
        """Update the network's weights and biases by applying
        gradient descent using backpropagation to a single mini batch.
        The ``mini_batch`` is a list of tuples ``(x, y)``, and ``eta``
        is the learning rate."""
        nabla_b = [np.zeros(b.shape) for b in self.biases]
        nabla_w = [np.zeros(w.shape) for w in self.weights]
        for x, y in mini_batch:
            delta_nabla_b, delta_nabla_w = self.backprop(x, y)
            nabla_b = [nb+dnb for nb, dnb in zip(nabla_b, delta_nabla_b)]
            nabla_w = [nw+dnw for nw, dnw in zip(nabla_w, delta_nabla_w)]
        self.weights = [w-(eta/len(mini_batch))*nw 
                        for w, nw in zip(self.weights, nabla_w)]
        self.biases = [b-(eta/len(mini_batch))*nb 
                       for b, nb in zip(self.biases, nabla_b)]

    def backprop(self, x, y):
        """Return a tuple ``(nabla_b, nabla_w)`` representing the
        gradient for the cost function C_x.  ``nabla_b`` and
        ``nabla_w`` are layer-by-layer lists of numpy arrays, similar
        to ``self.biases`` and ``self.weights``."""
        nabla_b = [np.zeros(b.shape) for b in self.biases]
        nabla_w = [np.zeros(w.shape) for w in self.weights]
        activation = x
        activations = [x] # list to store all the activations, layer by layer
        zs = [] # list to store all the z vectors, layer by layer
        for b, w in zip(self.biases, self.weights):
            z = np.dot(w, activation)+b
            zs.append(z)
            activation = sigmoid_vec(z)
            activations.append(activation)
        # backward pass
        delta = self.cost_derivative(activations[-1], y) * \
            sigmoid_prime_vec(zs[-1])
        nabla_b[-1] = delta
        nabla_w[-1] = np.dot(delta, activations[-2].transpose())
        # Note that the variable l in the loop below is used a little
        # differently to the notation in Chapter 2 of the book.  Here,
        # l = 1 means the last layer of neurons, l = 2 is the
        # second-last layer, and so on.  It's a renumbering of the
        # scheme in the book, used here to take advantage of the fact
        # that Python can use negative indices in lists.
        for l in xrange(2, self.num_layers):
            z = zs[-l]
            spv = sigmoid_prime_vec(z)
            delta = np.dot(self.weights[-l+1].transpose(), delta) * spv
            nabla_b[-l] = delta
            nabla_w[-l] = np.dot(delta, activations[-l-1].transpose())
        return (nabla_b, nabla_w)

    def evaluate(self, test_data):  
        """Return the number of test inputs for which the neural
        network outputs the correct result. Note that the neural
        network's output is assumed to be the index of whichever
        neuron in the final layer has the highest activation."""        
        test_results = [(np.argmax(self.feedforward(x)), y) 
                        for (x, y) in test_data]

        return sum(int(x == y) for (x, y) in test_results)
                
    def cost_derivative(self, output_activations, y):
        """Return the vector of partial derivatives \partial C_x /
        \partial a for the output activations."""
        return (output_activations-y) 

#### Miscellaneous functions
def sigmoid(z):
    """The sigmoid function."""
    return 1.0/(1.0+np.exp(-z))

sigmoid_vec = np.vectorize(sigmoid)

def sigmoid_prime(z):
    """Derivative of the sigmoid function."""
    return sigmoid(z)*(1-sigmoid(z))

sigmoid_prime_vec = np.vectorize(sigmoid_prime)

net = Network([784, 30, 10])
training_data,validation_data,test_data = mnist_loader.load_data_wrapper()
#orig_training_data,orig_validation_data,orig_test_data = mnist_loader.load_data();

net.SGD(training_data, 30, 10, 3.0)
resetValues()
drawWeightsForBias()
moveRelative()

def feed1(e):
    drawNum(net.feedforward(test_data[0][0]))
    
def feed2(e):
    drawNum(net.feedforward(test_data[1][0]))
    
def feed3(e):
    drawNum(net.feedforward(test_data[2][0]))
    
def feed4(e):
    drawNum(net.feedforward(test_data[11][0]))
    
def feed5(e):
    drawNum(net.feedforward(test_data[4][0]))
    
def feed6(e):
    drawNum(net.feedforward(test_data[5][0]))
    
def feed7(e):
    drawNum(net.feedforward(test_data[6][0]))
    
def feed8(e):
    drawNum(net.feedforward(test_data[7][0]))
    
def feed9(e):
    drawNum(net.feedforward(test_data[10][0]))
    
def feed10(e):
    drawNum(net.feedforward(test_data[9][0]))

app.bind("w", moveCanvUp)
app.bind("s", moveCanvDown)
app.bind("a", moveCanvLeft)
app.bind("d", moveCanvRight)
app.bind("<Button-1>", clickOnNeuron)
app.bind("1", feed1)
app.bind("2", feed2)
app.bind("3", feed3)
app.bind("4", feed4)
app.bind("5", feed5)
app.bind("6", feed6)
app.bind("7", feed7)
app.bind("8", feed8)
app.bind("9", feed9)
app.bind("0", feed10)

app.mainloop()
