public class Field{
	private Player[][] field;

	private int width = 0;
	private int height = 0;

	public Field(int newW, int newH){
		if (newW > 0){
			width = newW;
		}
		if (newH > 0){
			height = newH;
		}

		field = new Player[width][height];
	}

	public boolean addPlayer(Player player, int x, int y){
		if (x < 0 || x >= width || y < 0 || y >= height){ //if place out of bounds, exit
			return false;
		}
		if (field[x][y] != null){ //if spot is taken, exit
			return false;
		}

		field[x][y] = player; //add player
		return true;
	}

	public boolean movePlayerUp(int x, int y){
		if (x < 0 || x >= width || y <= 0 || y >= height){ //if place out of bounds, exit (check y == 0 because we are going to try to move up)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x][y-1] != null){ //if new spot is taken, exit
			return false;
		}

		field[x][y-1] = field[x][y].copy(); //copy player one up (-1 because 0, 0 is upper left)
		field[x][y] = null; //remove old spot

		return true;
	}

	public boolean movePlayerDown(int x, int y){
		if (x < 0 || x >= width || y < 0 || y >= height - 1){ //if place out of bounds, exit (-1 on height because we are going to try to move down)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x][y+1] != null){ //if new spot is taken, exit
			return false;
		}

		field[x][y+1] = field[x][y].copy(); //copy player one up (+1 because 0, 0 is upper left)
		field[x][y] = null; //remove old spot

		return true;
	}

	public boolean movePlayerLeft(int x, int y){
		if (x <= 0 || x >= width || y < 0 || y >= height){ //if place out of bounds, exit (check x == 0 because we are going to try to move left)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x-1][y] != null){ //if new spot is taken, exit
			return false;
		}

		field[x-1][y] = field[x][y].copy(); //copy player one up
		field[x][y] = null; //remove old spot

		return true;
	}

	public boolean movePlayerRight(int x, int y){
		if (x < 0 || x >= width - 1 || y < 0 || y >= height){ //if place out of bounds, exit (-1 on width because we are going to try to move right)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x+1][y] != null){ //if new spot is taken, exit
			return false;
		}

		field[x+1][y] = field[x][y].copy(); //copy player one up
		field[x][y] = null; //remove old spot

		return true;
	}


	private Player killPlayer(int x, int y){ //the player that died, or null if the player didn't die
		if (x < 0 || x >= width || y < 0 || y >= height){ //if place out of bounds, exit
			return null;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return null;
		}

		if(field[x][y].die()){
			return null;
		} 

		Player deadGuy = field[x][y].copy();
		field[x][y] = null;
		return deadGuy;
	}


	public boolean playerAttackUp(int x, int y, int damage){ //returns false if the attack failed
		if (x < 0 || x >= width || y <= 0 || y >= height){ //if place out of bounds, exit (check y == 0 because we are going to try to attack up)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x][y-1] == null){ //if place to attack is empty, ignore it
			return true;
		}

		Player killedGuy = field[x][y-1].takeDamage(x, y-1, damage);
		if (killedGuy != null){ //if the enemy player died, HANDLE IT
			field[x][y].killedEnemy(killedGuy);
		}

		return true;
	}

	public boolean playerAttackDown(int x, int y, int damage){
		if (x < 0 || x >= width || y < 0 || y >= height - 1){ //if place out of bounds, exit (-1 on height because we are going to try to attack down)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x][y+1] == null){ //if place to attack is empty, ignore it
			return true;
		}

		Player killedGuy = field[x][y+1].takeDamage(x, y+1, damage);
		if (killedGuy != null){ //if the enemy player died, HANDLE IT
			field[x][y].killedEnemy(killedGuy);
		}

		return true;
	}

	public boolean playerAttackLeft(int x, int y, int damage){
		if (x <= 0 || x >= width || y < 0 || y >= height){ //if place out of bounds, exit (check x == 0 because we are going to try to attack left)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x-1][y] == null){ //if place to attack is empty, ignore it
			return true;
		}

		Player killedGuy = field[x-1][y].takeDamage(x-1, y, damage);
		if (killedGuy != null){ //if the enemy player died, HANDLE IT
			field[x][y].killedEnemy(killedGuy);
		}    q

		return true;
	}

	public boolean playerAttackRight(int x, int y, int damage){
		if (x < 0 || x >= width - 1 || y < 0 || y >= height){ //if place out of bounds, exit (-1 on width because we are going to try to attack right)
			return false;
		}
		if (field[x][y] == null){ //if spot is empty, exit
			return false;
		}
		if (field[x+1][y] == null){ //if place to attack is empty, ignore it
			return true;
		}

		Player killedGuy = field[x+1][y].takeDamage(x+1, y, damage);
		if (killedGuy != null){ //if the enemy player died, HANDLE IT
			field[x][y].killedEnemy(killedGuy);
		}

		return true;
	}


	public Player[][] getField(){
		return field;
	}


	public void printField(){
		int cellWidth = 1;

		double yToXRatio = 0.5; //x * 0.5 = y
		int cellHeight = cellWidth * yToXRatio;

		cellWidth += 1; //for dividers
		cellHeight += 1;

		for (var i = -1; i < (width+1) * cellWidth; i++){
			for (var j = -1; j < (height+1) * cellHeight; j++){
				if (i >= 0 && i < width*cellWidth){
					if (j >= 0 && j < height*cellHeight){
						//middle
						int midRelX = i % cellWidth;
						int midRelY = j % cellHeight;

						Player thisPlayer = field[i][j];

						if (midRelX == 0 && midRelY == 0){
							System.out.print("+");
						} else if (midRelX == 1 && midRelY == 1 && thisPlayer != null){
							int score = thisPlayer.score();
							System.out.print(score);
						}
					} else {
						System.out.print("-"); //top or bottom
					}
				} else {
					if (j >= 0 && j < height*cellHeight){
						System.out.print("|"); //left or right
					} else {
						System.out.print(""); //corner
					}
				}
			}
			System.out.println("");
		}

		/*
		  --------------     18 across
		|				 |
		|				 |
		|				 |
		|				 |
		|			 	 |
		|				 |
		|				 | 9 down
		  --------------
		*/

	}

	public static void main(String[] args) {
		Field field = new Field(7, 7);
		field.printField();
	}
}