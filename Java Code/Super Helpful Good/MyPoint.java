public class MyPoint{
	public double x = 0;
	public double y = 0;

	public MyPoint(double x, double y){
		this.x = x;
		this.y = y;
	}

	public MyPoint(){
		x = 0;
		y = 0;
	}

	public void add(MyPoint otherPoint){
		x += otherPoint.x;
		y += otherPoint.y;
	}

	public void subtract(MyPoint otherPoint){
		x -= otherPoint.x;
		y -= otherPoint.y;
	}

	public double dot(MyPoint otherPoint){
		return this.x*otherPoint.x + this.y*otherPoint.y;
	}

	public double distSquaredTo(MyPoint otherPoint){
		double difX = x - otherPoint.x;
		double difY = y - otherPoint.y;

		return difX*difX + difY*difY;
	}

	public MyPoint copy(){
		MyPoint copy = new MyPoint(x,y);
		return copy;
	}
}