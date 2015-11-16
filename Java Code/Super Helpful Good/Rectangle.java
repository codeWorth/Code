import java.util.ArrayList;

public class Rectangle extends Shape{
	public MyPoint upperLeft = new MyPoint(); 

	public double width = 0;
	public double height = 0;

	private MyPoint[] points;

	@Override
	public MyPoint[] points(){
		points = new MyPoint[] {upperLeft, new MyPoint(upperLeft.x + width, upperLeft.y), new MyPoint(upperLeft.x + width, upperLeft.y + height), new MyPoint(upperLeft.x, upperLeft.y + height)};
		return points;
	}

	@Override
	public boolean set(MyPoint point, int index){ //will expand to new rect, will not contract
		if (index < 0 || index > points.length-1){
			return false;
		}
		points[index] = point;
		setAssocVars();
		return true;
	}

	public Rectangle(double upLeftX, double upLeftY, double theWidth, double theHeight){
		upperLeft.x = upLeftX;
		upperLeft.y = upLeftY;

		width = theWidth;
		height = theHeight;

		points = new MyPoint[] {upperLeft, new MyPoint(upperLeft.x + width, upperLeft.y), new MyPoint(upperLeft.x + width, upperLeft.y + height), new MyPoint(upperLeft.x, upperLeft.y + height)};
	}

	public Rectangle(){
		points = new MyPoint[] {upperLeft, upperLeft.copy(), upperLeft.copy(), upperLeft.copy()};
	}

	public MyPoint lowerLeft(){
		return new MyPoint(upperLeft.x, upperLeft.y - height);
	}


	public double width(){
		double minX = upperLeft.x;
		double maxX = 0;

		for (MyPoint point : points){
			if (point.x < minX){
				minX = point.x;
			}
			if (point.x > maxX){
				maxX = point.x;
			}
		}

		upperLeft.x = minX;

		width = maxX - minX;
		return width;
	}

	public double height(){
		double minY = upperLeft.y;
		double maxY = 0;

		for (MyPoint point : points){
			if (point.y < minY){
				minY = point.y;
			}
			if (point.y > maxY){
				maxY = point.y;
			}
		}

		upperLeft.y = maxY;

		height = maxY - minY;
		return height;
	}

	private void setAssocVars(){
		width();
		height();
	}
	
	public Rectangle copy(){
		Rectangle copied = new Rectangle();
		copied.upperLeft = upperLeft;
		copied.width = width;
		copied.height = height;
		return copied;
	}

	public int amountOnShape(Shape shape){ //returns 0 for none, 1 for partially, and 2 for completely on
		MyPoint upperRight = new MyPoint(upperLeft.x + width, upperLeft.y);
		MyPoint bottomRight = new MyPoint(upperLeft.x + width, upperLeft.y - height);
		MyPoint bottomLeft = new MyPoint(upperLeft.x, upperLeft.y - height);

		int numIn = 0;
		if (shape.isPointWithin(upperLeft.x, upperLeft.y)){
			numIn++;
		}
		if (shape.isPointWithin(upperRight.x, upperRight.y)){
			numIn++;
		}
		if (shape.isPointWithin(bottomLeft.x, bottomLeft.y)){
			numIn++;
		}
		if (shape.isPointWithin(bottomRight.x, bottomRight.y)){
			numIn++;
		}

		if (numIn == 0){
			return 0;
		} else if (numIn == 4){
			return 2;
		} else {
			return 1;
		}
	}

	public MyPoint center(){
		return new MyPoint(upperLeft.x+width/2, upperLeft.y+height/2);
	}

	@Override
	public ArrayList<Shape> shapesInShape(int layersDeep){
		ArrayList<Shape> rect = new ArrayList<Shape>();
		rect.add(this);
		return rect;
	}

	@Override
	public double area(){
		return width*height;
	}

	@Override
	public MyPoint centerOfMass(int accuracy){ 
		return center();
	}

	@Override 
	public boolean isPointWithin(double pointX, double pointY){
		double halfWidth = width/2;
		double halfHeight = height/2;

		double distSquaredX = (pointX - upperLeft.x - halfWidth);
		double distSquaredY = (pointY - upperLeft.y - halfHeight);

		distSquaredX *= distSquaredX;
		distSquaredY *= distSquaredY;

		if (distSquaredX < halfWidth*halfWidth && distSquaredY < halfHeight*halfHeight){
			return true;
		}
		return false;
	}
}
