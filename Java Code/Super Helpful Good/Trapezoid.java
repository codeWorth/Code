
public class Trapezoid extends Shape{
	public MyPoint upperLeft = new MyPoint(); 
	public MyPoint lowerLeft = new MyPoint(); 

	public double upWidth = 0;
	public double downWidth = 0;

	private MyPoint[] points;

	@Override
	public MyPoint[] points(){
		points = new MyPoint[] {upperLeft, lowerLeft, new MyPoint(upperLeft.x + upWidth, upperLeft.y), new MyPoint(lowerLeft.x + downWidth, lowerLeft.y)};
		return points;
	}

	@Override
	public boolean set(MyPoint point, int index){ //will expand to become largest possible trapezoid. Maximum Y will become upperLeft's y, minimum Y will become lowerLeft's y. upWidth will be top point and second to top point, the inverse with downWidth
		if (index < 0 || index > points.length-1){
			return false;
		}
		points[index] = point;
		setAssocVars();
		return true;
	}

	public Trapezoid(MyPoint upPoint, MyPoint downPoint, double lowWidth, double highWidth){
		upperLeft = upPoint.copy();
		lowerLeft = downPoint.copy();

		upWidth = highWidth;
		downWidth = lowWidth;

		points = new MyPoint[] {upperLeft, lowerLeft, new MyPoint(upperLeft.x + upWidth, upperLeft.y), new MyPoint(lowerLeft.x + downWidth, lowerLeft.y)};
	}

	public Trapezoid(){
	}

	private void setAssocVars(){
		MyPoint maxY = maxY();
		MyPoint minY = minY();

		MyPoint secondMaxPoint = new MyPoint();
		MyPoint secondMinPoint = new MyPoint();

		for (MyPoint point : points){
			if (point.y != minY.y && point.y != maxY.y){
				secondMaxPoint.y = point.y;
				break;
			}
		}

		for (MyPoint point : points){
			if (point.y != minY.y && point.y != maxY.y && point.y != secondMaxPoint.y){
				secondMinPoint.y = point.y;
				break;
			}
		}

		if (secondMaxPoint.y < secondMinPoint.y){
			MyPoint temp = secondMaxPoint.copy();
			secondMaxPoint = secondMinPoint.copy();
			secondMinPoint = temp;
		}

		upperLeft.y = maxY.y;
		if (secondMaxPoint.x < maxY.x){
			upperLeft.x = secondMaxPoint.x;
			upWidth = maxY.x - upperLeft.x;
		} else {
			upperLeft.x = maxY.x;
			upWidth = secondMaxPoint.x - upperLeft.x;
		}

		lowerLeft.y = minY.y;
		if (secondMinPoint.x < minY.x){
			lowerLeft.x = secondMinPoint.x;
			downWidth = minY.x - lowerLeft.x;
		} else {
			lowerLeft.x = maxY.x;
			downWidth = secondMinPoint.x - lowerLeft.x;
		}
	}

	private MyPoint minY(){
		MyPoint minY = points[0];

		for (MyPoint point : points){
			if (point.y < minY.y){
				minY = point;
			}
		}

		return minY.copy();
	}

	private MyPoint maxY(){
		MyPoint maxY = points[0];

		for (MyPoint point : points){
			if (point.y > maxY.y){
				maxY = point;
			}
		}

		return maxY.copy();
	}

	@Override
	public double area(){
		return 0.5*(upWidth+downWidth)*(upperLeft.y - lowerLeft.y);
	}

	@Override
	public boolean isPointWithin(double pointX, double pointY){
		if (pointY < lowerLeft.y || pointY > upperLeft.y){
			return false;
		}
		if (lowerLeft.y == upperLeft.y){
			return (pointY == lowerLeft.y);
		}
		double maxX = upperLeft.x;
		double minWidth = upWidth;

		if (lowerLeft.x > maxX){
			maxX = lowerLeft.x;
		}
		if (downWidth > minWidth){
			minWidth = downWidth;
		}

		if (pointX < maxX){
			double height = upperLeft.y - lowerLeft.y;

			double n = (pointY - lowerLeft.y)/height;
			double x = n*(upperLeft.x - lowerLeft.x) + lowerLeft.x;

			if (pointX > x){
				return true;
			} else {
				return false;
			}
 		} else if (pointX > maxX + minWidth){
			double height = upperLeft.y - lowerLeft.y;

			double n = (pointY - lowerLeft.y)/height;
			double x = n*(upperLeft.x + upWidth - lowerLeft.x - downWidth) + lowerLeft.x + downWidth;

			if (pointX < x){
				return true;
			} else {
				return false;
			}
		} else {
			return true;
		}
	}

	@Override
	public MyPoint centerOfMass(int accuracy){ 
		double y = upperLeft.y + lowerLeft.y;
		y *= 0.5;

		double x1 = upperLeft.x + lowerLeft.x;
		x1 *= 0.5;
		double x2 = upperLeft.x + lowerLeft.x + upWidth + downWidth;
		x2 *= 0.5;

		double x = x1 + x2;
		x *= 0.5;

		return new MyPoint(x, y);
	}
}