public class Exponent{
	public static double evalExpo(String expression){
		char c;

		String subToEval = "";

		double numSoFar = 1;

		for (int i = expression.length()-1; i >= 0; i--){ //iterate backwards because exponents are evaluated top down
			c = expression.charAt(i);

			if (c == '^'){
				numSoFar = useOtherOperators(subToEval, numSoFar);
				subToEval = "";
			} else {
				subToEval = c + subToEval;
			}
		}

		numSoFar = useOtherOperators(subToEval, numSoFar);

		return numSoFar;
	}

	public static double useOtherOperators(String subToEval, double numSoFar){ 
		return Math.pow(Double.parseDouble(subToEval), numSoFar); //could be expanded for other operators here
	}
}