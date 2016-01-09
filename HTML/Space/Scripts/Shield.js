var import1 = document.createElement("script");
import1.src = "Scripts/GeneralFunctions.js";
document.head.appendChild(import1);
									//COLOR MUST BE IN RGB (for example, color = "1, 2, 3" or "255, 255, 255")
function Shield(shipModel, padding, color, rechargeRate){ //model is model of ship to shield, padding is a percent to add to size of shield (1 = hits right on the corners, 1.5 = larger than the corners)
	this.shipModel = shipModel;
	this.padding = padding;

	this.rechargeRate = rechargeRate;

	this.color = color;

	//ellipse should hit corners of model
	/*
	x^2/a^2 + y^2/b^2 = 1
	w/h = a/b
	 		  -  -  -
			/    w    \
		  /	[---------] \
		 /	[         ]  \
		|  a[         ]   |
		|...[....X    ] h |
		|	[    .    ]   |
		 \	[    .b   ]  /
		  \ [---------] /
			\	 .	  /
			  -	 -	-

	when x = w/2, y should equal plus or minus h/2

	(w/2)^2/a^2 + (h/2)^2/b^2 = 1

	w/h = a/b
	a = wb/h

	(w/2)^2/(wb/h)^2 + (h/2)^2/b^2 = 1
	((w/2)^2/(w/h)^2 + (h/2)^2)/b^2 = 1
	(1/2)^2/(1/h)^2 + (h/2)^2 = b^2
	(h^2)/4 + (h^2)/4 = b^2
	(h^2)/2 = b^2

	so:
	a^2 = (w^2)/2

	aka a = w/sqrt(2)
	b = h/sqrt(2)

	2(x^2)/w^2 + 2(y^2)/h^2 = 1
	*/

	var w = shipModel.width;
	var h = shipModel.height;

	this.a = w/Math.sqrt(2) * padding;
	this.b = h/Math.sqrt(2) * padding;

	this.aSquared = w*w/2 * padding*padding;
	this.bSquared = h*h/2 * padding*padding;

	this.shieldModel = document.createElement('canvas');

	console.log(renderFunction);
	console.log(pathEllipse);

	this.pad = 2;

	this.shieldModel = document.createElement('canvas');
    this.shieldModel.width = this.a*2;
    this.shieldModel.height = this.b*2 + this.pad*2;
    var shieldCtx = this.shieldModel.getContext('2d');

	shieldCtx.lineWidth = this.pad;
	shieldCtx.strokeStyle = "rgb(" + this.color + ")";
	shieldCtx.fillStyle = "rgba(" + this.color + ", 0.7)";
	shieldCtx.beginPath();

	shieldCtx.moveTo(this.a, this.b - this.b + this.pad); // A1
  
	shieldCtx.bezierCurveTo(
		this.a + this.a, this.b - this.b, // C1
		this.a + this.a, this.b + this.b, // C2
		this.a, this.b + this.b); // A2

	shieldCtx.bezierCurveTo(
		this.a - this.a, this.b + this.b, // C3
		this.a - this.a, this.b - this.b + this.pad, // C4
		this.a, this.b - this.b + this.pad); // A1

	shieldCtx.closePath();
	shieldCtx.fill();
	shieldCtx.stroke();

	this.level = 10; //max 100
}

Shield.prototype.draw = function (ctx, centerX, centerY, rotation){
	drawRotatedImage(this.shieldModel, centerX, centerY - this.pad, rotation);
}

Shield.prototype.update = function (){
	if (this.level < 100){
		this.level += this.rechargeRate;
	}
}