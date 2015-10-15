public class AddSub{
	public static double evalAddSub(String expression){
		char c;
		char prevC; //for use in finding negatives

		String subToEval = "";

		boolean shouldAdd = true; //if the previous operator was addition

		double numSoFar = 0;

		for (int i = 0; i < expression.length(); i++){
			c = expression.charAt(i);

			if (c == '+'){
				numSoFar += useOtherOperators(shouldAdd, subToEval);
				subToEval = "";

				shouldAdd = true;
			} else if (c == '-'){
				if (i == 0){ //if the first index is a minus sign then its a negative
					subToEval += c;
				} else {
					prevC = expression.charAt(i-1);
					if (prevC == '-' || prevC == '+' || prevC == '*' || prevC == '/' || prevC == '^'){ //if there is an operator preceading a '-', then it is a negative sign
						subToEval += c;
					} else { //if not after an operator and not at zero then it is actually a minus sign
						numSoFar += useOtherOperators(shouldAdd, subToEval);
						subToEval = "";

						shouldAdd = false;
					}
				}
			} else {
				subToEval += c;
			}
		}

		numSoFar += useOtherOperators(shouldAdd, subToEval);

		return numSoFar;
	}

	public static double useOtherOperators(boolean shouldAdd, String subToEval){ //add or subtract the evaluated section
		if (shouldAdd){
			return MultDiv.evalMultDiv(subToEval); //check for multiplication or division
		} else {
			return -MultDiv.evalMultDiv(subToEval); //check for multiplication or division
		}
	}
}