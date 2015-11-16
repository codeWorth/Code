public class Line{
	public double slope = 0;
	public PointExtended point;

	private double yIntercept = 0;

	public Line(){
		slope = 0;
		point = new PointExtended();
		yIntercept = 0;
	}

	public Line(double slope, PointExtended point){
		this.slope = slope;
		this.point = point;

		yIntercept = point.y() - slope * point.x();
	}

	public Line(double slope){
		this.slope = slope;
		point = new PointExtended();
	}

	public Line(PointExtended point){
		this.point = point;

		yIntercept = point.y();
	}

	public PointExtended intercept(Line otherLine){
		/*
		m(x-x1)+y1=n(x-x2)+y2
		mx - mx1 + y1 = nx - nx2 + y2
		mx - nx = -nx2 + mx1 - y1 + y2
		x(m-n) = -nx2 + mx1 - y1 + y2
		x = (mx1 - nx2 + y2 - y1)/(m-n)
		*/
		double over = slope - otherLine.slope;

		if (over == 0){
			return new PointExtended(true);
		}

		double intX = (slope * this.point.x() - otherLine.slope * otherLine.point.x() + otherLine.point.y() - this.point.y())/over;
		double intY = this.yAt(intX);

		return new PointExtended(intX, intY);
	}

	public double yAt(double x){
		return slope * (x - point.x()) + point.y();
	}
}