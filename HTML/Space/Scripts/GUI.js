var import1 = document.createElement("script");
import1.src = "Scripts/GeneralFunctions.js";
document.head.appendChild(import1);

function updateGui(ctx, character, shieldMeterModel, innerShieldMeterCanvas){
	innerShieldMeterCanvas.width = shieldMeterModel.width;
	innerShieldMeterCanvas.height = shieldMeterModel.height;
	var innerShieldMeterCtx = innerShieldMeterCanvas.getContext('2d');

	var hpCrossX = 30; //left
	var hpCrossY = canvHeight - 30; //bottom
	var hpCrossSize = 80;
	var hpCrossInnerSize = 27;
	var hpCrossOuterSize = (hpCrossSize - hpCrossInnerSize)/2;

	ctx.fillStyle = "red";

	ctx.strokeStyle = "white";
	ctx.lineWidth = 2;
	ctx.beginPath();
	ctx.moveTo(hpCrossX + hpCrossOuterSize, hpCrossY); //left center, outer bottom
	ctx.lineTo(hpCrossX + hpCrossOuterSize, hpCrossY - hpCrossOuterSize); //left center, bottom center
	ctx.lineTo(hpCrossX, hpCrossY - hpCrossOuterSize); //outer left, bottom center 
	ctx.lineTo(hpCrossX, hpCrossY - hpCrossOuterSize - hpCrossInnerSize); //outer left, top center
	ctx.lineTo(hpCrossX + hpCrossOuterSize, hpCrossY - hpCrossOuterSize - hpCrossInnerSize); //left center, top center
	ctx.lineTo(hpCrossX + hpCrossOuterSize, hpCrossY - hpCrossSize); //left center, outer top
	ctx.lineTo(hpCrossX + hpCrossOuterSize + hpCrossInnerSize, hpCrossY - hpCrossSize); //right center, outer top
	ctx.lineTo(hpCrossX + hpCrossOuterSize + hpCrossInnerSize, hpCrossY - hpCrossOuterSize - hpCrossInnerSize); //right center, top center
	ctx.lineTo(hpCrossX + hpCrossSize, hpCrossY - hpCrossOuterSize - hpCrossInnerSize); //outer right, top center
	ctx.lineTo(hpCrossX + hpCrossSize, hpCrossY - hpCrossOuterSize); //outer right, bottom center
	ctx.lineTo(hpCrossX + hpCrossOuterSize + hpCrossInnerSize, hpCrossY - hpCrossOuterSize); //right center, bottom center
	ctx.lineTo(hpCrossX + hpCrossOuterSize + hpCrossInnerSize, hpCrossY); //right center, outer bottom
	ctx.closePath();

	ctx.stroke();

	var healthHeight = character.health/100 * hpCrossSize;
	var padding = 1;

	ctx.beginPath();
	//make inner rect first
	ctx.moveTo(hpCrossX + hpCrossOuterSize + padding, hpCrossY - padding); //left center, outer bottom
	ctx.lineTo(hpCrossX + hpCrossOuterSize + hpCrossInnerSize - padding, hpCrossY - padding); //right center, outer bottom
	ctx.lineTo(hpCrossX + hpCrossOuterSize + hpCrossInnerSize - padding, hpCrossY - healthHeight + padding); //right center, height
	ctx.lineTo(hpCrossX + hpCrossOuterSize + padding, hpCrossY - healthHeight + padding); //left center, height

	ctx.closePath();
	ctx.fill();

	//then make middle rectangle
	if (healthHeight > hpCrossOuterSize){
		var aboveHeight = healthHeight - hpCrossOuterSize;
		if (aboveHeight > hpCrossInnerSize){
			aboveHeight = hpCrossInnerSize;
		}

		ctx.beginPath();
		ctx.moveTo(hpCrossX + padding, hpCrossY - hpCrossOuterSize - padding); //outer left, bottom center 
		ctx.lineTo(hpCrossX + hpCrossSize - padding, hpCrossY - hpCrossOuterSize - padding); //outer right, bottom center
		ctx.lineTo(hpCrossX + hpCrossSize - padding, hpCrossY - hpCrossOuterSize - aboveHeight + padding); //outer right, height
		ctx.lineTo(hpCrossX + padding, hpCrossY - hpCrossOuterSize - aboveHeight + padding); //outer left, height
		ctx.closePath();

		ctx.fill();
	}

	//draw outer shield ellipse meter
	var ellipseX = 150;
	var ellipseY = canvHeight - 70;
	padding = 1;

	ctx.beginPath();
	pathEllipse(ctx, ellipseX, ellipseY, shieldMeterModel.width + padding*2, shieldMeterModel.height + padding*2);
	ctx.closePath();
	ctx.strokeStyle = "lightBlue";
	ctx.stroke();		

	//draw innerPart
	var removeShieldsHeight = shieldMeterModel.height * (1 - character.shields.level/100);

	innerShieldMeterCtx.clearRect(0, 0, innerShieldMeterCanvas.width, innerShieldMeterCanvas.height);
	innerShieldMeterCtx.drawImage(shieldMeterModel, 0, 0);
	innerShieldMeterCtx.clearRect(0, 0, innerShieldMeterCanvas.width, removeShieldsHeight);

	ctx.drawImage(innerShieldMeterCanvas, ellipseX - innerShieldMeterCanvas.width/2, ellipseY - innerShieldMeterCanvas.height/2);
}