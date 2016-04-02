function Minimap(miniWidthPx, miniHeightPx, worldPercent, ctx, mainChar){ //worldPercent is what percentage (0 to 1) of the width of the world is on the minimap at any one time
	this.width = miniWidthPx;
	this.height = miniHeightPx;
	this.ctx = ctx;
	this.mainChar = mainChar;

	//given worldWidth = 500, worldPercent = 0.4, left side of minimap is at 100 in world coords, minimap width = 200 pixels, and object we want to draw is at 150 in world coords
	//relative pos = 150 - 100 = 50 = x
	//minimap world width = 500*0.4 = 200
	//the players percent on the minimap is x/200 = 0.25
	//0.25*minimap width(200) = 50 pixels from the left of the minimap
	//if x is relative pos, then pixels from left = x/(worldWidth*worldPercent) * minimapWidth
	this.worldToMiniMult = miniWidthPx/(worldWidth*worldPercent);
}

Minimap.prototype.clear = function (){
	this.ctx.clearRect(0,0,this.width,this.height);
}

Minimap.prototype.drawCircle = function (x, y, r, color){
	var miniX = (x-this.mainChar.charX)*this.worldToMiniMult + this.width/2;
	var miniY = (y-this.mainChar.charY)*this.worldToMiniMult + this.height/2;
	var miniR = r*this.worldToMiniMult;

	this.ctx.beginPath();
	this.ctx.arc(miniX, miniY, miniR, 0, Math.PI*2, true);
	this.ctx.closePath();

	this.ctx.fillStyle = color;
	this.ctx.fill();
}

Minimap.prototype.drawCenterLine = function (rot, len){ //rot is rotation is radians
	rot -= Math.PI/2;
	this.ctx.moveTo(this.width/2, this.height/2);
	this.ctx.lineTo(this.width/2 + len*Math.cos(rot), this.height/2 + len*Math.sin(rot));
	this.ctx.strokeStyle = "white";
	this.ctx.stroke();

	this.ctx.beginPath();
	this.ctx.arc(this.width/2, this.height/2, len/4, 0, Math.PI*2, true);
	this.ctx.closePath();
	this.ctx.fillStyle = "white";
	this.ctx.fill();
}