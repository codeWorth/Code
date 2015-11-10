public class Shape{
	private ArrayList<Point> points;

	public ArrayList<Point> points(){
		return points;
	}

	public void addPoint(Point point){
		points.add(point.copy());
		setBoundingBox();
	}

	public boolean removePoint(int indexOfPoint){
		if (indexOfPoint < 0 || indexOfPoint >= points.size()){
			return false;
		} else {
			points.remove(indexOfPoint);
			setBoundingBox();
			return true;
		}
	}


	private Rectangle boundingBox = new Rectangle;

	public Shape(Point[] pointsToAdd){
		for (Point point : pointsToAdd){
			points.add(point.copy());
		}
		setBoundingBox();
	}

	public Shape(){
		points = new ArrayList<Point>();
	}

	public boolean isPointWithin(int pointX, int pointY){
		Segment ray = new Segment(boundingBox.upperLeft.x-1, boundingBox.upperLeft.y+1, pointX, pointY);
		Segment shapeSection;

		Point outPoint = new Point(-1, -1);

		if (points.size() == 0){
			return false;
		} 

		Point curPoint = points.get(0);

		if (points.size() == 1){
			return (curPoint.x == pointX && curPoint.y == pointY);
		} else if (points.size() == 2){
			shapeSection = new Segment(curPoint.x, curPoint.y, points.get(1).x, points.get(1).y);
			return ray.intersectsSegment(shapeSection);
		} else {
			int length = points.size();
			shapeSection = new Segment();

			int hitCount = 0;

			Point nextPoint;

			for (int i = 0; i < length-1; i++){
				curPoint = points.get(i);
				nextPoint = points.get(i+1);

				shapeSection.startPoint = curPoint;
				shapeSection.endPoint = nextPoint;

				if (ray.intersectsSegment(shapeSection)){
					hitCount++;
				}
			}

			curPoint = points.get(length-1);
			nextPoint = points.get(0);

			shapeSection.startPoint = curPoint;
			shapeSection.endPoint = nextPoint;

			if (ray.intersectsSegment(shapeSection)){
				hitCount++;
			}

			return (hitCount % 2 != 0);
		}
	}

	public ArrayList<Rectangle> rectanglesInShape(int layersDeep){
		return subdivideRect(0, layersDeep, boundingBox);
	}

	public Point centerOfMass(int accuracy){ //assumes shape is homogenious (no varying density within). 1 is least accuracte, don't go too high (more than 10?) if you don't want to kill the computer
		ArrayList<Rectangle> rects = rectanglesInShape(accuracy);

		double topSumX = 0;
		double topSumY = 0;
		double totalMass = 0;

		Point thisCenter;

		for (Rectangle rect : rects){
			thisCenter = rect.center();

			topSumX += rect.area()*thisCenter.x;
			topSumY += rect.area()*thisCenter.y;

			totalMass += rect.area();
		}

		Point centerOMass = new Point(topSumX/totalMass, topSumY/totalMass);
	}

	private ArrayList<Rectangle> subdivideRect(int curLayer, int maxLayers, Rectangle toDivide){
		if (curLayer == maxLayers){
			return new ArrayList<Rectangle>();
		} else {
			ArrayList<Rectangle> rects = new ArrayList<Rectangle>();

			double halfWidth = toDivide.width/2;
			double halfHeight = toDivide.height/2;

			Rectangle upLeft = new Rectangle(toDivide.upperLeft.x, toDivide.upperLeft.y, halfWidth, halfHeight);
			Rectangle upRight = new Rectangle(toDivide.upperLeft.x+halfWidth, toDivide.upperLeft.y, halfWidth, halfHeight);
			Rectangle downLeft = new Rectangle(toDivide.upperLeft.x, toDivide.upperLeft.y+halfHeight, halfWidth, halfHeight);
			Rectangle downRight = new Rectangle(toDivide.upperLeft.x+halfWidth, toDivide.upperLeft.y+halfHeight, halfWidth, halfHeight);

			int rectScore = upLeft.amountOnShape(this);
			if (rectScore == 2){
				rects.add(upLeft);
			} else if (rectScore == 1){
				rects.addAll(subdivideRect(curLayer+1, maxLayers, upLeft));
			}

			rectScore = upRight.amountOnShape(this);
			if (rectScore == 2){
				rects.add(upRight);
			} else if (rectScore == 1){
				rects.addAll(subdivideRect(curLayer+1, maxLayers, upRight));
			}

			rectScore = downLeft.amountOnShape(this);
			if (rectScore == 2){
				rects.add(downLeft);
			} else if (rectScore == 1){
				rects.addAll(subdivideRect(curLayer+1, maxLayers, downLeft));
			}

			rectScore = downRight.amountOnShape(this);
			if (rectScore == 2){
				rects.add(downRight);
			} else if (rectScore == 1){
				rects.addAll(subdivideRect(curLayer+1, maxLayers, downRight));
			}
		}
	}

	private void setBoundingBox(){
		if (points.size() > 0){
			Point curPoint = points.get(0);

			double maxX = curPoint.x;
			double minX = curPoint.x;

			double maxY = curPoint.y;
			double minY = curPoint.y;

			int i = 1;
			while (i < points.size()){
				curPoint = points.get(i);

				if (curPoint.x > maxX){
					maxX = curPoint.x;
				}
				if (curPoint.y > maxY){
					maxY = curPoint.y;
				}

				if (curPoint.x < minX){
					minX = curPoint.x;
				}
				if (curPoint.y < minY){
					minY = curPoint.y;
				}
			}

			boundingBox.upperLeft.x = minX;
			boundingBox.upperLeft.y = minY;

			boundingBox.width = maxX - minX;
			boundingBox.height = maxY - minY;
		} else {
			boundingBox.upperLeft.x = 0;
			boundingBox.upperLeft.y = 0;

			boundingBox.width = 0;
			boundingBox.height = 0;
		}
	}
}