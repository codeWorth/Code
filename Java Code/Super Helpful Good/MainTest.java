public class MainTest{
	public static void main(String[] args) {
		Shape shape = new Shape(4);
		shape.set(new MyPoint(10,10), 0);
		shape.set(new MyPoint(30,10), 1);
		shape.set(new MyPoint(30,20), 2);
		shape.set(new MyPoint(10,20), 3);

		System.out.println(shape.isPointWithin(0,0) + " false");
		System.out.println(shape.isPointWithin(10,10) + " true");
		System.out.println(shape.isPointWithin(15,20) + " true");
		System.out.println(shape.isPointWithin(30,20) + " true");
		System.out.println(shape.isPointWithin(40,10) + " false");
	}
}