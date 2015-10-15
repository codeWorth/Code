package me.WhitePrism.BetterCombat;

import java.util.Arrays;
import java.util.Random;

import org.bukkit.ChatColor;
import org.bukkit.Material;
import org.bukkit.entity.Entity;
import org.bukkit.entity.Player;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.scheduler.BukkitRunnable;

public class Axe {
	
	private static Material[] axes = new Material[] {Material.WOOD_AXE, Material.GOLD_AXE, Material.STONE_AXE, Material.IRON_AXE, Material.DIAMOND_AXE};
	
	public static double stunChance = 0.1;
	private static double stunChange = 80;
	private static int chanceStunTime = 2;
	private static int delibrateStunTime = 5;
	public static double critChance = 0.1;
	
	public static double attackBarMult = 0.75;
	public static double maxAttack = 200;
	private static double minAttack = 20;
	
	private static double axeDamageBonus = 3;
	public static double damageMultForRage = 1;
	private static double dismemberMult = 10;
	
	private static double dismemberCost = 60;
	
	public static boolean isAxe(Material mat){
		return Arrays.asList(Axe.axes).contains(mat);
	}
	
	public static boolean wasStuned(CombatPlayer player, CombatPlayer stunner){
		Random rand = new Random();
		double randInt = rand.nextFloat();
		if (randInt < Axe.stunChance){
			return Axe.stun(Axe.chanceStunTime, player, stunner, false);
		}
		return false;
	}
	
	public static void mightCrit(CombatPlayer player, CombatPlayer victim, EntityDamageByEntityEvent event){
		Random rand = new Random();
		double randInt = rand.nextFloat();
		if (randInt < Axe.critChance){
			double critAmount = Axe.critForAxe(player.player.getItemInHand());
			double newDamage = critAmount + event.getDamage();
			if(critAmount > 0){
				player.player.sendMessage(ChatColor.RED + "Crit for " + ChatColor.GRAY + String.valueOf((int)newDamage) + ChatColor.RED + " damage!");
			}
			event.setDamage(newDamage);
		}
	}
	
	public static boolean stun(CombatPlayer player, CombatPlayer stunner){
		return Axe.stun(Axe.delibrateStunTime, player, stunner);
	}
	
	//spells 
    
    public static boolean stun(int amountOfTime, CombatPlayer target, CombatPlayer stunner, boolean costEnergy){
    	if (stunner.energy >= Axe.stunChange){
    		BukkitRunnable stun = new Stun(target, amountOfTime);
    		target.runningStun = stun;
    		target.stunPlace = target.player.getLocation();
    		target.stuned = true;
        	stun.runTaskTimer(target.plugin, 0, 40);
        	if (costEnergy){
        		stunner.energy -= Axe.stunChange;
        	}
    		return true;
    	} else {
    		return false;
    	}
    }
    
    public static boolean stun(int amountOfTime, CombatPlayer target, CombatPlayer stunner){
    	return Axe.stun(amountOfTime, target, stunner, true);
    }
    
    public static boolean useDismember(CombatPlayer victim, CombatPlayer attacker, Double damage){
    	if (attacker.energy >= Axe.dismemberCost){
    		attacker.energy -= Axe.dismemberCost;
			victim.dismemberedAmount = damage * Axe.dismemberMult;
			victim.itemInHandAtDismember = victim.player.getItemInHand();
			if (victim.player.getItemInHand() != null){
				victim.player.setItemInHand(null);
			}
			return true;
    	}
    	return false;
    }
	
	public static double critForAxe(ItemStack item){
		if (item != null){
			Material mat = item.getType();
			int critAmount = 0;
			if (mat == Material.WOOD_AXE){
				critAmount = 11;
			} else if (mat == Material.STONE_AXE){
				critAmount = 13;
			} else if (mat == Material.GOLD_AXE){
				critAmount = 11;
			} else if (mat == Material.IRON_AXE){
				critAmount = 15;
			} else if (mat == Material.DIAMOND_AXE){
				critAmount = 17;
			} else {
				critAmount = 0;
			}
			Random rand = new Random();
			return (rand.nextDouble() * 0.5 + 0.5) * 0.5 * critAmount;
		} else {
			return 0;
		}
	}
	
	public static void handleDamage(CombatPlayer attacker, Entity victim, EntityDamageByEntityEvent event){
		event.setDamage(event.getDamage() + Axe.axeDamageBonus);
		if (victim instanceof Player){
			CombatPlayer playerVictim = CombatPlayer.getInstanceOfPlayer((Player)victim, attacker.plugin);
			if (Axe.wasStuned(playerVictim, attacker)){
				attacker.player.sendMessage(ChatColor.AQUA + "You have stuned your opponent!");
				playerVictim.player.sendMessage(ChatColor.RED + "You have been stuned!");
			}
			Axe.mightCrit(attacker, playerVictim, event);
			if (attacker.player.getVelocity().getY() > 0){
				Dot damageDot = new Dot(event.getDamage());
				if (playerVictim.addDot(damageDot,attacker)){
					attacker.player.sendMessage(ChatColor.RED + "You use Rupture Vein for " + ChatColor.GRAY + String.valueOf((int)damageDot.dps) + ChatColor.RED + " damage per second for " + ChatColor.GRAY + String.valueOf((int)damageDot.dotTime) + ChatColor.RED + " seconds.");
				}
			}
			if (attacker.isBehind(victim)){
				if(Axe.useDismember(playerVictim, attacker, event.getDamage())){
					attacker.player.sendMessage(ChatColor.AQUA + "You dismember you enemy's arm!");
					playerVictim.player.sendMessage(ChatColor.RED + "You arm has been dismembered, it will heal in " + String.valueOf(((int)playerVictim.dismemberedAmount / 20 * 10)/10) + " seconds.");
				}
			}
		}
	}
	
	public static void handleRightClick(CombatPlayer clicker, CombatPlayer selected){
		if (Axe.stun(selected, clicker)){
			clicker.player.sendMessage(ChatColor.AQUA + "You have stunned your opponent!");
			selected.player.sendMessage(ChatColor.RED + "You have been stuned!");
		}
	}
	
	//Methods for the attack and defend charge bar
    public static double attack(CombatPlayer player){
    	double axeAttack = player.attackCharge * Axe.attackBarMult;
    	if (player.axeEnraged){
    		player.axeRage -= 5;
    	}
    	player.axe100 = false;
    	player.axeFull = false;
    	if (axeAttack <= Axe.minAttack){
    		player.attackCharge = 0;
    		player.player.sendMessage(ChatColor.AQUA + "You hit with " + ChatColor.RED + String.valueOf(Axe.minAttack) + ChatColor.AQUA + " precent attack power.");
    		return Axe.minAttack/100 * Axe.attackBarMult;
    	} else {
    		if (axeAttack > Axe.maxAttack){
    			double savedCharge = Axe.maxAttack;
	    		player.attackCharge = 0;
	    		player.player.sendMessage(ChatColor.AQUA + "You hit with " + ChatColor.RED + String.valueOf(savedCharge) + ChatColor.AQUA + " precent attack power.");
	    		return savedCharge/100 * Axe.attackBarMult;
    		} else {
	    		double savedCharge = axeAttack;
	    		player.attackCharge = 0;
	    		player.player.sendMessage(ChatColor.AQUA + "You hit with " + ChatColor.RED + String.valueOf(savedCharge) + ChatColor.AQUA + " precent attack power.");
	    		return savedCharge/100 * Axe.attackBarMult;
    		}
    	}
    }
}
