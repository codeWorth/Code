package me.Andrew.BukkitCombat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bukkit.Sound;
import org.bukkit.entity.*;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.plugin.java.JavaPlugin;

//Do damage in sequences to get increased damage per hit, and an effect at the end of the sequence

/*Sequences (all with sword):
 * hit, sprint towards player hit, hit while moving upward = throws player into air a bit (not enough for fall damage), gives player bleed effect for X time at X damage
 * sprint towards player and hit from behind while moving downward = stun player for X seconds
 * hit while moving upward, hit with fists 3 times in quick succession, hit with sword while moving downward = (disarm player, apply slowness for X seconds, stun for X second)
 */

public class CombatPlayer{
	
	private int power = 100;
	private List<Dot> DOTs = new ArrayList<Dot>();
	
	private boolean didInitialHit = false;
	private boolean didSprintHit = false;
	private boolean didUpHit = false;
	
	//Adjustable Values
	private int afterSprintHitTime = 25;
	private int timeAfterHit = 30;
	private double throwVel = 0.1;
	private double bleedDamage = 1.5;
	private int bleedTime = 50;
	
	public Player player;
	private JavaPlugin plugin;
	private int timer = 0;
	
    private static Map<String, CombatPlayer> combatplayers = new HashMap<String, CombatPlayer>();
	
	private CombatPlayer(Player player, JavaPlugin plugin){
		this.player = player;
        this.plugin = plugin;
        this.plugin.getServer().getScheduler().scheduleSyncRepeatingTask(this.plugin, new Runnable (){
        	public void run(){
        		timer();
        	}
        }, 0, 1);
        
        this.plugin.getServer().getScheduler().scheduleSyncRepeatingTask(this.plugin, new Runnable (){
        	public void run(){
        		runDOTs();
        	}
        }, 0 , 10);
	}
	
	private void runDOTs(){
		for(Dot dot : this.DOTs){
			dot.tick();
		}
	}
	
	public static CombatPlayer getInstanceOfPlayer(Player player, JavaPlugin plugin) {
        if(!combatplayers.containsKey(player.getName())) {
            return new CombatPlayer(player,plugin);
        }
        else if(combatplayers.containsKey(player.getName())) {
            return combatplayers.get(player.getName());
        }
        else {
           return null;
        }
    }
	
	private void timer(){
		timer++;
		if (power < 100){
			power++;
		}
		if (timer == this.timeAfterHit){
			this.didInitialHit = false;
		}
		if (timer == this.afterSprintHitTime){
			this.didSprintHit = false;
		}
	}
	
	public void playerAttack(EntityDamageByEntityEvent event){
		this.didInitialHit = true;
		
		//play sound
		Player damager = (Player) event.getDamager();
		float pitch = (float)event.getDamage()/-10 + 2;
		damager.getWorld().playSound(damager.getLocation(), Sound.HURT_FLESH, (float)15.0, pitch);
		
		//check for combos
		if (this.didUpHit){
			event.getEntity()
		}
		
		//attack with damage
		
	}
	
	public void registerUpHit(){
		if (this.didSprintHit){
			this.timer = 0;
			this.didUpHit = true;
		}
	}
	
	public void registerSprintHit(){
		if (this.didInitialHit == true){
			this.timer = 0;
			this.didSprintHit = true;
		}
	}
	
	public void removeDot(Dot dot){
		this.DOTs.remove(dot);
	}

}
