package me.Andrew.BukkitCombat;

public class DamageDot extends Dot {
	
	private double dotDamage;
	
	public DamageDot(int dotLife, CombatPlayer combatPlayer, double dotDamage){
		super(dotLife,combatPlayer);
		this.dotDamage = dotDamage;
	}
	
	private void doAction(){
		comPlay.player.damage(this.dotDamage);
	}
}
