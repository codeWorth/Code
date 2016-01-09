public class Player{
	private int x = 0;
	private int y = 0;

	private int health = 100;

	private static final int maxCooldown = 30;
	private int cooldown;
	private int damage = 15;

	private int points = 0;

	private Field field;

	public Player(int startX, int startY, Field theField){
		x = startX;
		y = startY;

		cooldown = Player.maxCooldown;

		field = theField;
	}

	public Player(int startX, int startY, Field theField, int nHealth, int nCooldown, int nDamage, int nPoints){
		x = startX;
		y = startY;

		cooldown = nCooldown;

		field = theField;

		health = nHealth;

		points = nPoints;

		damage = nDamage;
	}


	public boolean tryMoveUp(){ //ask field to move me up, if it cant return false
		return field.movePlayerUp(x, y);
	}

	public boolean tryMoveDown(){ //ask field to move me down, if it cant return false
		return field.movePlayerDown(x, y);
	}

	public boolean tryMoveLeft(){ //ask field to move me left, if it cant return false
		return field.movePlayerLeft(x, y);
	}

	public boolean tryMoveRight(){ //ask field to move me right, if it cant return false
		return field.movePlayerRight(x, y);
	}


	public boolean takeDamage(int damage){ //return false if I died
		health -= damage;
		return health > 0;
	}

	public boolean die(){ //perform any death actions, return true if I survived (somehow, maybe it WERE MEGIC)
		return false;
	}


	public boolean attackUp(){ 
		return field.playerAttackUp(x, y, damage)
	}

	public boolean attackDown(){
		return field.attackSquare(x, y+1, damage);
	}

	public boolean attackLeft(){
		return field.attackSquare(x-1, y, damage);
	}

	public boolean attackRight(){
		return field.attackSquare(x+1, y, damage);
	}


	public void killedEnemy(Player enemy){ //notify the player that an enemy was killed
		points++;
	}


	public Player copy(){
		Player newMe = new Player(x, y, field, health, cooldown, damage, points);
		return newMe;
	}
}