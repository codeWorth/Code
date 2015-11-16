import java.util.ArrayList;

public class Shape{

	private final int defaultLayers = 3;
	private MyPoint[] points;

	public MyPoint[] points(){
		return points;
	}

	public boolean set(MyPoint point, int index){
		if (index < 0 || index > points.length-1){
			return false;
		}
		points[index] = point;
		setAssocVars();
		return true;
	}


	private BoundingBox boundingBox = new BoundingBox();

	public Shape(MyPoint[] pointsToAdd){
		points = new MyPoint[pointsToAdd.length];
		int i = 0;
		for (MyPoint point : pointsToAdd){
			points[i] = point.copy();
			i++;
		}
		setAssocVars();
	}

	public Shape(int vertecies){
		if (vertecies < 3){
			vertecies = 3;
		}
		points = new MyPoint[vertecies];
		for (int i = 0; i < vertecies; i++){
			points[i] = new MyPoint();
		}
		setAssocVars();
	}

	public Shape(){
		points = new MyPoint[3];
	}

	public boolean isPointWithin(double pointX, double pointY){
		Segment ray = new Segment(boundingBox.upperLeft.x-1, boundingBox.upperLeft.y+1, pointX, pointY);
		Segment shapeSection;

		if (points.length == 0){
			return false;
		} 

		MyPoint curPoint = points[0];

		if (points.length == 1){
			return (curPoint.x == pointX && curPoint.y == pointY);
		} else if (points.length == 2){
			shapeSection = new Segment(curPoint.x, curPoint.y, points[1].x, points[1].y);
			return ray.intersectsSegment(shapeSection);
		} else {
			shapeSection = new Segment();

			int hitCount = 0;

			MyPoint nextPoint;

			for (int i = 0; i < points.length-1; i++){
				curPoint = points[i];
				nextPoint = points[i+1];

				shapeSection.startPoint = curPoint;
				shapeSection.endPoint = nextPoint;

				if (ray.intersectsSegment(shapeSection)){
					hitCount++;
				}
			}

			curPoint = points[points.length-1];
			nextPoint = points[0];

			shapeSection.startPoint = curPoint;
			shapeSection.endPoint = nextPoint;

			if (ray.intersectsSegment(shapeSection)){
				hitCount++;
			}

			return (hitCount % 2 != 0);
		}
	}

	public ArrayList<Shape> shapesInShape(int layersDeep){
		return subdivideRect(0, layersDeep, boundingBox.rectForm());
	}

	public double area(){
		double area = 0;
		ArrayList<Shape> rects = shapesInShape(defaultLayers);

		for (Shape shape : rects){
			area += shape.area();
		}

		return area;
	}

	public MyPoint centerOfMass(int accuracy){ //assumes shape is homogenious (no varying density within). 1 is least accuracte, don't go too high (more than 10?) if you don't want to kill the computer
		ArrayList<Shape> shapes = shapesInShape(accuracy);

		double topSumX = 0;
		double topSumY = 0;
		double totalMass = 0;

		MyPoint thisCenter;

		for (Shape shape : shapes){
			thisCenter = shape.centerOfMass(defaultLayers);

			topSumX += shape.area()*thisCenter.x;
			topSumY += shape.area()*thisCenter.y;

			totalMass += shape.area();
		}

		MyPoint centerOMass = new MyPoint(topSumX/totalMass, topSumY/totalMass);

		return centerOMass;
	}

	private ArrayList<Shape> subdivideRect(int curLayer, int maxLayers, Rectangle toDivide){
		if (curLayer == maxLayers){
			return new ArrayList<Shape>();
		} else {
			Segment cutOff = null;
			Segment curSeg = new Segment();

			for (int i = 0; i < points.length-1; i++){
				curSeg.startPoint = points[i];
				curSeg.endPoint = points[i+1];
				cutOff = toDivide.intersectionWithSegment(curSeg);
				if (cutOff != null){
					break;
				}
			}

			ArrayList<Shape> shapes = new ArrayList<Shape>();

			if (cutOff != null){
				cutOff.sortByY();

				Trapezoid caseOne = new Trapezoid();
				caseOne.upperLeft = toDivide.upperLeft;
				caseOne.lowerLeft = toDivide.lowerLeft();
				caseOne.upWidth = toDivide.upperLeft.x - curSeg.startPoint.x;
				caseOne.downWidth = toDivide.upperLeft.x - curSeg.endPoint.x;

				Trapezoid caseTwo = new Trapezoid();
				caseTwo.upperLeft = curSeg.startPoint;
				caseTwo.lowerLeft = curSeg.endPoint;
				caseTwo.upWidth = toDivide.upperLeft.x + toDivide.width - caseTwo.upperLeft.x;
				caseTwo.downWidth = toDivide.upperLeft.x + toDivide.width - caseTwo.lowerLeft.x;

				MyPoint caseOneCenter = caseOne.centerOfMass(0);
				MyPoint caseTwoCenter = caseTwo.centerOfMass(0);

				if (isPointWithin(caseOneCenter.x, caseOneCenter.y)){
					shapes.add(caseOne);
					return shapes;
				} else if (isPointWithin(caseTwoCenter.x, caseTwoCenter.y)){
					shapes.add(caseTwo);
					return shapes;
				}
			}

			double halfWidth = toDivide.width/2;
			double halfHeight = toDivide.height/2;

			Rectangle upLeft = new Rectangle(toDivide.upperLeft.x, toDivide.upperLeft.y, halfWidth, halfHeight);
			Rectangle upRight = new Rectangle(toDivide.upperLeft.x+halfWidth, toDivide.upperLeft.y, halfWidth, halfHeight);
			Rectangle downLeft = new Rectangle(toDivide.upperLeft.x, toDivide.upperLeft.y+halfHeight, halfWidth, halfHeight);
			Rectangle downRight = new Rectangle(toDivide.upperLeft.x+halfWidth, toDivide.upperLeft.y+halfHeight, halfWidth, halfHeight);

			int rectScore = upLeft.amountOnShape(this);
			if (rectScore == 2){
				shapes.add(upLeft);
			} else if (rectScore == 1){
				shapes.addAll(subdivideRect(curLayer+1, maxLayers, upLeft));
			}

			rectScore = upRight.amountOnShape(this);
			if (rectScore == 2){
				shapes.add(upRight);
			} else if (rectScore == 1){
				shapes.addAll(subdivideRect(curLayer+1, maxLayers, upRight));
			}

			rectScore = downLeft.amountOnShape(this);
			if (rectScore == 2){
				shapes.add(downLeft);
			} else if (rectScore == 1){
				shapes.addAll(subdivideRect(curLayer+1, maxLayers, downLeft));
			}

			rectScore = downRight.amountOnShape(this);
			if (rectScore == 2){
				shapes.add(downRight);
			} else if (rectScore == 1){
				shapes.addAll(subdivideRect(curLayer+1, maxLayers, downRight));
			}

			return shapes;
		}
	}

	private void setAssocVars(){
		boundingBox.fitToShape(this);
	}
}