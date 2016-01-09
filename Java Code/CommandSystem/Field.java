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

		Player killedGuy = takeDamage(x, y-1, damage);
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

		Player killedGuy = takeDamage(x, y+1, damage);
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

		Player killedGuy = takeDamage(x-1, y, damage);
		if (killedGuy != null){ //if the enemy player died, HANDLE IT
			field[x][y].killedEnemy(killedGuy);
		}

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

		Player killedGuy = takeDamage(x+1, y, damage);
		if (killedGuy != null){ //if the enemy player died, HANDLE IT
			field[x][y].killedEnemy(killedGuy);
		}

		return true;
	}
}