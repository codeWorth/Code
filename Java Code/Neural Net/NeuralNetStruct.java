import java.util.*;

public class NeuralNetStruct{
	public ArrayList<ArrayList<ArrayList<Double>>> layers; //layers is a list of neurons, each neuron is a list of Doubles which are weights, except the first element of each neuron is the bias

	public NeuralNetStruct(){
		layers = new ArrayList<ArrayList<ArrayList<Double>>>();
	}

	public void addLayerAtEnd(int size){ //size = 5 adds 5 neurons
		if (size < 0){
			return;
		}
		ArrayList newLayer = new ArrayList<ArrayList<Double>>();


		layers.add(newLayer);

		for (int i = 0; i < size; i++){
			addNeuron(layers.size()-1);
		}
	}

	public void addNeuron(int layer){
		if (layer < 0 || layer >= layers.size()){
			throw new IndexOutOfBoundsException();
		}

		//add neuron itself
		ArrayList<ArrayList<Double>> thisLayer = getLayer(layer);
		ArrayList<Double> newNeuron = new ArrayList<Double>();
		newNeuron.add(new Double(0));

		thisLayer.add(newNeuron); //add neuron to end

		if (layer > 0){ //if it has a layer behind it, add a weight for each neuron in previous layer
			ArrayList<ArrayList<Double>> prevLayer = getLayer(layer-1);
			ArrayList<Double> neuron;

			for (int i = 0; i < prevLayer.size(); i++){
				neuron = getNeuron(prevLayer, i);
				neuron.add(new Double(1));
			}
		}

		if (layer < layers.size() - 1){ //if there is a layer infront, add a weight to this neuron for each neuron infront
			ArrayList<ArrayList<Double>> forwardLayer = getLayer(layer+1);

			for (int i = 0; i < forwardLayer.size(); i++){
				newNeuron.add(new Double(1));
			}
		}
	}

	public ArrayList<ArrayList<Double>> getLayer(int pos){
		if (pos < 0 || pos >= layers.size()){
			throw new IndexOutOfBoundsException();
		}

		return layers.get(pos);
	}

	public ArrayList<Double> getNeuron(ArrayList<ArrayList<Double>> layer, int pos){
		if (pos < 0 || pos > layer.size()){
			throw new IndexOutOfBoundsException();
		}
		
		return layer.get(pos);
	}

	public void print(){
		ArrayList<ArrayList<Double>> layer;
		ArrayList<Double> neuron;

		for (int i = 1; i < layers.size(); i++){
			System.out.println("Layer "+i+":");

			layer = getLayer(i-1);

			for (int k = 0; k < layer.size(); k++){
				System.out.print("	Neuron: [");

				neuron = getNeuron(layer, k);

				for (int j = 0; j < neuron.size(); j++){
					if (j == neuron.size() - 1){
						System.out.print(neuron.get(j));
					} else if (j == 0){
						System.out.print(neuron.get(j) + " | ");
					} else {
						System.out.print(neuron.get(j) + ", ");
					}
				}
				
				System.out.println("]");
			}

			System.out.println("");
		}
	}

	public void setWeight(int layer, int startNeuron, int endNeuron, double newWeight){
		ArrayList<ArrayList<Double>> thisLayer = getLayer(layer);
		ArrayList<ArrayList<Double>> nextLayer = getLayer(layer+1);

		ArrayList<Double> thisNeuron = getNeuron(thisLayer, startNeuron);

		if (endNeuron < 0 || endNeuron >= nextLayer.size()){
			throw new IndexOutOfBoundsException();
		}

		thisNeuron.set(endNeuron + 1, newWeight);
	}

	public void setBias(int layer, int startNeuron, double newBias){
		ArrayList<ArrayList<Double>> thisLayer = getLayer(layer);

		ArrayList<Double> thisNeuron = getNeuron(thisLayer, startNeuron);

		thisNeuron.set(0, newBias);
	}

	public static void main(String[] args) {
		NeuralNetStruct nNet = new NeuralNetStruct();

		nNet.addLayerAtEnd(3);
		nNet.addLayerAtEnd(4);
		nNet.addLayerAtEnd(5);

		nNet.print();

		nNet.addNeuron(1);
		nNet.addNeuron(1);

		nNet.setWeight(0, 1, 2, 3);
		nNet.setBias(2, 3, -2);

		nNet.print();
	}
}