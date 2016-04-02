package Grid;
import Utitlity.Position;

public class GridObject{
	public Position position = new Position();
	public Grid parentGrid;
	
	public GridObject(Grid parent){
		parentGrid = parent;
	}
}