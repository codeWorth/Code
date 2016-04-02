package Grid;
import java.util.ArrayList;

import MassObjects.MassObject;
import MasslessObjects.MasslessObject;

public class Grid{
	private ArrayList<GridObject> objects =  new ArrayList<GridObject>(); 
	
	public boolean addGridObject(GridObject object){
		if (object instanceof MassObject){
			MassObject obj = (MassObject)object;
			if (canFit(obj)){
				objects.add(obj);
				return true;
			} else {
				return false;
			}
		} else if (object instanceof MasslessObject){
			MasslessObject obj = (MasslessObject)object;
			objects.add(obj);
			return true;
		} else {
			return false;
		}
	}
	
	private boolean canFit(MassObject object){
		for (GridObject thisObj : objects){
			if (thisObj instanceof MassObject){
				MassObject obj = (MassObject)thisObj;
				if (obj.overlapsObject(object)){
					return false;
				}
			}
		}
		
		return true;
	}
	
	public int width(){
		if (objects.size() == 0){
			return 0;
		} 
		int maxX = objects.get(0).position.x;
		
		for (GridObject obj : objects){
			if (obj instanceof MassObject){
				MassObject object = (MassObject)obj;
				if (object.topRight() > maxX){
					maxX = object.topRight();
				}
			} else {
				if (obj.position.y > maxX){
					maxX = obj.position.x;
				}
			}
		}
		
		return maxX;
	}
	
	public int height(){
		if (objects.size() == 0){
			return 0;
		} 
		int maxY = objects.get(0).position.y;
		
		for (GridObject obj : objects){
			if (obj instanceof MassObject){
				MassObject object = (MassObject)obj;
				if (object.bottomLeft() > maxY){
					maxY = object.bottomLeft();
				}
			} else {
				if (obj.position.y > maxY){
					maxY = obj.position.y;
				}
			}
		}
		
		return maxY;
	}
	
	public void print(){
		int[][] map = map();
		
		for (int i = 0; i < map.length; i++){
			for (int j = 0; j < map[i].length; j++){
				System.out.print(map[i][j] + " ");
			}
			System.out.println("");
		}
	}
	
	private int[][] map(){
		int[][] map = new int[width()][height()];
		
		System.out.println("Width: " + width());
		System.out.println("Height: " + height());
		
		for (GridObject obj : objects){
			if (obj instanceof MassObject){
				MassObject object = (MassObject)obj;
				for (int i = 0; i < object.width; i++){
					for (int j = 0; j < object.height; j++){
						map[i+obj.position.x][j+obj.position.y]++;
					}
				}
			}
		}
		
		return map;
	}
}