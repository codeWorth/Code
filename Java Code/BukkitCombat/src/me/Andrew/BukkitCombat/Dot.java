package me.Andrew.BukkitCombat;

public class Dot {
	protected int dotLife;
	protected CombatPlayer comPlay;
	
	public Dot(int dotLife, CombatPlayer combatPlayer){
		this.dotLife = dotLife;
		this.comPlay = combatPlayer;
	}
	
	public void tick(){
		if (dotLife > 0){
			doAction();
			dotLife--;
		} else {
			this.comPlay.removeDot(this);
		}
	}
	
	private void doAction(){
		//do action
	}
}
 