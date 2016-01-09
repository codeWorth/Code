public class Combination extends Command{ //executes commands until one returns false, and then returns false. Otherwise, returns false
	private Command[] commands;

	public Combination(Command[] cmds){
		commands = cmds;
	}

	public boolean execute(){
		for (Command curCmd : commands) {
			if (!curCmd.execute()){ //execute the command
				return false; //if it returned false, end the combination
			}
		}
		return true;
	}
}