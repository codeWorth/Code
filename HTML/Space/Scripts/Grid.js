function Grid(spacing, worldWidth, worldHeight){
	this.spacing = spacing;
	this.worldWidth = worldWidth;
	this.worldHeight = worldHeight;
}

Grid.prototype.draw = function(x, y, ctx) {
	var xOff = (x - canvWidth/2) % gridSpace;
	var yOff = (y - canvHeight/2) % gridSpace;

	var xLinesToDraw = canvWidth/gridSpace;
	var yLinesToDraw = canvHeight/gridSpace;

	ctx.strokeStyle = 'rgba(255, 255, 255, 0.3)';
	ctx.lineWidth = 2;

	ctx.beginPath();

	for (var i = -1; i < xLinesToDraw + 1; i++){
		ctx.moveTo(gridSpace*i - xOff, 0);
		ctx.lineTo(gridSpace*i - xOff, canvHeight);
	}

	for (var i = -1; i < yLinesToDraw + 1; i++){
		ctx.moveTo(0, gridSpace*i - yOff);
		ctx.lineTo(canvWidth, gridSpace*i - yOff);
	}

	ctx.moveTo(xOff, 0);
	ctx.closePath();

	ctx.stroke();

	ctx.beginPath();
	ctx.lineWidth = 1;
	ctx.strokeStyle = "rgba(255,255,255,1)";

	if (y < canvHeight/2){ //upper left corner
		ctx.moveTo(0, canvHeight/2 - y);
		ctx.lineTo(canvWidth, canvHeight/2 - y);
		ctx.moveTo(0, canvHeight/2 - y);
	} else if (y > worldHeight - canvHeight/2) { //lower left corner
		ctx.moveTo(0, worldHeight + canvHeight/2 - y);
		ctx.lineTo(canvWidth, worldHeight + canvHeight/2 - y);
		ctx.moveTo(0, worldHeight + canvHeight/2 - y);
	}

	if (x < canvWidth/2){
		ctx.moveTo(canvWidth/2 - x, 0);
		ctx.lineTo(canvWidth/2 - x, canvHeight);
		ctx.moveTo(canvWidth/2 - x, 0);
	} else if (x > worldWidth - canvWidth/2){
		ctx.moveTo(worldWidth + canvWidth/2 - x, 0);
		ctx.lineTo(worldWidth + canvWidth/2 - x, canvHeight);
		ctx.moveTo(worldWidth + canvWidth/2 - x, 0);
	}

	ctx.closePath();
	ctx.stroke();
};