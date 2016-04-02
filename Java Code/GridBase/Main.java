import Grid.Grid;
import MassObjects.MassObject;

public class Main {
	public static void main(String[] args){
		Grid grid = new Grid();
		
		MassObject obj1 = new MassObject(grid, 2, 2, 5, 6);
		grid.addGridObject(obj1);
		
		MassObject obj2 = new MassObject(grid, 8, 3, 3, 2);
		grid.addGridObject(obj2);
		
		//shouldn't get added
		MassObject obj3 = new MassObject(grid, 4, 4, 2, 5);
		grid.addGridObject(obj3);
		
		grid.print();
	}
}
