var import1 = document.createElement("script");
import1.src = "Scripts/GeneralFunctions.js";
document.head.appendChild(import1);

function Projectile(startX, startY, vX, vY, speed, direction, screenWidth, screenHeight, character, enemies){
	this.mainChar = character;
	this.enemies = enemies;

	this.x = startX + character.charX - character.shipX;
	this.y = startY + character.charY - character.shipY;
	this.vX = vX;
	this.vY = vY;

	this.vX = speed * Math.cos(direction);
	this.vY = speed * Math.sin(direction);

	this.vX += vX;
	this.vY += vY;

	this.shape = projModel;
	this.shapePad = Math.max(this.shape.width, this.shape.height)/2;

	this.life = 55;

	this.screenWidth = screenWidth;
	this.screenHeight = screenHeight;
}

Projectile.prototype.move = function() {
	this.x += this.vX;
	this.y += this.vY;
	this.life--;
	
	/*
	var curEnem;
	for (var i = 0; i < this.enemies.length; i++){
		if ()
	}
*/
}
Projectile.prototype.isOutOfBounds = function (){
	return this.life === 0;
}
Projectile.prototype.draw = function (){
	if (!outOfBounds(this.screenX(), this.screenY(), this.screenWidth, this.screenHeight, this.shapePad)){
		drawRotatedImage(this.shape, this.screenX(), this.screenY(), this.direction);
	}
	this.move();
}

Projectile.prototype.screenX = function (){
	return this.x + this.mainChar.shipX - this.mainChar.charX;
}
Projectile.prototype.screenY = function (){
	return this.y + this.mainChar.shipY - this.mainChar.charY;
}

function Laser(startX, startY, lWidth, rgb, ship){
	this.startX = startX;
	this.startY = startY;
	this.lWidth = lWidth;
	this.rgb = rgb;
	this.life = 30;
	this.startLife = 30;
	this.length = 800;
	this.ship = ship;
}

Laser.prototype.draw = function (dir, character){
	var drawCenterX = character.onscreenX;
	var drawCenterY = character.onscreenY;
	var drawDir = character.rotation;

	var curModel = character.charModel;

	if (this.ship){
		drawCenterX = this.ship.screenX();
		drawCenterY = this.ship.screenY();
		drawDir = this.ship.dir;

		curModel = this.ship.enemyModel;
	}

	var color = "rgba("+ this.rgb + "," + String(this.life/this.startLife/2 + 0.5) + ")";
	var origPos = rotatePoint(this.startX - curModel.width/2, this.startY - curModel.height/2, 0, 0, drawDir);

	origPos.x += drawCenterX;
	origPos.y += drawCenterY;

	ctx.beginPath();
	ctx.arc(origPos.x, origPos.y, 8, 0, Math.PI*2, true);
	ctx.closePath();
	ctx.fillStyle = color;
	ctx.fill();

	ctx.beginPath();
	ctx.lineWidth = 2 + this.life/this.startLife * this.lWidth;
	ctx.moveTo(origPos.x, origPos.y);

	var endX = origPos.x + Math.cos(drawDir-Math.PI/2) * this.length;
	var endY = origPos.y + Math.sin(drawDir-Math.PI/2) * this.length;

	ctx.lineTo(endX, endY);
	ctx.strokeStyle = color;
	ctx.closePath();
	ctx.stroke();
	this.life--;
}

Laser.prototype.isOutOfBounds = function(){
	return !(this.life > 0)
}