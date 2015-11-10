public class Rectangle{
	public Point upperLeft = new Point(); 

	public double width = 0;
	public double height = 0;

	public Rectangle(upLeftX, upLeftY, theWidth, theHeight){
		upperLeft.x = upLeftX;
		upperLeft.y = upLeftY;

		width = theWidth;
		height = theHeight;
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

	public double area(){
		return width*height;
	}

	public Point center(){
		return new Point(upperLeft.x+width/2, upperLeft.y+height/2);
	}
}