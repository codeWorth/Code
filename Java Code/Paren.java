public class Paren{
	public static String parens(String expression){ //pass expression within parens to self
		char c;

		String newExpression = expression;

		boolean shouldRecord = false; //if the characters being selected are within parenthesis
		String subExpression = ""; //the string within the parenthesis

		int parenStart = 0; //the start position of the parenthesis
		int parenCount = 0; //for nested parenthesis

		String evaledSub = "";

		for(int i = 0; i < newExpression.length(); i++){
			c = newExpression.charAt(i);

			if(!shouldRecord){ //not within parenthesis yet
				if (c == '('){ //found starting parenthesis
					shouldRecord = true;
					parenCount++;
					parenStart = i;
				}
			} else { //within parenthesis
				if (c == '('){
					parenCount++;
					subExpression += c;
				} else if (c==')'){ //closing parenthesis
					parenCount--;
					if(parenCount == 0){
						shouldRecord = false;
						evaledSub = parens(subExpression); //search sub expression for any parenthesis
						subExpression = "";

						String leftPart = newExpression.substring(0,parenStart); //the part of expression on the left of the parenthesis that we just evaluated
						String rightPart = newExpression.substring(i+1);

						newExpression = leftPart + evaledSub + rightPart; //combine the parts
						i = 0; //reset i from the beginning so that the parenStart can be calculated correctly
					} else {
						subExpression += c;
					}
				} else {
					subExpression += c;
				}
			}
		}

		newExpression = AddSub.evalAddSub(newExpression) + ""; //evaluate the rest of the expression for +,-,*,/,^

		return newExpression;
	}

	public static String parenMult(String expression){ //change every case from x(y) to x*(y) e.g. 3(5+4) = 3*(5+4)
		char c;
		char cBefore = expression.charAt(0); //assumes that expression is at least length 1

		String newExpression = "" + cBefore;

		for (int i = 1; i < expression.length(); i++){ //starts at 1 because a parenthesis at 0 cannot have a number before it
			c = expression.charAt(i);

			if (c == '('){
				if (cBefore >= '0' && cBefore <= '9'){ //check if a number preceeds the parenthesis
					newExpression += "*"; //add the multiplication sign
				} else if (cBefore == '-'){
					newExpression += "1*"; //if there is -(x) it should be -1*(x)
				}
			}

			newExpression += c; //rebuild the string

			cBefore = c;
		}

		return newExpression;
	}
}