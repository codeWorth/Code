//explosion models
var explosionPics = [];
for (var i = 1; i <= 16; i++){
	var img = new Image();
	img.src = "ExplosionPics/explosion-"+String(i)+".tiff";
	explosionPics.push(img);
}

var shapePadding = 0;
for (var i = 0; i < explosionPics.length; i++){
	var curImage = explosionPics[i];
	if (Math.max(curImage.width, curImage.height) > this.shapePadding){
		this.shapePadding = Math.max(curImage.width, curImage.height);
	}
}
shapePadding *= 0.5;

function Explosion(x, y, screenWidth, screenHeight){
	this.x = x;
	this.y = y;
	this.n = 0;

	this.screenWidth = screenWidth;
	this.screenHeight = screenHeight;
}

Explosion.prototype.draw = function(ctx, character) {
	var curImage = explosionPics[this.n];

	if (!outOfBounds(this.screenX(), this.screenY(), this.screenWidth, this.screenHeight, shapePadding)){
		ctx.drawImage(curImage, this.screenX(), this.screenY());
	}

	this.n++;
};

Explosion.prototype.isFinished = function(){
	return this.n === explosionPics.length;
}

Explosion.prototype.screenX = function (){
	return this.x - curImage.width/2 + character.shipX - character.charX;
}
Explosion.prototype.screenY = function (){
	return this.y - curImage.height/2 + character.shipY - character.charY;
}