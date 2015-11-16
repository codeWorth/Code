public class PointExtended{
	private double x = 0;
	private double y = 0;

	private boolean isNull;

	private double distSquared = 0;

	public PointExtended(double x, double y){
		this.x = x;
		this.y = y;
		distSquared = x*x + y*y;
		isNull = false;
	}

	public PointExtended(boolean isItNull){
		isNull = isItNull;
	}
	
	public PointExtended(){
		isNull = false;
	}

	public boolean isNull(){
		return this.isNull;
	}

	public void setX(double newX){
		x = newX;
		distSquared = x*x + y*y;
	}

	public void setY(double newY){
		y = newY;
		distSquared = x*x + y*y;
	}

	public double x(){
		return x;
	}

	public double y(){
		return y;
	}

	public void add(PointExtended otherPoint){
		x += otherPoint.x;
		y += otherPoint.y;
	}

	public void subtract(PointExtended otherPoint){
		x -= otherPoint.x;
		y -= otherPoint.y;
	}

	public double dot(PointExtended otherPoint){
		return this.x*otherPoint.x + this.y*otherPoint.y;
	}

	public double distSquared(){
		return distSquared;
	}

	public double distSquaredTo(PointExtended otherPoint){
		double difX = x - otherPoint.x;
		double difY = y - otherPoint.y;

		return difX*difX + difY*difY;
	}

	public PointExtended copy(){
		PointExtended copy = new PointExtended(x,y);
		return copy;
	}
}