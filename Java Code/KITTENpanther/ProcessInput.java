public class ProcessInput {
	public static void interpretInput(Tasks tasks, Scanner scanner){
		String in = scanner.nextLine();
		in = in.toLowerCase();

		String[] words = inLower.split(" ");

		if (words.length == 0){
			return;
		}

		String firstWord = words[0];

		if (firstWord.equals("add") || firstWord.equals("addtask")){

			System.out.println("Enter the name: ");
			String theName = scanner.nextLine();

			System.out.println("Enter a description: ");
			String desc = scanner.nextLine();

			System.out.println("Enter the number of days until this is due: ");
			int untilDue = scanner.nextInt();

			System.out.println("Enter the priority: ");
			int prio = scanner.nextInt();

			Task newTask = new Task(theName, desc, prio, untilDue);

			tasks.addtask(newTask);

		} else if (firstWord.equals("today")){

			ProcessInput.printTasks(tasks.tasksForToday());

		} else if (firstWord.equals("all") || firstWord.equals("alltasks")){

			ProcessInput.printTasksWithDue(tasks.allTasks());

		}  else if (firstWord.equals("finish")){

			Task[] tasksInPrintOrder = tasks.allTasks();

			ProcessInput.printTasksWithDue(tasksInPrintOrder);
			System.out.println("Enter the number of the task you want to remove: ");
			int number = scanner.nextInt();

			number--;
			Task toRemove = tasksInPrintOrder[number];
			int taskToEndIndex = indexOfTask(toRemove);
			System.out.println(tasks.finishTask(taskToEndIndex));

		} else if (firstWord.equals("desc") || firstWord.equals("description")){

			Task[] tasksInPrintOrder = tasks.allTasks();

			ProcessInput.printTasksWithDue(tasksInPrintOrder);
			System.out.println("Enter a number of a task, and its description will be shown: ");
			int number = scanner.nextInt();

			number--;
			Task toDesc = tasksInPrintOrder[number];
			int taskToDescIndex = indexOfTask(toDesc);
			System.out.println(tasks.showTaskDesc(taskToDescIndex));

		}
	}

	public static void interpretInput(String in){
		String inLower = in.toLowerCase();
	}

	public static void printTasks(Task[] tasks){
		int i = 1;
		for (Task task : tasks){
			String lePrint = "";

			lePrint = lePrint + i + ". ";

			lePrint = lePrint + task.name + "______________";

			lePrint = lePrint + task.daysUntilDue;

			i++;
			System.out.println (lePrint);

		}
	} 

	public static void printTasksWithDue(Task[] tasks){
		int i = 1;
		for (Task task : tasks){
			String lePrint = "";

			lePrint = lePrint + i + ". ";

			if (daysUntilDue == 1){
				lePrint = lePrint + "!! DUE !! ";
			} else if (daysUntilDue < 1){
				lePrint = lePrint + "!! LATE !! ";
			}


			lePrint = lePrint + task.name + "______________";

			lePrint = lePrint + task.daysUntilDue;

			i++;

			System.out.println (lePrint);
		}
	}
}
  
                             
