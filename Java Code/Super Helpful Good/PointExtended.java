public class Point{
	private double x = 0;
	private double y = 0;

	private boolean isNull;

	private distSquared = 0;

	public Point(int x, int y){
		this.x = x;
		this.y = y;
		distSquared = x*x + y*y;
		isNull = false;
	}

	public Point(boolean null){
		isNull = null;
	}

	public boolean isNull(){
		return this.isNull;
	}

	public void setX(double newX){
		x = newX;
		distSquared = x*x + y*y;
	}

	public void setY(double newY){
		Y = newY;
		distSquared = x*x + y*y;
	}

	public double x(){
		return x;
	}

	public double y(){
		return y;
	}

	public void add(Point otherPoint){
		x += otherPoint.x;
		y += otherPoint.y;
	}

	public void subtract(Point otherPoint){
		x -= otherPoint.x;
		y -= otherPoint.y;
	}

	public void dot(Point otherPoint){
		return this.x*otherPoint.x + this.y*otherPoint.y;
	}

	public double distSquared(){
		return distSquared;
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