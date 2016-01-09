projModel = renderFunction(8, 8, function (ctx){
	ctx.beginPath();
	ctx.moveTo(4,4);
	ctx.arc(4,4,4,0,Math.PI*2,true);
	ctx.closePath();
	ctx.fillStyle = "green";
	ctx.fill();
});

shieldMeterModel = renderFunction(70, 88, function (ctx){
	ctx.beginPath();
	pathEllipse(ctx, 35, 44, 70, 88);
	ctx.closePath();
	ctx.fillStyle = "rgb(0, 86, 161)";
	ctx.fill();
});

shieldModel = renderFunction(70, 88, function (ctx){
	ctx.lineWidth = 2;
	ctx.strokeStyle = "rgb(" + "0, 50, 200" + ")";
	ctx.fillStyle = "rgba(" + "0, 50, 200" + ", 0.7)";
	ctx.beginPath();
	pathEllipse(ctx, 29, 35.5, 58, 70);
	ctx.closePath();
	ctx.fill();
	ctx.stroke();
});

charModel = renderFunction(38, 48, function (ctx){
	ctx.beginPath();
	ctx.moveTo(4,42);
	ctx.lineTo(18,6);
	ctx.lineTo(32,42);
	ctx.arc(18,46,15,0-Math.PI/7,8*Math.PI/7,true);
	ctx.closePath();
	ctx.strokeStyle = "white";
	ctx.lineWidth = 3;
	ctx.stroke();
	ctx.beginPath();
	ctx.moveTo(11,24);
	ctx.lineTo(11,12);
	ctx.moveTo(26,24);
	ctx.lineTo(26,12);
	ctx.moveTo(11,24);
	ctx.closePath();
	ctx.lineWidth = 2;
	ctx.stroke();
});

function pathEllipse(context, centerX, centerY, width, height) {  
  context.moveTo(centerX, centerY - height/2); // A1
  
  context.bezierCurveTo(
    centerX + width/2, centerY - height/2, // C1
    centerX + width/2, centerY + height/2, // C2
    centerX, centerY + height/2); // A2

  context.bezierCurveTo(
    centerX - width/2, centerY + height/2, // C3
    centerX - width/2, centerY - height/2, // C4
    centerX, centerY - height/2); // A1
 
}

function outOfBounds(x, y, screenWidth, screenHeight, padding){
	var xDist = x - screenWidth/2 + padding;
	var yDist = y - screenHeight/2 + padding;

	if (xDist*xDist > screenWidth*screenWidth || yDist*yDist > screenHeight*screenHeight){
		return true;
	}
	return false;
}

function renderFunction(width, height, renderFunction) {
    var buffer = document.createElement('canvas');
    buffer.width = width;
    buffer.height = height;
    renderFunction(buffer.getContext('2d'));
    return buffer;
}

 
function rotatePoint(x, y, centerX, centerY, newRot){
	var difX = x - centerX;
	var difY = y - centerY;
	var len = Math.sqrt(difX*difX + difY*difY);

	var curDir = Math.atan2(difY, difX);

	var newX = len*Math.cos(curDir + newRot + Math.PI*2) + centerX;
	var newY = len*Math.sin(curDir + newRot + Math.PI*2) + centerY;

	return {x:newX, y:newY};
}

function applyForce(rX, rY, fX, fY, mFC){ //rX and rY are the distances from point of force to center of mass. fX and fY is the force. Returns an object: {projX:..., projY:..., orth:..., r:...} Towards is the amount of force towards the center of mass, normal is the amount normal to it, r is the distance from the force to the center. Also takes magnitude of FC, which is optional. It will be ignored if it is 0.
	//rotate force vectors for direction of ship

	var mag = 1;
	if (mFC === 0){
		var magSquared = rX*rX + rY*rY;
		if (magSquared === 0){
			return false;
		} else {
			mag = Math.sqrt(magSquared);
		}
	} else {
		mag = mFC;
	}

	var dot = fX*rX + fY*rY;
	var proj = dot/mag;

	var orth = Math.sqrt (fX*fX + fY*fY - proj*proj);
	var crossZ = rX*fY - rY*fX;
	if (crossZ < 0){
		orth *= -1;
	}

	var projX = proj/mag * rX;
	var projY = proj/mag * rY;

	return {projX:projX, projY:projY, orth:orth, mag:mag};

	/*
	dot product = fX*rX + fY*rY

	projection of f onto fC = dot product / magnitude fC
	orthagonal of f onto fC = sqrt (magSquared - proj*proj)
	*/
}

function drawRotatedImage(image, centerX, centerY, angle) { 			 
	// save the current co-ordinate system 
	ctx.save(); 
 
	// move to the middle of where we want to draw our image
	ctx.translate(centerX, centerY);
 
	// rotate around that point
	ctx.rotate(angle);
 
	// draw it up and to the left by half the width
	// and height of the image 
	ctx.drawImage(image, -(image.width/2), -(image.height/2));
 
	// and restore the co-ords to how they were when we began
	ctx.restore(); 
}

