package MasslessObjects;
import Grid.Grid;
import Grid.GridObject;

public class MasslessObject extends GridObject{
	public MasslessObject(Grid parent, int _x, int _y){
		super(parent);
		position.x = _x;
		position.y = _y;
	}
}