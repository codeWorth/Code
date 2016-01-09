function Enemy(health, leftGunProj, rightGunProj, startX, startY, startDir, screenWidth, screenHeight, mainChar){ //left/rightGunProj true = projectile, false = laser
	this.health = health;
	this.leftProj = leftGunProj;
	this.rightProj = rightGunProj;
	this.totalMass = 30;
	this.momentOfInertia = 2;

	this.leftTimer = 0;
	this.rightTimer = 0;

	this.x = startX;
	this.y = startY;
	this.dir = startDir;

	this.vX = 0;
	this.vY = 0;
	this.w = 0;

	this.screenWidth = screenWidth;
	this.screenHeight = screenHeight;

	this.enemyModel = renderFunction(40, 50, function (ctx){
		ctx.beginPath();
		ctx.moveTo(3,42);
		ctx.lineTo(18,5);
		ctx.lineTo(32,42);
		ctx.arc(18,46,15,0-Math.PI/7,8*Math.PI/7,true);
		ctx.closePath();
		ctx.strokeStyle = "white";
		ctx.lineWidth = 3;
		ctx.stroke();
		ctx.beginPath();
		ctx.moveTo(10,24);
		ctx.lineTo(10,12);
		ctx.moveTo(26,24);
		ctx.lineTo(26,12);
		ctx.moveTo(10,24);
		ctx.closePath();
		ctx.lineWidth = 2;
		ctx.stroke();
	});

	this.enemyCX = 18;
	this.enemyCY = 24;

	this.addedPadding = 20;

	this.leftForwardEngine = {x:3, y:42, fX:0, fY:-5, d:0};
	this.rightForwardEngine = {x:33, y:42, fX:0, fY:-5, d:0};

	var leftDist = Math.sqrt((this.leftForwardEngine.x-this.enemyCX)*(this.leftForwardEngine.x-this.enemyCX) + (this.leftForwardEngine.y-this.enemyCY)*(this.leftForwardEngine.y-this.enemyCY));
	this.leftForwardEngine.d = leftDist;
	this.rightForwardEngine.d = leftDist;

	this.backwardsEngine = {x:18, y:5, fX:0, fY:5, d:0};

	var backDist = Math.sqrt((this.backwardsEngine.x-this.enemyCX)*(this.backwardsEngine.x-this.enemyCX) + (this.backwardsEngine.y-this.enemyCY)*(this.backwardsEngine.y-this.enemyCY));
	this.backwardsEngine.d = backDist;

	this.buffer = document.createElement('canvas');
   	this.buffer.width = this.enemyModel.width + this.addedPadding*2;
    this.buffer.height = this.enemyModel.height + this.addedPadding*2;
  	this.bufferCtx = this.buffer.getContext('2d');

  	this.mainChar = mainChar;

  	this.shapePad = Math.max(this.enemyModel.width, this.enemyModel.height)/2;
}

Enemy.prototype.fireLeftGun = function(){
	if (this.leftTimer == 0){
		if (this.leftProj){
			this.leftTimer = 120;
	
			var projStartPos = rotatePoint(this.screenX() - this.enemyModel.width/2 + 10, this.screenY() - this.enemyModel.height/2 + 13, this.screenX(), this.screenY(), this.dir);
			var newProj = new Projectile(projStartPos.x, projStartPos.y, this.vX, this.vY, 5, this.dir - Math.PI/2, this.screenWidth, this.screenHeight, this.mainChar);

			return newProj;
		} else {
			this.leftTimer = 180;

			return new Laser(10, 13, 5, "77, 232, 26", this);
		}
	}
}

Enemy.prototype.fireRightGun = function(){
	if (this.rightTimer == 0){
		if (this.rightProj){
			this.rightTimer = 120;
	
			var projStartPos = rotatePoint(this.screenX() - this.enemyModel.width/2 + 26, this.screenY() - this.enemyModel.height/2 + 13, this.screenX(), this.screenY(), this.dir);
			var newProj = new Projectile(projStartPos.x, projStartPos.y, this.vX, this.vY, 5, this.dir - Math.PI/2, this.screenWidth, this.screenHeight, this.mainChar);

			return newProj;
		} else {
			this.rightTimer = 180;

			return new Laser(26, 13, 5, "77, 232, 26", this);
		}
	}
}

Enemy.prototype.update = function (ctx){
	if (this.leftTimer > 0){
		this.leftTimer--;
	}
	if (this.rightTimer > 0){
		this.rightTimer--;
	}

	this.x += this.vX;
	this.y += this.vY;
	this.dir += this.w;

	this.draw();
}

Enemy.prototype.forward = function (){
	newVals = applyForce(this.leftForwardEngine.x - this.enemyCX, this.leftForwardEngine.y - this.enemyCY, this.leftForwardEngine.fX, this.leftForwardEngine.fY, this.leftForwardEngine.d);
	this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

	newVals = applyForce(this.rightForwardEngine.x - this.enemyCX, this.rightForwardEngine.y - this.enemyCY, this.rightForwardEngine.fX, this.rightForwardEngine.fY, this.rightForwardEngine.d);
	this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

	drawExhaust(this.leftForwardEngine.x + this.addedPadding, this.leftForwardEngine.y + this.addedPadding, 0, this.bufferCtx);
	drawExhaust(this.rightForwardEngine.x + this.addedPadding, this.rightForwardEngine.y + this.addedPadding, 0, this.bufferCtx);
}

Enemy.prototype.draw = function (){
	if (!outOfBounds(this.screenX(), this.screenY(), this.screenWidth, this.screenHeight, this.shapePad)){
		drawRotatedImage(this.enemyModel, this.screenX(), this.screenY(), this.dir);

		drawRotatedImage(this.buffer, this.screenX(), this.screenY(), this.dir);
		this.bufferCtx.clearRect(0, 0, this.buffer.width, this.buffer.height);
	}
}

Enemy.prototype.screenX = function (){
	return this.x - this.mainChar.charX + this.mainChar.onscreenX;	
}

Enemy.prototype.screenY = function (){
	return this.y - this.mainChar.charY + this.mainChar.onscreenY;	
}

Enemy.prototype.changeVels = function (projX, projY, orth, r){
	var aW = orth/(this.totalMass*this.momentOfInertia);
	var aLX = projX/this.totalMass;
	var aLY = projY/this.totalMass; 

	var dir = Math.atan2(aLY, aLX);
	var len = Math.sqrt(aLX*aLX + aLY*aLY);

	aLX = len * Math.cos(dir + this.dir + Math.PI*2);
	aLY = len * Math.sin(dir + this.dir + Math.PI*2);

	this.w += aW*dT/r;
	this.vX += aLX*dT;
	this.vY += aLY*dT;
}