public class Inverse extends Command{ //execute the command and return its inverse
	private Command command;

	public Inverse(Command cmd){
		command = cmd;
	}

	public boolean execute(){
		return !command.execute(); //execute and return the inverse
	}
}