import java.util.*;

public class Rectangle extends Shape{
	public Point upperLeft = new Point(); 

	public double width = 0;
	public double height = 0;

	private Point[] points;

	@Override
	public Point[] points(){
		points = new Point[] {upperLeft, new Point(upperLeft.x + width, upperLeft.y), new Point(upperLeft.x + width, upperLeft.y + height), new Point(upperLeft.x, upperLeft.y + height)};
		return points;
	}

	@Override
	public boolean set(Point point, int index){ //will expand to new rect, will not contract
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

		points = new Point[] {upperLeft, new Point(upperLeft.x + width, upperLeft.y), new Point(upperLeft.x + width, upperLeft.y + height), new Point(upperLeft.x, upperLeft.y + height)};
	}

	public Rectangle(){
		points = new Point[] {upperLeft, upperLeft.copy(), upperLeft.copy(), upperLeft.copy()};
	}

	public Point lowerLeft(){
		return new Point(upperLeft.x, upperLeft.y - height);
	}

	public Segment intersectionWithSegment(Segment seg){
		double n1 = -1;
		double n2 = -1;
		double n3 = -1;
		double n4 = -1;

		Segment returnSeg = new Segment();
		boolean firstSet = false;
		boolean secondSet = false;

		/*
		x = n(b_x-a_x)+a_x
		y = n(b_y-a_y)+a_y

		(x-a_x)/(b_x-a_x) = n
		(y-a_y)/(b_y-a_y) = n
		*/

		double difX = seg.endPoint.x - seg.startPoint.x;
		double difY = seg.endPoint.y - seg.startPoint.y;

		if (difX != 0){
			//left side
			n1 = (upperLeft.x-seg.startPoint.x)/difX;

			//right side
			n2 = (upperLeft.x+width-seg.startPoint.x)/difX;
		}

		if (difY != 0){
			//top side
			n3 = (upperLeft.y - seg.startPoint.y)/difY;

			//bottom side
			n4 = (upperLeft.y - height - seg.startPoint.y)/difY;
		}

		if (n1 >= 0 && n1 <= 1){
			returnSeg.startPoint = new Point(upperLeft.x, n1*difY+seg.startPoint.y);
			firstSet = true;
			n1 = -1;
		} else if (n2 >= 0 && n2 <= 1){
			returnSeg.startPoint = new Point(upperLeft.x + width, n2*difY+seg.startPoint.y);
			firstSet = true;
			n2 = -1;
		} else if (n3 >= 0 && n3 <= 1){
			returnSeg.startPoint = new Point(n3*difX+seg.startPoint.x, upperLeft.y);
			firstSet = true;
			n3 = -1;
		} else if (n4 >= 0 && n4 <= 1){
			returnSeg.startPoint = new Point(n3*difX+seg.startPoint.x, upperLeft.y - height);
			firstSet = true;
			n4 = -1;
		} 

		if (n1 >= 0 && n1 <= 1){
			returnSeg.endPoint = new Point(upperLeft.x, n1*difY+seg.startPoint.y);
			secondSet = true;
			n1 = -1;
		} else if (n2 >= 0 && n2 <= 1){
			returnSeg.endPoint = new Point(upperLeft.x + width, n2*difY+seg.startPoint.y);
			secondSet = true;
			n2 = -1;
		} else if (n3 >= 0 && n3 <= 1){
			returnSeg.endPoint = new Point(n3*difX+seg.startPoint.x, upperLeft.y);
			secondSet = true;
			n3 = -1;
		} else if (n4 >= 0 && n4 <= 1){
			returnSeg.endPoint = new Point(n3*difX+seg.startPoint.x, upperLeft.y - height);
			secondSet = true;
			n4 = -1;
		}

		if (firstSet && secondSet){
			return returnSeg;
		} else {
			return null;
		}
	}

	public double width(){
		double minX = upperLeft.x;
		double maxX = 0;

		for (Point point : points){
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

		for (Point point : points){
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

	public int amountOnShape(Shape shape){ //returns 0 for none, 1 for partially, and 2 for completely on
		Point upperRight = new Point(upperLeft.x + width, upperLeft.y);
		Point bottomRight = new Point(upperLeft.x + width, upperLeft.y - height);
		Point bottomLeft = new Point(upperLeft.x, upperLeft.y - height);

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

	public Point center(){
		return new Point(upperLeft.x+width/2, upperLeft.y+height/2);
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
	public Point centerOfMass(int accuracy){ 
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

		if (distSquaredX <= halfWidth*halfWidth && distSquaredY <= halfHeight*halfHeight){
			return true;
		}
		return false;
	}
}