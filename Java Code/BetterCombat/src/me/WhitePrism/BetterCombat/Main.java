package me.WhitePrism.BetterCombat;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import org.bukkit.ChatColor;
import org.bukkit.Material;
import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.enchantment.EnchantItemEvent;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.event.entity.PlayerDeathEvent;
import org.bukkit.event.entity.ProjectileHitEvent;
import org.bukkit.event.player.PlayerInteractEntityEvent;
import org.bukkit.event.player.PlayerInteractEvent;
import org.bukkit.event.player.PlayerItemHeldEvent;
import org.bukkit.event.player.PlayerJoinEvent;
import org.bukkit.event.player.PlayerQuitEvent;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.ItemMeta;
import org.bukkit.plugin.java.JavaPlugin;

public class Main extends JavaPlugin implements Listener{
		
	private final int enchantabilityOfStick = 15; //like wooden tools
	private final double chanceOfEnchant = 1;
	private final int levelOneStart = 15;
	private final int levelOneEnd = 65;
	private final int levelTwoStart = 24;
	private final int levelTwoEnd = 74;
	private final int levelThreeStart = 33;
	private final int levelThreeEnd = 83;
	
	public void onEnable() {
		getLogger().info("Better Combat Enabled!");
		getServer().getPluginManager().registerEvents(this, this);
	}
	
	public void onDisable() {
		getLogger().info("Better Comabt Disabled!");
	}
	
	@EventHandler
	public void onEntityDamage(EntityDamageByEntityEvent event){
		if (event.getDamager() instanceof Player){
			Player attacker = (Player) event.getDamager();
			CombatPlayer player = CombatPlayer.getInstanceOfPlayer(attacker,this);
			if (!player.inDisabledState() && attacker.getItemInHand() != null){
				if (Sword.isSword(attacker.getItemInHand().getType())){
					event.setDamage(event.getDamage() * Sword.attack(player));
					if (event.getEntity() instanceof Player){
						CombatPlayer combatVictim = CombatPlayer.getInstanceOfPlayer((Player)event.getEntity(), this);
						Sword.handleVictimDamage(combatVictim, attacker, event);
					}
					if (player.isBehind(event.getEntity())){
						double critAmount = Sword.critForSword(attacker.getItemInHand());
						double newDamage = critAmount + event.getDamage();
						if(critAmount > 0){
							attacker.sendMessage(ChatColor.RED + "Crit for " + ChatColor.GRAY + String.valueOf((int)newDamage) + ChatColor.RED + " damage!");
						}
						event.setDamage(newDamage);
					}
					player.player.sendMessage(String.valueOf(player.swordEnraged));
					if (!player.swordEnraged){
						player.swordRage += event.getDamage() * Sword.damageMultForRage;
						player.swordTimeForRageReset = 35;
		    			player.shouldReportSwordUnrage = true;
					}
				} else if(Axe.isAxe(attacker.getItemInHand().getType())){
					event.setDamage(event.getDamage() * Axe.attack(player));
					Axe.handleDamage(player, event.getEntity(), event);
					if (!player.axeEnraged){
						player.axeRage += event.getDamage() * Axe.damageMultForRage;
						player.axeTimeForRageReset = 45;
		    			player.shouldReportAxeUnrage = true;
					}
				}
			} else {
				event.setCancelled(true);
				if (player.isChockingOther || player.isInChokeHold){
					boolean doneChoke = player.changeChoke();
					player.chokingHandleBoolean(doneChoke, player);
				}
			}
		}
		if (event.getEntity() instanceof Player){
			Player victim = (Player)event.getEntity();
			if (victim.isBlocking()){
				CombatPlayer blockingPlayer = CombatPlayer.getInstanceOfPlayer(victim,this);
				if (event.getDamager() instanceof Player){
					Player attacker = (Player)event.getDamager();
					Sword.handleBlockWithSword(blockingPlayer, attacker.getItemInHand(), event);
				} else {
					Sword.handleBlockWithSword(blockingPlayer, null, event);
				}
			}
		}
	}
	
	@EventHandler
	public void onPlayerInteractEntity(PlayerInteractEntityEvent event){
		CombatPlayer player = CombatPlayer.getInstanceOfPlayer(event.getPlayer(), this); //gets the CombatPlayer for this event's getPlayer()
		if (!player.inDisabledState()){
			if (event.getPlayer().getItemInHand() != null){
				if (Sword.isSword(event.getPlayer().getItemInHand().getType())){
					Sword.handleRightClickSword(player, event.getRightClicked(), event, this);
				} else if (Axe.isAxe(event.getPlayer().getItemInHand().getType())){
					if (event.getRightClicked() instanceof Player){
						CombatPlayer victim = CombatPlayer.getInstanceOfPlayer((Player)event.getRightClicked(), this);
						Axe.handleRightClick(player, victim);
					}
				}
			}
		} else {
			event.setCancelled(true);
		}
	}
	
	@EventHandler
	public void onPlayerInteract(PlayerInteractEvent event){
		CombatPlayer player = CombatPlayer.getInstanceOfPlayer(event.getPlayer(), this);
		player.handleAnyClick(event);
	}
	
	@EventHandler
	public void onPlayerChangeItemInHand(PlayerItemHeldEvent event){
		CombatPlayer player = CombatPlayer.getInstanceOfPlayer(event.getPlayer(), this);
		if (player.dismemberedAmount > 0){
			event.setCancelled(true);
		} else if (event.getPlayer().getInventory().getItem(event.getNewSlot()) != null){
			int power = Wand.isWand(event.getPlayer().getInventory().getItem(event.getNewSlot()));
			if (power > 0){
				/*ItemStack previousItem = event.getPlayer().getInventory().getItem(event.getPreviousSlot());
				if (previousItem != null && (previousItem.getType() == Material.POTION || SpellItem.isSpellItem(previousItem))){
					player.selectedPotion = previousItem;
					player.selectedSlot = event.getPreviousSlot();
				}*/
			}
		}
	}
	
	@EventHandler
	public void onJoin(PlayerJoinEvent e){
		CombatPlayer player = CombatPlayer.getInstanceOfPlayer(e.getPlayer(), this);
		player.printValues();
	}
	
	@EventHandler
	public void onLeave(PlayerQuitEvent e){
		CombatPlayer player = CombatPlayer.getInstanceOfPlayer(e.getPlayer(), this);
		player.removeThis();
	}
	
	@EventHandler 
	public void onPlayerDeath(PlayerDeathEvent event){
		if (event.getEntity() instanceof Player){
			CombatPlayer player = CombatPlayer.getInstanceOfPlayer((Player)event.getEntity(), this);
			player.resetForDeath();
		}
	}
	
	@EventHandler 
	public void onItemEnchant(EnchantItemEvent event){
		//Only if item is a stick
		if (event.getItem().getType() == Material.WOOD_SWORD){
			//Step One
			// Will returns a uniformly distributed random integer between 0 and n - 1, inclusive
			// or can return a uniformly distributed random real (fractional) number between 0 (inclusive) and 1 (exclusive)
			Random rand = new Random();
	
			// Generate a random number between 1 and 1+(enchantability/2), with a triangular distribution
			int enchantability_2 = this.enchantabilityOfStick / 2;
			int rand_enchantability = 1 + rand.nextInt(enchantability_2 / 2 + 1) + rand.nextInt(enchantability_2 / 2 + 1);
	
			// Choose the enchantment level
			int k = event.getExpLevelCost() + rand_enchantability;
	
			// A random bonus, between .85 and 1.15
			float rand_bonus_percent = 1 + (rand.nextFloat() + rand.nextFloat() - 1) * (float)0.15;
	
			// Finally, we calculate the level
			int final_level = (int)(k * rand_bonus_percent + 0.5);
			
			//Step Two
			//for each level range above (top of declaration), choose the one this contains final_level
			//If multiple contain final_level, take the highest
			
			int power = 0;
			if (this.levelThreeStart < final_level && final_level < this.levelThreeEnd){
				power = 3;
			} else if (this.levelTwoStart < final_level && final_level < this.levelTwoEnd){
				power = 2;
			} else if (this.levelOneStart < final_level && final_level < this.levelOneEnd){
				power = 1;
			}
			if (power > 0 && rand.nextDouble() < this.chanceOfEnchant){
				List<String> lore = new ArrayList<String>();
				lore.add("Spell Casting " + String.valueOf(power));
				ItemStack item = event.getItem();
				item.setType(Material.STICK);
				item.setAmount(1);
				ItemMeta im = item.getItemMeta();
				im.setDisplayName("Wand of Power");
				im.setLore(lore);
				item.setItemMeta(im);
				event.getEnchanter().sendMessage(ChatColor.GREEN + "Poof! Your lowly wooden sword has turned into a mighty Wand of Power!");
			}
		}
	}
	
	@EventHandler
	public void onProjectileHit(ProjectileHitEvent event){
		/*SpellItem spell = SpellItem.getInstanceOfSpell(event.getEntity());
		if (spell != null){
			spell.useItem(event.getEntity().getLocation());
		}*/
	}
}
