public class MultDiv{
	public static double evalMultDiv(String expression){
		char c;

		String subToEval = "";

		boolean shouldMult = true; //if the previous operator was multiplication (false if division)

		double numSoFar = 1; //because I copy-pasted this code from AddSub, this was a zero, causing all my answers to come out as 0, because of multiplication. interesting bug :P

		for (int i = 0; i < expression.length(); i++){
			c = expression.charAt(i);

			if (c == '*'){
				numSoFar *= useOtherOperators(shouldMult, subToEval);
				subToEval = "";

				shouldMult = true;
			} else if (c == '/'){
				numSoFar *= useOtherOperators(shouldMult, subToEval);
				subToEval = "";

				shouldMult = false;
			} else {
				subToEval += c;
			}
		}

		numSoFar *= useOtherOperators(shouldMult, subToEval);

		return numSoFar;
	}

	public static double useOtherOperators(boolean shouldMult, String subToEval){ //multiply or divide the evaluated section
		if (shouldMult){
			return Exponent.evalExpo(subToEval); //check for exponents
		} else {
			return 1/Exponent.evalExpo(subToEval); //check for exponents
		}
	}
}