import java.util.Scanner;

public class Eval{
	public static void main(String[] args) {
		//Scanner in = new Scanner(Scanner.in);

		String testExp = "24+(5+3)/(2^1)*-(3(2))";

		System.out.println("Input: "+testExp);

		String toEval = Paren.parenMult(testExp); //Paren.parenMult(in.nextLine());

		System.out.println("Output: "+Paren.parens(toEval));
	}
}