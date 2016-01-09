public class Transfer extends Command{ //simply execute given command, and return result
	private Command command;

	public Transfer(Command cmd){
		command = cmd;
	}

	public boolean execute(){
		return command.execute();
	}
}