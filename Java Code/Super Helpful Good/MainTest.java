public class MainTest{
	public static void main(String[] args) {
		Shape shape = new Shape(6);
		shape.set(new MyPoint(10,10), 0);
		shape.set(new MyPoint(30,10), 1);
		shape.set(new MyPoint(30,15), 2);
		shape.set(new MyPoint(25,15), 3);
		shape.set(new MyPoint(25,20), 4);
		shape.set(new MyPoint(10,20), 5);
		
		System.out.println(shape.area());
	}
}