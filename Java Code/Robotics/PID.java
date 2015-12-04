public class PID{
	public Motor leftMotor;
	public Motor rightMotor;

	private final String LEFT_MOTOR_NAME "left";
	private final String RIGHT_MOTOR_NAME = "right";

	public boolean isRightSlaved = true;

	public final double k = 1.0;

	public PID(HardwareMap hardwareMap){
		leftMotor = hardwareMap.dcMotor.get(LEFT_MOTOR_NAME);
        rightMotor = hardwareMap.dcMotor.get(RIGHT_MOTOR_NAME);
	}

	public void update(){
		int slaveEncVal;
		int masterEncVal;

		int slaveMotor;
		int masterMotor;

		if (isRightSlaved){
			slaveEncVal = rightEncoder();
			masterEncVal = leftEncoder();

			slaveMotor = rightMotor;
			masterMotor = leftMotor;
		} else {
			slaveEncVal = leftEncoder();
			masterEncVal = rightEncoder();

			slaveMotor = leftMotor;
			masterMotor = rightMotor;
		}

		double masterSlaveRatio = masterEncVal/slaveEncVal;
		double slaveChange = (masterSlaveRatio - 1)
	}

	public int leftEncoder(){
		return leftMotor.getCurrentPosition();
	}

	public int rightEncoder(){
		return rightMotor.getCurrentPosition();
	}
}
