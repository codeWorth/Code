function Enemy(health, leftGunProj, rightGunProj, startX, startY, startDir){ //left/rightGunProj true = projectile, false = laser
	this.health = health;
	this.leftProj = leftGunProj;
	this.rightProj = rightGunProj;

	this.leftTimer = 0;
	this.rightTimer = 0;

	this.x = startX;
	this.y = startY;
	this.dir = startDir;

	this.vX = 0;
	this.vY = 0;
	this.w = 0;
}

Enemy.prototype.fireLeftGun = function(){
	if (this.leftTimer == 0){
		if (this.leftProj){
			this.leftTimer = 30;
	
			var projStartPos = rotatePoint(this.screenX() - enemyModel.width/2 + 10, this.screenY() - enemyModel.height/2 + 13, this.screenX(), this.screenY(), this.dir);
			var newProj = new Projectile(projStartPos.x, projStartPos.y, this.vX, this.vY, 5, this.dir - Math.PI/2, projModel);

			projectiles.push(newProj);
		} else {
			this.leftTimer = 60;

			lasers.push(new Laser(10, 13, 5, "77, 232, 26", this));
		}
	}
}

Enemy.prototype.fireRightGun = function(){
	if (this.rightTimer == 0){
		if (this.rightProj){
			this.rightTimer = 30;
	
			var projStartPos = rotatePoint(this.screenX() - enemyModel.width/2 + 26, this.screenY() - enemyModel.height/2 + 13, this.screenX(), this.screenY(), this.dir);
			var newProj = new Projectile(projStartPos.x, projStartPos.y, this.vX, this.vY, 5, this.dir - Math.PI/2, projModel);

			projectiles.push(newProj);
		} else {
			this.rightTimer = 60;

			lasers.push(new Laser(26, 13, 5, "77, 232, 26", this));
		}
	}
}

Enemy.prototype.update = function (){
	if (this.leftTimer > 0){
		this.leftTimer--;
	}
	if (this.rightTimer > 0){
		this.rightTimer--;
	}

	this.x += this.vX;
	this.y += this.vY;
	this.dir += this.w;

	var addedPadding = 20;

	var buffer = document.createElement('canvas');
   	buffer.width = enemyModel.width + addedPadding*2;
    buffer.height = enemyModel.height + addedPadding*2;
  	var bufferCtx = buffer.getContext('2d');

	if (this.vY > -3){
		this.forward(bufferCtx, addedPadding);
	}

	this.fireLeftGun();
	this.fireRightGun();

	this.draw(buffer);
}

Enemy.prototype.forward = function (bufferCtx, addedPadding){
		newVals = applyForce(leftForwardEngine.x - enemyCX, leftForwardEngine.y - enemyCY, leftForwardEngine.fX, leftForwardEngine.fY, leftForwardEngine.d);
		this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

		newVals = applyForce(rightForwardEngine.x - enemyCX, rightForwardEngine.y - enemyCY, rightForwardEngine.fX, rightForwardEngine.fY, rightForwardEngine.d);
		this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

		drawExhaust(leftForwardEngine.x + addedPadding, leftForwardEngine.y + addedPadding, 0, bufferCtx);
		drawExhaust(rightForwardEngine.x + addedPadding, rightForwardEngine.y + addedPadding, 0, bufferCtx);
}

Enemy.prototype.draw = function (buffer){
	drawRotatedImage(enemyModel, this.screenX(), this.screenY(), this.dir);
	drawRotatedImage(buffer, this.screenX(), this.screenY(), this.dir);
}

Enemy.prototype.screenX = function (){
	return this.x - charX + onscreenX;	
}

Enemy.prototype.screenY = function (){
	return this.y - charY + onscreenY;	
}

Enemy.prototype.changeVels = function (projX, projY, orth, r){
	var aW = orth/(totalMass*momentOfInertia);
	var aLX = projX/totalMass;
	var aLY = projY/totalMass; 

	var dir = Math.atan2(aLY, aLX);
	var len = Math.sqrt(aLX*aLX + aLY*aLY);

	aLX = len * Math.cos(dir + this.dir + Math.PI*2);
	aLY = len * Math.sin(dir + this.dir + Math.PI*2);

	this.w += aW*dT/r;
	this.vX += aLX*dT;
	this.vY += aLY*dT;
}

function Projectile(startX, startY, vX, vY, speed, direction, shape){
	this.x = startX + charX - shipX;
	this.y = startY + charY - shipY;
	this.vX = vX;
	this.vY = vY;

	this.vX = speed * Math.cos(direction);
	this.vY = speed * Math.sin(direction);

	this.vX += vX;
	this.vY += vY;

	this.shape = shape;

	this.life = 55;
}

Projectile.prototype.move = function() {
	this.x += this.vX;
	this.y += this.vY;
	this.life--;
	
}
Projectile.prototype.isOutOfBounds = function (){
	var leftX = charX - canvWidth/2.2;
	var topY = charY - canvHeight/2.2;
	if (this.x < leftX - this.shape.width/2 || this.x > leftX + canvWidth + this.shape.width/2 || this.y < topY - this.shape.height/2 || this.y > topY + canvHeight + this.shape.height/2){
		return true;
	}
	return false;
}
Projectile.prototype.draw = function (){
	drawRotatedImage(this.shape, this.x + shipX - charX, this.y + shipY - charY, this.direction)
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

Laser.prototype.draw = function (dir){
	var drawCenterX = onscreenX;
	var drawCenterY = onscreenY;
	var drawDir = rotation;

	var curModel = charModel;

	if (this.ship){
		drawCenterX = this.ship.screenX();
		drawCenterY = this.ship.screenY();
		drawDir = this.ship.dir;

		curModel = enemyModel;
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

function Planet(x, y, r, color) {
	this.x = x;
	this.y = y;
	this.r = r;
	this.color = color;
}