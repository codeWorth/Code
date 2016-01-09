function Planet(x, y, r, color, mainChar, canvWidth, canvHeight) {
	this.x = x;
	this.y = y;
	this.r = r;
	this.color = color;

	this.mainChar = mainChar;

	this.canvWidth = canvWidth;
	this.canvHeight = canvHeight;
}

Planet.prototype.draw = function(ctx, charX, charY) {
	if (outOfBounds(this.screenX(), this.screenY(), this.canvWidth, this.canvHeight, this.r)){
		return;
	}

	ctx.beginPath();
	ctx.moveTo(this.screenX(), this.screenY());
	ctx.arc(this.screenX(), this.screenY(), this.r, 0, Math.PI*2, true);
	ctx.closePath();
	ctx.fillStyle = this.color;
	ctx.fill();
};

Planet.prototype.screenX = function (){
	return this.x - this.mainChar.charX + this.canvWidth/2;
}
Planet.prototype.screenY = function (){
	return this.y - this.mainChar.charY + this.canvHeight/2;
}