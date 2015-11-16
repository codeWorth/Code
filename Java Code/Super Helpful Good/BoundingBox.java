public class BoundingBox{
	public MyPoint upperLeft = new MyPoint();
	public double width = 0;
	public double height = 0;

	public BoundingBox(double upX, double upY, double theWidth, double theHeight){
		upperLeft.x = upX;
		upperLeft.y = upY;
		width = theWidth;
		height = theHeight;
	}
	
	public BoundingBox(){
		
	}
	
	public Rectangle rectForm(){
		return new Rectangle(upperLeft.x, upperLeft.y, width, height);
	}

	public void fitToShape(Shape shape){
		if (shape.points().length > 0){
			MyPoint curPoint = shape.points()[0];

			double maxX = curPoint.x;
			double minX = curPoint.x;

			double maxY = curPoint.y;
			double minY = curPoint.y;

			int i = 1;
			while (i < shape.points().length){
				curPoint = shape.points()[i];

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
				
				i++;
			}

			upperLeft.x = minX;
			upperLeft.y = minY;

			width = maxX - minX;
			height = maxY - minY;
		} else {
			upperLeft.x = 0;
			upperLeft.y = 0;

			width = 0;
			height = 0;
		}
	}
}