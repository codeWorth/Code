public class Segment{
	public Point startPoint = new Point();
	public Point endPoint = new Point();

	public Segment(double endX, double endY){
		endPoint.x = endX;
		endPoint.y = endY;
	}

	public Segment(double startX, double startY, double endX, double endY){
		startPoint.x = startX;
		startPoint.y = startY;

		endPoint.x = endX;
		endPoint.y = endY;
	}

	public Segment(){

	}

	public boolean intersectsSegment(Segment otherSeg){
		/*
		   us
		a = startX
		b = startY
		c = endX
		d = endY

		   them
		w = otherSeg.startX
		x = otherSeg.startY
		y = otherSeg.endX
		z = otherSeg.endY
	
		x = n1(c - a) + a
		y = n1(d - b) + b

		x = n2(y - w) + w
		y = n2(z - x) + x

		n2(y - w) + w = n1(c - a) + a
		n2(d - b) + b = n1(z - x) + x

		n2(y - w) = n1(c - a) + a - w
		n2(d - b) = n1(z - x) + x - b

		n2 = (n1(c - a) + a - w)/(y - w)
		n2 = (n1(z - x) + x - b)/(d - b)
		(n1(c - a) + a - w)/(y - w) = (n1(z - x) + x - b)/(d - b)
		(y - w)*(n1(z - x) + x - b) = (d - b)*(n1(c - a) + a - w)
		n1((y-w)(z-x) - (d-b)(c-a)) = (a-w)(d-b) - (x-b)(y-w)
		n1 = ((a-w)(d-b) - (x-b)(y-w))/((y-w)(z-x) - (d-b)(c-a))

		n2 = (n1(c - a) + a - w)(y - w)
		*/
		double a = startPoint.x;
		double b = startPoint.y;
		double c = endPoint.x;
		double d = endPoint.y;

		double w = otherSeg.startPoint.x;
		double x = otherSeg.startPoint.y;
		double y = otherSeg.endPoint.x;
		double z = otherSeg.endPoint.y;

		double mainDividend = (y-w)*(z-x) - (d-b)*(c-a);

		if (mainDividend == 0){
			return false;
		}

		double n1 = ((a-w)*(d-b) - (x-b)*(y-w))/mainDividend;

		double otherDividend = y-w;

		if (otherDividend == 0){
			return false;
		}

		double n2 = (n1*(c-a) + a - w)/otherDividend;

		if (n1 >= 0 && n1 < 1 && n2 >= 0 && n2 < 1){
			return true;
		}

		return false;
	}

	public void sortByY(){
		if (startPoint.y < endPoint.y){
			Point temp = startPoint.copy();
			startPoint = endPoint.copy();
			endPoint = temp;
		}
	}
}