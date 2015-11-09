public class Matrix{
	private double[][] matrix;

	public Matrix(int rows, int columns){
		if (rows < 1){
			rows = 1;
		}
		if (columns < 1){
			columns = 1;
		}
		this.matrix = new double[columns][rows];
	}

	public Matrix(double[][] theMatrix){
		this.matrix = theMatrix;
	}

	public Matrix(){
		this.matrix = new double[1][1];
	}

	public double[][] matrix(){
		return this.matrix;
	}

	public boolean add(Matrix otherMatrix){
		if (otherMatrix.length != this.matrix.length){
			return false;
		}
		if (otherMatrix[0].length != this.matrix[0].length){
			return false;
		}

		for (int i = 0; i < otherMatrix.length; i++){
			for (int j = 0; j < otherMatrix[i].length; j++){
				this.matrix[i][j] += otherMatrix[i][j];
			}
		}

		return true;
	}

	public boolean subtract(Matrix otherMatrix){
		if (otherMatrix.length != this.matrix.length){
			return false;
		}
		if (otherMatrix[0].length != this.matrix[0].length){
			return false;
		}

		for (int i = 0; i < otherMatrix.length; i++){
			for (int j = 0; j < otherMatrix[i].length; j++){
				this.matrix[i][j] -= otherMatrix[i][j];
			}
		}

		return true;
	}

	public boolean crossMultiply(Matrix otherMatrix){
		/*
		[1 2 3     [3 4 5 6
		 4 5 7  *   5 0 1 4]
		 2 7 3
		 8 0 1] 
		*/
		 if (this.matrix[0].length != otherMatrix.length){
		 	return false;
		 }

		 double[][] newMat = new double[this.matrix.length][otherMatrix[0].length];

		 for (int i = 0; i < newMat.length; i++){
		 	for (int j = 0; j < newMat[i].length; j++){
		 		double thisVal = 0;

		 		for (int k = 0; k < otherMatrix.length; i++){
		 			thisVal += this.matrix[i][k]*otherMatrix[k][j];
		 		}

		 		newMat[i][j] = thisVal;
		 	}
		 }

		 return true;
	}

	public boolean set(int i, int j, double val){
		if (i < 0 || i >= this.matrix.length){
			return false;
		}
		if (j < 0 || j >= this.matrix[0].length){
			return false;
		}

		this.matrix[i][j] = val;

		return true;
	}
}