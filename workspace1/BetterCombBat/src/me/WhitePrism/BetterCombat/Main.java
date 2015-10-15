package me.WhitePrism.BetterCombat;



import java.util.Random;

import org.bukkit.Bukkit;
import org.bukkit.Material;
import org.bukkit.entity.Player;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.event.entity.EntityDamageEvent;
import org.bukkit.event.player.PlayerInteractEntityEvent;
import org.bukkit.plugin.java.JavaPlugin;

public class Main extends JavaPlugin{
	public void onEnable() {
		Bukkit.getServer().getLogger().info("Test Plugin Enabled!");
	}
	
	public void onDisable() {
		Bukkit.getServer().getLogger().info("Test Plugin Disabled!");
	}
	public void onEntityDamage(EntityDamageEvent event){
		if(event instanceof EntityDamageByEntityEvent){
			Bukkit.getServer().getLogger().info("Damage done.");
			EntityDamageByEntityEvent e = (EntityDamageByEntityEvent) event;
			if (e.getDamager() instanceof Player){
				Player attacker = (Player) e.getDamager();
				double angle = attacker.getLocation().getDirection().angle(e.getEntity().getLocation().getDirection()) / 180 * Math.PI;
				if (angle > 90 || angle < -90){
					Bukkit.getServer().getLogger().info("Crit!");
					double damage = event.getDamage();
					int critAmount = critForMaterial(attacker.getItemInHand().getType());
					Random rand = new Random();
					damage += rand.nextInt(critAmount / 2 + 2);
					event.setDamage(damage);
				}
			}
		}
	}
	public void onPlayerInteractEntity(PlayerInteractEntityEvent event){
		if (event.getRightClicked() instanceof Player){
			Player selected = (Player) event.getRightClicked();
			Player clicker = event.getPlayer();
			if (clicker.getEyeLocation().distance(selected.getEyeLocation()) < 5){
				
			}
		}
	}
	
	public int critForMaterial(Material mat){
		if (mat == Material.WOOD_SWORD){
			return 11;
		} else if (mat == Material.STONE_SWORD){
			return 13;
		} else if (mat == Material.GOLD_SWORD){
			return 11;
		} else if (mat == Material.IRON_SWORD){
			return 15;
		} else if (mat == Material.DIAMOND_SWORD){
			return 17;
		} else {
			return 0;
		}
	}
}
