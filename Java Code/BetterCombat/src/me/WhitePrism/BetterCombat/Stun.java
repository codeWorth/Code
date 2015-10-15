package me.WhitePrism.BetterCombat;

import org.bukkit.potion.PotionEffect;
import org.bukkit.potion.PotionEffectType;
import org.bukkit.scheduler.BukkitRunnable;

public class Stun extends BukkitRunnable{
	
	private int counter;
	private CombatPlayer player;
	
	public Stun(CombatPlayer player, int amountOfTime){
		this.counter = amountOfTime;
		this.player = player;
	}
	
	@Override
	public void run(){
		if (this.counter < 1){
    		this.player.player.removePotionEffect(PotionEffectType.CONFUSION);
    		player.stuned = false;
    		this.cancel();
    	} else {
    		this.player.player.removePotionEffect(PotionEffectType.CONFUSION);
    		this.player.player.addPotionEffect(new PotionEffect(PotionEffectType.CONFUSION, 100, 0));
    		this.counter -= 1;
    	}
	}
}
