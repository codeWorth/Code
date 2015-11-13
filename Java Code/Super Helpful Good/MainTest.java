public class MainTest{
	public static void main(String[] args) {
		Shape aShape = new Shape(4);
		aShape.set(new Point(0,0), 0);
		aShape.set(new Point(20,0), 1);
		aShape.set(new Point(20,30), 2);
		aShape.set(new Point(0,30), 3);

		System.out.println(aShape.area());
	}
}