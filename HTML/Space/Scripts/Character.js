var import1 = document.createElement("script");
import1.src = "Scripts/GeneralFunctions.js";
document.head.appendChild(import1);

var import2 = document.createElement("script");
import2.src = "Scripts/Shield.js";
document.head.appendChild(import2);

function Character(canvWidth, canvHeight, model){
	this.charX = worldWidth/2;
	this.charY = worldHeight/2;
	this.rotation = 0;
	this.totalMass = 30;
	this.momentOfInertia = 2;
	this.omega = 0; //angular velocity
	this.vX = 0; //linear x vel
	this.vY = 0; //linear y vel

	this.screenWidth = canvWidth;
	this.screenHeight = canvHeight;

	this.charModel = model;

	//center of ship, for drawing
	this.onscreenX = canvWidth/2;
	this.onscreenY = canvHeight/2;
	//upper left corner of ship
	this.shipX = this.onscreenX - this.charModel.width/2;
	this.shipY = this.onscreenY - this.charModel.height/2;

	this.centerX = 18; //approximate values, dependent on draw func
	this.centerY = 24;

	this.health = 20; //max 100
	this.baseHpGain = 0.15; //*0 at first, *1 after 5 seconds without damage, *3.5 after 15 seconds without damage
	this.tier1Time = 5*50;
	this.tier2Time = 13*50;
	this.tier2Mult = 3.5;
	this.timeSinceLastDamage = 0;

	this.shields = new Shield(model, 1.1, "0, 50, 200", 0.5);

	this.leftForwardEngine = {x:3, y:42, fX:0, fY:-5, d:0};
	this.rightForwardEngine = {x:33, y:42, fX:0, fY:-5, d:0};

	var leftDist = Math.sqrt((this.leftForwardEngine.x-this.centerX)*(this.leftForwardEngine.x-this.centerX) + (this.leftForwardEngine.y-this.centerY)*(this.leftForwardEngine.y-this.centerY));
	this.leftForwardEngine.d = leftDist;
	this.rightForwardEngine.d = leftDist;

	this.backwardsEngine = {x:18, y:5, fX:0, fY:5, d:0};

	var backDist = Math.sqrt((this.backwardsEngine.x-this.centerX)*(this.backwardsEngine.x-this.centerX) + (this.backwardsEngine.y-this.centerY)*(this.backwardsEngine.y-this.centerY));
	this.backwardsEngine.d = backDist;

	this.leftTimer = 0;
	this.rightTimer = 0;
}


Character.prototype.changeVels = function(projX, projY, orth, r){
	//w looks kinda like omega :P
	//l means linear
	var aW = orth/(this.totalMass*this.momentOfInertia);
	var aLX = projX/this.totalMass;
	var aLY = projY/this.totalMass; 

	var dir = Math.atan2(aLY, aLX);
	var len = Math.sqrt(aLX*aLX + aLY*aLY);

	aLX = len * Math.cos(dir + this.rotation + Math.PI*2);
	aLY = len * Math.sin(dir + this.rotation + Math.PI*2);

	this.omega += aW*dT/r;
	this.vX += aLX*dT;
	this.vY += aLY*dT;
}

Character.prototype.fireLeftGun = function(){
	if (this.leftTimer == 0){
		this.leftTimer = 30;
		
		var projStartPos = rotatePoint(this.shipX + 10, this.shipY + 13, this.onscreenX, this.onscreenY, this.rotation);
		var newProj = new Projectile(projStartPos.x, projStartPos.y, this.vX, this.vY, 5, this.rotation - Math.PI/2, this.screenWidth, this.screenHeight, this);

		return newProj;

		//return new Laser(10, 13, 5, "77, 232, 26", null);
	}
}

Character.prototype.fireRightGun = function(){
	if (this.rightTimer == 0){
		this.rightTimer = 60;

		/*var projStartPos = rotatePoint(this.shipX + 26, this.shipY + 13, this.onscreenX, this.onscreenY, this.rotation);
		var newProj = new Projectile(projStartPos.x, projStartPos.y, this.vX, this.vY, 5, this.rotation - Math.PI/2, this.screenWidth. this.screenHeight, this);

		return newProj;*/

		return new Laser(26, 13, 5, "77, 232, 26", null);
	}
}

Character.prototype.draw = function(ctx, buffer){
	if (this.leftTimer > 0){
		this.leftTimer--;
	}

	if (this.rightTimer > 0){
		this.rightTimer--;
	}

	this.timeSinceLastDamage++;
	if (this.health < 100){
		if (this.timeSinceLastDamage > this.tier2Time){
			this.health += this.baseHpGain * this.tier2Mult;
		} else if (this.timeSinceLastDamage > this.tier1Time){
			this.health += this.baseHpGain;
		}

		if (this.health > 100){
			this.health = 100;
		}
	}

	this.charX += this.vX;
	this.charY += this.vY;
	this.rotation += this.omega;

	this.shields.update();

	//ctx.fillRect(this.shipX, this.shipY, this.charModel.width, this.charModel.height);

	drawRotatedImage(this.charModel, this.onscreenX, this.onscreenY, this.rotation);
	drawRotatedImage(buffer, this.onscreenX, this.onscreenY, this.rotation);

	this.shields.draw(ctx, this.onscreenX, this.onscreenY, this.rotation);
}

Character.prototype.forward = function (bufferCtx, addedPadding){
	newVals = applyForce(this.leftForwardEngine.x-this.centerX, this.leftForwardEngine.y-this.centerY, this.leftForwardEngine.fX, this.leftForwardEngine.fY, this.leftForwardEngine.d);
	this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

	newVals = applyForce(this.rightForwardEngine.x-this.centerX, this.rightForwardEngine.y-this.centerY, this.rightForwardEngine.fX, this.rightForwardEngine.fY, this.rightForwardEngine.d);
	this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

	drawExhaust(this.leftForwardEngine.x + addedPadding, this.leftForwardEngine.y + addedPadding, 0, bufferCtx);
	drawExhaust(this.rightForwardEngine.x + addedPadding, this.rightForwardEngine.y + addedPadding, 0, bufferCtx);
}

Character.prototype.backward = function (bufferCtx, addedPadding){
	newVals = applyForce(this.backwardsEngine.x-this.centerX, this.backwardsEngine.y-this.centerY, this.backwardsEngine.fX, this.backwardsEngine.fY, this.backwardsEngine.d);
	this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

	drawExhaust(this.backwardsEngine.x + addedPadding, this.backwardsEngine.y + addedPadding, Math.PI, bufferCtx);
}

Character.prototype.left = function(bufferCtx, addedPadding){
	newVals = applyForce(this.rightForwardEngine.x-this.centerX, this.rightForwardEngine.y-this.centerY, this.rightForwardEngine.fX, this.rightForwardEngine.fY, this.rightForwardEngine.d);
	this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

	drawExhaust(this.rightForwardEngine.x + addedPadding, this.rightForwardEngine.y + addedPadding, 0, bufferCtx);
}

Character.prototype.right = function (bufferCtx, addedPadding){
	newVals = applyForce(this.leftForwardEngine.x-this.centerX, this.leftForwardEngine.y-this.centerY, this.leftForwardEngine.fX, this.leftForwardEngine.fY, this.leftForwardEngine.d);
	this.changeVels(newVals.projX, newVals.projY, newVals.orth, newVals.mag);

	drawExhaust(this.leftForwardEngine.x + addedPadding, this.leftForwardEngine.y + addedPadding, 0, bufferCtx);
}