public class Move extends Routine{
	private int rotations = 0;
	private double power = 1;

	private double startDist = 0;

	private DcMotor leftBackMotor;
	private DcMotor rightBacKMotor;

	private DcMotor leftFrontMotor;
	private DcMotor rightFrontMotor;

	private int leftStart = 0;
	private int rightStart = 0;

	private boolean rigthShouldMove = true;
	private boolean leftShouldMove = true;

	public Move(int rots, double pwr,  HardwareMap map){
		rotations = rots;
		power = pwr;

		leftBackMotor = map.dcMotor.get("leftBack");
		rightBacKMotor = map.dcMotor.get("rightBack");

		leftFrontMotor = map.dcMotor.get("leftFront");
		rightFrontMotor = map.dcMotor.get("rightFront");

		leftStart = leftBackMotor.getCurrentPosition();
		rightStart = rightBacKMotor.getCurrentPosition();
	}

	public boolean update(){
		if (leftShouldMove){
			leftBackMotor.setPower(power);
			leftFrontMotor.setPower(power);
		}

		if (rightShouldMove){
			rightBacKMotor.setPower(power);
			rightFrontMotor.setPower(power);
		}

		return isFinished();
	}

	private boolean isFinished(){
		int leftRotChange = leftBackMotor.getCurrentPosition() - leftStart;
		int rightRotChange = rightBacKMotor.getCurrentPosition() - rightStart;

		if (leftRotChange >= rotations){
			leftShouldMove = false;
		}
		if (rightRotChange >= rotations){
			rightShouldMove = false;
		}

		return !(leftShouldMove || rightShouldMove);
	}
}
