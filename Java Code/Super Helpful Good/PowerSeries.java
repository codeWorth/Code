public class PowerSeries{
	public double[] coefficients;
	public int startPower = 0;

	public PowerSeries(){
		coefficients = {0};
	}

	public PowerSeries(double[] coeffs){
		coefficients = coeffs;
	}

	public PowerSeries(double[] coeffs, int startPow){
		coefficients = coeffs;
		startPower = startPow;
	}

	public PowerSeries(Point[] points){
		
	}

	public double yAt(double x){
		double pos = 0;
		int currentPow = 0;
		for (int i = 0; i < coefficients.length; i++){
			currentPow = i - startPower;
			if (currentPow < 0 && x == 0 && coefficients[i] != 0){
				return 0;
			} else {
				pos += power(currentPow, x) * coefficients[i];
			}
		}
		return pos;
	}

	private double power(int power, double val){
		double mult = val;
		if (power < 0){
			for (int i = -1; i > power; i--){
				mult *= val;
			}
			return 1/mult;
		} else {
			for (int i = 1; i < power; i++){
				mult *= val;
			}
			return mult;
		}
	}
}