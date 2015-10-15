package me.WhitePrism.BetterCombat;

import org.bukkit.Material;
import org.bukkit.entity.Player;
import org.bukkit.entity.ThrownPotion;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.PlayerInventory;
import org.bukkit.potion.Potion;

public class Wand {
	
	private static double costForCast = 30;
	private static double wandEnergyBonus = 1.25;
	private static double launchSpeed = 1;
	
	public static int isWand(ItemStack item){
		if (item.getType() == Material.STICK && item.getItemMeta().getDisplayName().equals("Wand of Power")){
			for (String thisLore : item.getItemMeta().getLore()){
				if (thisLore.contains("Spell Casting")){
					return Integer.parseInt("" + thisLore.charAt(thisLore.length() - 1));
				}
			}
		}
		return 0;
	}
	
	public static void launchPotion(ItemStack potion, Player player, int power){
		ThrownPotion thrownPot = (ThrownPotion)player.launchProjectile(ThrownPotion.class, player.getLocation().getDirection().multiply(Wand.launchSpeed));
		Potion pot = Potion.fromItemStack(potion);
		pot.getEffects().clear();
		thrownPot.setItem(pot.toItemStack(1));
	}
	
	/*public static SpellItem launchItem(Class<?extends Projectile> launchClass, ItemStack item, CombatPlayer player, int power){
		Projectile thrown = player.player.launchProjectile(launchClass, player.player.getLocation().getDirection().multiply(Wand.launchSpeed + 1));
		return SpellItem.createSpellItem(item, thrown, power, player, player.plugin);
	}*/
	
	@SuppressWarnings("deprecation")
	public static void removePotion(ItemStack comparePotion, int potionSlot, CombatPlayer player){
		PlayerInventory inv = player.player.getInventory();
		boolean removed = false;
		for (int i = 35; i >= 0; i--){
			ItemStack thisItem = inv.getItem(i);
			if (thisItem != null && thisItem.getType() == Material.POTION){
				if (thisItem.getDurability() == comparePotion.getDurability() && i != potionSlot && !removed){
					inv.setItem(i, new ItemStack(Material.AIR, 0));
					removed = true;
				}
			}
		}
		if (!removed){
			inv.removeItem(new ItemStack[] {inv.getItem(potionSlot)});
			player.selectedPotion = null;
			player.selectedSlot = 0;
			
		}
		player.player.updateInventory();
	}
	
	public static boolean castPotion(CombatPlayer player, int power){
		if (player.energy * Wand.wandEnergyBonus >= Wand.costForCast && player.selectedPotion != null){
			player.energy -= Wand.costForCast;
			Wand.launchPotion(player.selectedPotion, player.player,power);
			Wand.removePotion(player.selectedPotion, player.selectedSlot, player);
			return true;
		}
		return false;
	}
	
	public static boolean castSpell(CombatPlayer player, int power){
		if (player.energy * Wand.wandEnergyBonus >= Wand.costForCast && player.selectedPotion != null){
			player.energy -= Wand.costForCast;
			//SpellItem spell = Wand.launchItem(SpellItem.projTypeForItem(player.selectedPotion), player.selectedPotion, player, power);
			//spell.decreaseItemByOne();
			return true;
		}
		return false;
	}

}
