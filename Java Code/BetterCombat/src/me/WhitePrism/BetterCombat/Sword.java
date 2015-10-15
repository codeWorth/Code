package me.WhitePrism.BetterCombat;

import java.util.Arrays;
import java.util.Random;

import org.bukkit.ChatColor;
import org.bukkit.Material;
import org.bukkit.entity.Entity;
import org.bukkit.entity.Player;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.event.player.PlayerInteractEntityEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.plugin.java.JavaPlugin;
import org.bukkit.scheduler.BukkitRunnable;

public class Sword {

	private static int stunTime = 3;
	private static Material[] swords = new Material[] {Material.WOOD_SWORD, Material.GOLD_SWORD, Material.STONE_SWORD, Material.IRON_SWORD, Material.DIAMOND_SWORD};
	
	private static double minAttack = 25;
    public static double maxAttack = 150;
    
    private static double minDefend = 35;
    
    public static double damageMultForRage = 0.75;
    
    private static double shadowstepChange = 55;
    private static double stunChange = 55;
    public static double chokeChange = 0.05;
    	
	public static boolean isSword(Material material){
		return Arrays.asList(Sword.swords).contains(material);
	}
	
	public static boolean stun(CombatPlayer toStun, CombatPlayer stunner){
		return Sword.stun(Sword.stunTime, toStun, stunner);
	}
	
	public static void handleRightClickSword(CombatPlayer swordWielder, Entity selected, PlayerInteractEntityEvent event, JavaPlugin main){
		Player clicker = swordWielder.player;
		if (swordWielder.isWithinRange(selected, 1.5) && selected instanceof Player){
			Player selectedPlayer = (Player)selected;
			CombatPlayer selectedCombat = CombatPlayer.getInstanceOfPlayer(selectedPlayer, main);
			if (swordWielder.isBehind(selectedPlayer)){
				clicker.sendMessage(ChatColor.AQUA + "You put your enemy in a choke hold!");
				selectedPlayer.sendMessage(ChatColor.RED + "You have been put in a choke hold!");
				Sword.beginChoke(swordWielder, true, CombatPlayer.getInstanceOfPlayer(selectedPlayer, main));
			} else {
				if(Sword.stun(selectedCombat, swordWielder)){
					clicker.sendMessage(ChatColor.AQUA + "You stun your enemy!");
					selectedPlayer.sendMessage(ChatColor.RED + "You have been stuned!");
				}
			}
		} else {
			if (swordWielder.isInAir() && swordWielder.isWithinRange(selected, 5) && clicker.isSprinting() && Sword.useShadowstep(swordWielder)){
				clicker.sendMessage(ChatColor.RED + "You use Shadowstep!");
				swordWielder.moveForShadowstep(selected);
				event.setCancelled(true);
			}
		}
	}
	
	public static void handleBlockWithSword(CombatPlayer player, ItemStack weaponUsed, EntityDamageByEntityEvent event){
		if (!player.stuned){
			if (weaponUsed != null && Axe.isAxe(weaponUsed.getType())){
				event.setDamage(event.getDamage() * (1 - Sword.block(player)/2));
			} else {
				event.setDamage(event.getDamage() * (1 - Sword.block(player)));
			}
		} else {
			event.setCancelled(true);
		}
	}
	
	public static void handleVictimDamage(CombatPlayer victim, Player attacker, EntityDamageByEntityEvent event){
		if (attacker.getVelocity().getY() > 0){
			Dot damageDot = new Dot(event.getDamage());
			if (victim.addDot(damageDot,CombatPlayer.getInstanceOfPlayer(attacker, victim.plugin))){
				attacker.sendMessage(ChatColor.RED + "You use Rupture Vein for " + ChatColor.GRAY + String.valueOf((int)damageDot.dps) + ChatColor.RED + " damage per second for " + ChatColor.GRAY + String.valueOf((int)damageDot.dotTime) + ChatColor.RED + " seconds.");
			}
		}
		if (victim.stuned){
			victim.cancelStun();
		}
	}
	
	public static double critForSword(ItemStack item){
		if (item != null){
			Material mat = item.getType();
			int critAmount = 0;
			if (mat == Material.WOOD_SWORD){
				critAmount = 11;
			} else if (mat == Material.STONE_SWORD){
				critAmount = 13;
			} else if (mat == Material.GOLD_SWORD){
				critAmount = 11;
			} else if (mat == Material.IRON_SWORD){
				critAmount = 15;
			} else if (mat == Material.DIAMOND_SWORD){
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
    
	//spells
    public static boolean useShadowstep(CombatPlayer player){
    	if (player.energy >= Sword.shadowstepChange){
    		player.energy -= Sword.shadowstepChange;
    		return true;
    	} else {
    		return false;
    	}
    }
    
    public static boolean stun(int amountOfTime, CombatPlayer target, CombatPlayer stunner){
    	if (stunner.energy >= Sword.stunChange){
    		BukkitRunnable stun = new Stun(target, amountOfTime);
    		target.runningStun = stun;
    		target.stunPlace = target.player.getLocation();
    		target.stuned = true;
        	stun.runTaskTimer(target.plugin, 0, 40);
    		stunner.energy -= Sword.stunChange;
    		return true;
    	} else {
    		return false;
    	}
    }
    
    //Choke related methods    
    public static void beginChoke(CombatPlayer player, boolean isChoker, CombatPlayer partner){
    	if (isChoker){
	    	if (player.energy >= Sword.stunChange){
	    		player.isChockingOther = true;
	    		player.isInChokeHold = false;
	    		Sword.beginChoke(partner, false, player);
	    	}
    	} else {
    		Sword.stun(100000000,player,partner);
    		player.tick = 0;
    		player.isChockingOther = false;
    		player.isInChokeHold = true;
    	}
    	player.chokeAmount = 0;
    	player.chokePartner = partner;
    }
    
    //Methods for the attack and defend charge bar
    public static double attack(CombatPlayer player){
    	if (player.swordEnraged){
    		player.swordRage -= 5;
    	}
    	player.sword100 = false;
    	player.swordFull = false;
    	if (player.attackCharge <= Sword.minAttack){
    		player.attackCharge = 0;
    		player.player.sendMessage(ChatColor.AQUA + "You hit with " + ChatColor.RED + String.valueOf(Sword.minAttack) + ChatColor.AQUA + " precent attack power.");
    		return Sword.minAttack/100;
    	} else {
    		if (player.attackCharge > Sword.maxAttack){
    			double savedCharge = Sword.maxAttack;
	    		player.attackCharge = 0;
	    		player.player.sendMessage(ChatColor.AQUA + "You hit with " + ChatColor.RED + String.valueOf(savedCharge) + ChatColor.AQUA + " precent attack power.");
	    		return savedCharge/100;
    		} else {
	    		double savedCharge = player.attackCharge;
	    		player.attackCharge = 0;
	    		player.player.sendMessage(ChatColor.AQUA + "You hit with " + ChatColor.RED + String.valueOf(savedCharge) + ChatColor.AQUA + " precent attack power.");
	    		return savedCharge/100;
    		}
    	}
    }
    
    public static double block(CombatPlayer player){
    	if (player.defendCharge <= Sword.minDefend){
    		player.player.sendMessage(ChatColor.AQUA + "You block with " + ChatColor.GREEN + String.valueOf(Sword.minDefend) + ChatColor.AQUA + " precent blocking power.");
    		return Sword.minDefend/100;
    	} else {
    		player.player.sendMessage(ChatColor.AQUA + "You block with " + ChatColor.GREEN + String.valueOf(player.defendCharge) + ChatColor.AQUA + " precent blocking power.");
    		return player.defendCharge/100;
    	}
    }
    
    
}
