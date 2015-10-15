package me.Andrew.BukkitCombat;

import org.bukkit.entity.Player;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.EntityDamageByEntityEvent;
import org.bukkit.plugin.java.JavaPlugin;

public class Main extends JavaPlugin implements Listener {

	public void onEnable() {
		getLogger().info("Bukkit Combat Enabled!");
		getServer().getPluginManager().registerEvents(this, this);
	}
	
	public void onDisable() {
		getLogger().info("Bukkit Comabt Disabled!");
	}
	
	@EventHandler
	public void onEntityDamage(EntityDamageByEntityEvent event){
		if (event.getDamager() instanceof Player){
			Player player = (Player)event.getDamager();
			CombatPlayer combatPlayer = CombatPlayer.getInstanceOfPlayer(player, this);
			if (player.isSprinting()){
				combatPlayer.registerSprintHit();
			}
			if (player.getVelocity().getBlockY() > 0){
				combatPlayer.registerUpHit();
			}
			combatPlayer.playerAttack(event);
		}
	}
}
