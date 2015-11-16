public class Segment{
	public MyPoint startPoint = new MyPoint();
	public MyPoint endPoint = new MyPoint();

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
	
		d1 = c - a
		d2 = d - b
	
		d3 = y - w
		d4 = z - x
		
		*/
		double a = startPoint.x;
		double b = startPoint.y;
		double c = endPoint.x;
		double d = endPoint.y;

		double w = otherSeg.startPoint.x;
		double x = otherSeg.startPoint.y;
		double y = otherSeg.endPoint.x;
		double z = otherSeg.endPoint.y;
		
		double d1 = c - a;
		double d2 = d - b;	
		
		double d3 = y - w;
		double d4 = z - x;

		double mainDividend = d3*d2 - d4*d1;

		if (mainDividend == 0){
			return false;
		}

		double n2 = (d1*(x-b) - d2*(w-a))/mainDividend;
		
		double n1 = 0;

		if (d1 == 0){
			n1 = (n2*d4 + x - b)/d2;
		} else {
			n1 = (n2*d3 + w - a)/d1;
		}

		if (n1 >= 0.0 && n1 < 1.0 && n2 > 0.0 && n2 <= 1.0){
			return true;
		}

		return false;
	}

	public void sortByY(){
		if (startPoint.y < endPoint.y){
			MyPoint temp = startPoint.copy();
			startPoint = endPoint.copy();
			endPoint = temp;
		}
	}
}