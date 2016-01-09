//thruster exhaust model
var thrusterImg = new Image();
thrusterImg.src = "Space Thruster.png";

function drawExhaust(x, y, rotation, ctx){
	ctx.save(); 
 
	ctx.translate(x, y);
	ctx.rotate(rotation - Math.PI/2);
	ctx.drawImage(thrusterImg, -(thrusterImg.width/2) - 10, -(thrusterImg.height/2));
 
	ctx.restore(); 
}