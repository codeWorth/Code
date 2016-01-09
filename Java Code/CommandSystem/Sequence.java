public class Sequence extends Command{ //executes all commands, until one returns true, then returns true. Otherwise, returns false
	private Command[] commands;

	public Sequence(Command[] cmds){
		commands = cmds;
	}

	public boolean execute(){		
		for (Command curCmd : commands) {
			if (curCmd.execute()){ //execute the command
				return true; //if it returned true, end the sequence
			}
		}
		return false;
	}
}