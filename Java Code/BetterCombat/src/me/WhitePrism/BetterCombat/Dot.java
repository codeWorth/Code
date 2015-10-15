package me.WhitePrism.BetterCombat;

public class Dot {
	public double dps;
	public double dotTime;
	private double currentTime = 0;
	
	public Dot(double damageDone){
		this.dps = damageDone/5;
		this.dotTime = 6 - damageDone/10;
	}
	
	public double tick(){
		if (currentTime >= dotTime){
			return 0;
		} else {
			currentTime += 1;
			return dps;
		}
	}
}
