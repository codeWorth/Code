public class Point{
	public double x = 0;
	public double y = 0;

	public Point(double x, double y){
		this.x = x;
		this.y = y;
	}

	public Point(){
		x = 0;
		y = 0;
	}

	public void add(Point otherPoint){
		x += otherPoint.x;
		y += otherPoint.y;
	}

	public void subtract(Point otherPoint){
		x -= otherPoint.x;
		y -= otherPoint.y;
	}

	public double dot(Point otherPoint){
		return this.x*otherPoint.x + this.y*otherPoint.y;
	}

	public double distSquaredTo(Point otherPoint){
		double difX = x - otherPoint.x;
		double difY = y - otherPoint.y;

		return difX*difX + difY*difY;
	}

	public Point copy(){
		Point copy = new Point(x,y);
		return copy;
	}
}