package me.WhitePrism.BetterCombat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bukkit.ChatColor;
import org.bukkit.Location;
import org.bukkit.entity.Entity;
import org.bukkit.entity.Player;
import org.bukkit.event.block.Action;
import org.bukkit.event.player.PlayerInteractEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.plugin.java.JavaPlugin;
import org.bukkit.potion.PotionEffect;
import org.bukkit.potion.PotionEffectType;
import org.bukkit.scheduler.BukkitRunnable;

public class CombatPlayer{

	//general player information
    public Player player;
    public JavaPlugin plugin;

    //changing member variables
    //charging bars
    public double attackCharge = 99;
    public double defendCharge = 99;
    public double energy = 99;
    
    //misc changing member variables
    public int tick = 0;
    public boolean stuned = false;
    public double dismemberedAmount = 0;
    public ItemStack itemInHandAtDismember = null;
    public boolean shouldReportAxeUnrage = true;
    public boolean shouldReportSwordUnrage = true;
    public ItemStack selectedPotion = null;
    public int selectedSlot = 0;
    
    //reporting variables
    public boolean sword100 = false;
    public boolean swordFull = false;
    public boolean axe100 = false;
    public boolean axeFull = false;
    
    //Rage variables
    public double swordRage = 0;
    public double axeRage = 0;
    public boolean swordEnraged = false;
    public boolean axeEnraged = false;
    public double swordTimeForRageReset = 35; //ticks
    public double axeTimeForRageReset = 4; //ticks

    //variables related to the choke hold
    public boolean isInChokeHold = false; //if this player is the on being choked.
    public boolean isChockingOther = false; //if this player is the one chocking the other player
    public double chokeAmount = 0;
    private final int ticksForLessAir = 30;
    public CombatPlayer chokePartner;
    
    //variables related to stunning
    public Location stunPlace;      
    public BukkitRunnable runningStun;

//all constants
    
    //attack related constants
    private final double attackChange = 1.5;
    private final double aboveAttack100Change = 0.5;

    //defend related constants
    private final double defendRegen = 1;
    private final double defendChange = 2.25;
    private final double maxDefend = 100;

    //spell costs
    private final double dotAddChange = 40;
    
    //energy related constants
    private final double energyRegen = 1;
    private final double maxEnergy = 100;
    
    //misc. constants
    private final double angleRange = 60;
    private final double dist = -1;
    private final double maxAttack = 300; //highest of all weapon's maxAttack, or more
    private final double decreaseForRage = 0.5;
    
    //ArrayLists
    private static Map<String, CombatPlayer> combatplayers = new HashMap<String, CombatPlayer>();
    private List<Dot> Dots = new ArrayList<Dot>();
    
    private CombatPlayer(Player player, JavaPlugin plugin) {
        this.player = player;
        this.plugin = plugin;
        final CombatPlayer combPlayer = this;
        plugin.getServer().getScheduler().scheduleSyncRepeatingTask(plugin, new Runnable (){
        	public void run(){
        		update(combPlayer);
        	}
        }, 0, 1);
        plugin.getServer().getScheduler().scheduleSyncRepeatingTask(plugin, new Runnable (){
        	public void run(){
        		useDots(combPlayer);
        	}
        }, 0, 20);
        combatplayers.put(player.getName(), this);
    }
    
    // Return a running instance (or create a new one)
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
    
    //Methods run on the scheduler
    public void update(CombatPlayer player){
    	if (this.stuned){
    		this.player.teleport(this.stunPlace);
    	}
    	if (player.attackCharge < player.maxAttack && !this.swordEnraged){
    		if (player.attackCharge >= 100 && !this.sword100){
    			player.player.sendMessage(ChatColor.RED + "Sword attack at 100 percent!");
    			this.sword100 = true;
    		}
    		if (player.attackCharge * Axe.attackBarMult >= 100 && !this.axe100){
    			player.player.sendMessage(ChatColor.RED + "Axe attack at 100 percent!");
    			this.axe100 = true;
    		}
    		if (player.attackCharge < 100){
    			player.attackCharge += player.attackChange;
    		} else {
    			player.attackCharge += player.aboveAttack100Change;
    		}
    		if (player.attackCharge >= player.maxAttack){
        		player.attackCharge = player.maxAttack;
        	}
    		if (player.attackCharge >= Sword.maxAttack && !this.swordFull){
        		player.player.sendMessage(ChatColor.RED + "Sword attack fully charged!");
    			this.swordFull = true;
        	}
    		if (player.attackCharge * Axe.attackBarMult >= Axe.maxAttack && !this.axeFull){
        		player.player.sendMessage(ChatColor.RED + "Axe attack fully charged!");
    			this.axeFull = true;
        	}
    	} else if (this.swordEnraged){
    		player.attackCharge = Sword.maxAttack;
    		player.defendCharge = this.maxDefend;
    	}
    	if (player.player.isBlocking()){
    		if (player.defendCharge > 0){
    			player.defendCharge += player.defendChange * -1;
    			if (player.defendCharge <= 0){
    				player.defendCharge = 0;
    			}
    		}
    	} else {
    		if (player.defendCharge < player.maxDefend){
        		if (player.defendCharge < 100 && player.defendCharge+player.defendRegen > 100){
        			player.player.sendMessage(ChatColor.RED + "Blocking at 100 percent!");
        		}
    			player.defendCharge += player.defendRegen;
    			if (player.defendCharge >= player.maxDefend){
    				player.defendCharge = player.maxDefend;
    				player.player.sendMessage(ChatColor.GREEN + "Block fully charged!");
    			}
    		}
    	}
    	if (player.energy < player.maxEnergy){
    		player.energy += player.energyRegen;
    		if (player.energy >= player.maxEnergy){
        		player.energy = player.maxEnergy;
        		player.player.sendMessage(ChatColor.YELLOW + "Energy fully charged!");
        	}
    	}
    	if (this.tick % this.ticksForLessAir == 0 && this.isChockingOther){
    		this.chokingHandleBoolean(this.changeChoke(), this);
    	}
    	if (this.swordEnraged){
    		this.swordRage -= this.decreaseForRage;
    		if (this.swordRage <= 0){
    			this.swordEnraged = false;
    		}
    	} else {
    		if (this.swordTimeForRageReset <= 0){
    			if (this.shouldReportSwordUnrage){
	    			this.swordTimeForRageReset = 0;
	    			this.player.sendMessage(ChatColor.AQUA + "You have lost your sword rage." );
	    			this.swordRage = 0;
	    			this.shouldReportSwordUnrage = false;
    			}
    		} else {
        		this.swordTimeForRageReset -= 1;
    		}
    		if (this.swordRage >= 100){
    			this.swordEnraged = true;
    			this.shouldReportSwordUnrage = true;
    			this.swordTimeForRageReset = 1;
    			this.player.sendMessage(ChatColor.AQUA + "Your sword has become " + ChatColor.RED + " enraged!");
    		}
    	}
    	if (this.axeEnraged){
    		Axe.critChance = 0.6;
    		Axe.attackBarMult = 1.25;
    		Axe.stunChance = 0.6;
    		this.axeRage -= this.decreaseForRage;
    		if (this.axeRage <= 0){
    			Axe.critChance = 0.1;
    			Axe.attackBarMult = 0.75;
    			Axe.stunChance = 0.1;
    			this.axeEnraged = false;
    		}
    	} else {
	    	if (this.axeTimeForRageReset <= 0){
	    		if (this.shouldReportAxeUnrage){
		    		this.axeTimeForRageReset = 0;
	    			this.player.sendMessage(ChatColor.AQUA + "You have lost your axe rage." );
		    		this.axeRage = 0;
		    		this.shouldReportAxeUnrage = false;
	    		}
	    	} else {
		    	this.axeTimeForRageReset -= 1;
	    	}
    		if (this.axeRage >= 100){
    			this.axeEnraged = true;
    			this.shouldReportAxeUnrage = true;
    			this.axeTimeForRageReset = 1;
    			this.player.sendMessage(ChatColor.AQUA + "Your axe has become " + ChatColor.RED + " enraged!");
    		}
    	}
    	if (this.dismemberedAmount > 0){
    		this.dismemberedAmount -= 1;
    		if (this.dismemberedAmount <= 0){
    			this.player.setItemInHand(this.itemInHandAtDismember);
    			this.player.sendMessage(ChatColor.AQUA + "Your arm has healed!");
    		}
    	}    	
    	this.tick += 1;
    }
    
    public void useDots(CombatPlayer player){
    	List<Integer> toRemoveIndecies = new ArrayList<Integer>();
    	double totalDamage = 0;
    	int length = this.Dots.toArray().length;
    	for(int i = 0;i < length;i++) {
    		Dot thisDot = this.Dots.get(i);
    	    double damage = thisDot.tick();
    	    if (damage == 0){
    	    	toRemoveIndecies.add(i);
    	    } else {
    	    	totalDamage += damage;
    	    }
    	}
    	for (Integer removeIndex : toRemoveIndecies){
    		this.Dots.remove(removeIndex);
    	}
    	if (totalDamage > 0){
    		player.player.damage(totalDamage);
    	}
    }
    
    //Stun methods
    public void cancelStun(){
    	if (this.stuned){
    		this.stuned = false;
    		this.runningStun.cancel();
    		this.player.removePotionEffect(PotionEffectType.CONFUSION);
    	}
    }
    
    public boolean changeChoke(){
    	if (this.isChockingOther){
    		this.chokeAmount += Sword.chokeChange;
    		this.chokePartner.chokeAmount = this.chokeAmount;
    		
    		
    		if (this.chokeAmount <= -0.8 && this.chokeAmount + Sword.chokeChange > 0.8){
    			this.player.sendMessage(ChatColor.RED + "Your enemy is slipping from your grasp!");
    			this.chokePartner.player.sendMessage(ChatColor.RED + "You are slipping from the enemy's grasp!");
    		}
    		if (this.chokeAmount >= 0.8 && this.chokeAmount - Sword.chokeChange < 0.8){
    			this.player.sendMessage(ChatColor.RED + "You feel the enemy begin to lose consciousness.");
    			this.chokePartner.player.sendMessage(ChatColor.RED + "You begin to feel dizzy and light headed, you are running out of air!");
    		}
    		
    		if (this.chokeAmount > 0 && this.chokeAmount - Sword.chokeChange < 0){
    			this.player.sendMessage(ChatColor.AQUA + "You have gained the upper hand!");
    			this.chokePartner.player.sendMessage(ChatColor.RED + "You have lost the upper hand!");
    		}
    		if (this.chokeAmount < 0 && this.chokeAmount + Sword.chokeChange > 0){
    			this.player.sendMessage(ChatColor.RED + "You have lost the upper hand!");
    			this.chokePartner.player.sendMessage(ChatColor.RED + "You have gained the upper hand!");
    		}
    		
    		
    		if (this.chokeAmount >= 1){
    			return true;
    		}
    	} else {
    		this.chokeAmount -= Sword.chokeChange;
    		this.chokePartner.chokeAmount = this.chokeAmount;
    		
    		
    		if (this.chokeAmount <= -0.8 && this.chokeAmount + Sword.chokeChange > 0.8){
    			this.chokePartner.player.sendMessage(ChatColor.RED + "Your enemy is slipping from your grasp!");
    			this.player.sendMessage(ChatColor.RED + "You are slipping from the enemy's grasp!");
    		}
    		if (this.chokeAmount >= 0.8 && this.chokeAmount - Sword.chokeChange < 0.8){
    			this.chokePartner.player.sendMessage(ChatColor.RED + "You feel the enemy begin to lose consciousness.");
    			this.player.sendMessage(ChatColor.RED + "You begin to feel dizzy and light headed, you are running out of air!");
    		}
    		
    		
    		if (this.chokeAmount > 0 && this.chokeAmount - Sword.chokeChange < 0){
    			this.chokePartner.player.sendMessage(ChatColor.AQUA + "You have gained the upper hand!");
    			this.player.sendMessage(ChatColor.RED + "You have lost the upper hand!");
    		}
    		if (this.chokeAmount < 0 && this.chokeAmount + Sword.chokeChange > 0){
    			this.chokePartner.player.sendMessage(ChatColor.RED + "You have lost the upper hand!");
    			this.player.sendMessage(ChatColor.RED + "You have gained the upper hand!");
    		}
    		
    		
    		if (this.chokeAmount <= -1){
    			return true;
    		}
    	}
    	return false;
    }
 
    //Method to add a dot
    public boolean addDot(Dot dot, CombatPlayer attacker){
    	if (attacker.energy >= attacker.dotAddChange){
    		attacker.energy -= attacker.dotAddChange;
    		this.Dots.add(dot);
    		return true;
    	} else {
    		return false;
    	}
    }
    
    public void addDot(Dot dot){
    	this.Dots.add(dot);
    }
    
	//Method to move for Shadow Step
	public void moveForShadowstep(Entity onEntity){
		Location selectedVector = onEntity.getLocation();
		double angleInRadians = (selectedVector.getYaw() + 90) / 180 * Math.PI;
		double xMult = Math.cos(angleInRadians);
		double zMult = Math.sin(angleInRadians);
		Location newPlayerPos = new Location(this.player.getWorld(), selectedVector.getX() + this.dist * xMult, selectedVector.getY(), selectedVector.getZ() + this.dist * zMult, selectedVector.getYaw(), this.player.getLocation().getPitch());
		this.player.teleport(newPlayerPos);
	}
    
    //Reports values
    public void printValues(){
    	this.player.sendMessage("You have " + this.attackCharge + " attack power, " + this.defendCharge + " block power, and " + String.valueOf(this.energy) + " energy.");
    }
    
	//Utility tests
	public boolean isBehind(Entity infront){
		double behindAngle = (this.player.getLocation().getYaw() + 360) % 360 + 360;
		double infrontAngle = (infront.getLocation().getYaw() + 360) % 360 + 360;
		if (behindAngle - this.angleRange < infrontAngle && infrontAngle < behindAngle + this.angleRange){
			return true;
		}
		return false;
	}
	
	public boolean isWithinRange(Entity entity2, double distance){
		return this.player.getLocation().distance(entity2.getLocation()) <= distance;
	}
	
	public boolean isInAir(){
		return !((Entity)this.player).isOnGround();
	}
	
	public boolean inDisabledState(){
		return this.isChockingOther || this.stuned || this.isInChokeHold;
	}
    
	//Handlers of various events
    public void chokingHandleBoolean(boolean doneChoke, CombatPlayer player){
		if (doneChoke){
			if (player.isInChokeHold){
				player.isInChokeHold = false;
				player.chokePartner.isChockingOther = false;
				player.player.sendMessage(ChatColor.AQUA + "You have escaped from the choke hold!");
				player.cancelStun();
				player.chokePartner.player.sendMessage(ChatColor.RED + "Your victim has escaped and you have been stuned!");
				Sword.stun(3, player, player.chokePartner);
			} else if (player.isChockingOther){
				player.isChockingOther = false;
				player.chokePartner.isInChokeHold = false;
				Dot killDot = new Dot(0);
				killDot.dotTime = 5;
				killDot.dps = 7;
				player.chokePartner.player.addPotionEffect(new PotionEffect(PotionEffectType.BLINDNESS, 9000, 0));
				player.chokePartner.player.sendMessage(ChatColor.RED + "The world darkens around you...");
				player.player.sendMessage(ChatColor.AQUA + "You successfully dispatched your enemy!");
				player.chokePartner.cancelStun();
				player.chokePartner.player.addPotionEffect(new PotionEffect(PotionEffectType.BLINDNESS, 90000, 0));
				player.chokePartner.addDot(killDot);
			}
		}
    }
	
	public void handleAnyClick(PlayerInteractEvent event){
		if ((event.getAction() == Action.LEFT_CLICK_AIR || event.getAction() == Action.LEFT_CLICK_BLOCK) && (this.isChockingOther || this.isInChokeHold)){
			boolean doneChoke = this.changeChoke();
			event.setCancelled(true);
			this.chokingHandleBoolean(doneChoke, this);
		} else if (event.getAction() == Action.RIGHT_CLICK_AIR || event.getAction() == Action.RIGHT_CLICK_BLOCK){
			/*int power = Wand.isWand(event.getPlayer().getItemInHand());
			if (this.selectedPotion != null && power > 0){
				if (this.selectedPotion.getType() == Material.POTION){
					Wand.castPotion(this,power);
				} else if (SpellItem.isSpellItem(this.selectedPotion)){
					Wand.castSpell(this, power);
				}
			}*/
		}
		if (this.stuned){
			event.setCancelled(true);
		}
	}
	
	public void removeThis(){
		CombatPlayer.combatplayers.remove(this.player.getName());
	}
	
	//resets values when the player dies	
	public void resetForDeath(){
		this.Dots.clear();
		if (this.isChockingOther || this.isInChokeHold){
			this.isChockingOther = false;
			this.isInChokeHold = false;
			this.chokePartner.isChockingOther = false;
			this.chokePartner.isInChokeHold = false;
			this.player.removePotionEffect(PotionEffectType.CONFUSION);
			this.player.removePotionEffect(PotionEffectType.BLINDNESS);
			this.swordEnraged = false;
			this.swordRage = 0;
			this.axeEnraged = false;
			this.axeRage = 0;
			this.cancelStun();
		}
	}
}