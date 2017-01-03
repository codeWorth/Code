function elementsWithTagNameAndClass(tagName,wantedClass){
	var allElements = document.getElementsByTagName(tagName);
	var classElements = [];
	for (var i = 0;i<allElements.length;i++){
		if (allElements[i].className == wantedClass){
			classElements.push(allElements[i]);
		}
	}
	return classElements;
}
function changeOpacity(element,changeEachTime,timeBetweenEach,changes,fadeIndex){
	var oldOp = parseFloat(element.style.opacity);
	element.style.opacity = oldOp + changeEachTime;
	fadeIndex++;
	if (fadeIndex < changes){
		setTimeout(function() {changeOpacity(element,changeEachTime,timeBetweenEach,changes,fadeIndex);},timeBetweenEach);
	}
}

function leftCycleTrigger(e,scrollItems,scrollTexts,currentScrollIndex,fadeInOrOutTime,numOfChanges,updateScrollFunc,manageScrollVar) {
	var image1 = scrollItems[currentScrollIndex];
	var imageReturns1 = calculateCorrectChanges(image1,0,fadeInOrOutTime,numOfChanges);
	var changeEachTime1 = imageReturns1[0];
	var timeBetween1 = imageReturns1[1];
	
	var text1 = scrollTexts[currentScrollIndex];
	
	currentScrollIndex = manageScrollVar();
	
	var image2 = scrollItems[currentScrollIndex];
	var imageReturns2 = calculateCorrectChanges(image2,1,fadeInOrOutTime,numOfChanges);
	var changeEachTime2 = imageReturns2[0];
	var timeBetween2 = imageReturns2[1];
	
	var text2 = scrollTexts[currentScrollIndex];
	text2.style.zIndex='0';
	
	changeOpacity(image1,changeEachTime1,timeBetween1,numOfChanges,0);
	changeOpacity(text1,changeEachTime1,timeBetween1,numOfChanges,0);
	
	setTimeout(function () {
		changeOpacity(image2,changeEachTime2,timeBetween2,numOfChanges,0);
		changeOpacity(text2,changeEachTime2,timeBetween2,numOfChanges,0);
	}, offsetFadeInTime);
	
	setTimeout(updateScrollFunc,fadeTime);
}

function rightCycleTrigger(e,scrollItems,scrollTexts,currentScrollIndex,fadeInOrOutTime,numOfChanges,updateScrollFunc,manageScrollVar) {

	var image1 = scrollItems[currentScrollIndex];
	var imageReturns1 = calculateCorrectChanges(image1,0,fadeInOrOutTime,numOfChanges);
	var changeEachTime1 = imageReturns1[0];
	var timeBetween1 = imageReturns1[1];
	
	var text1 = scrollTexts[currentScrollIndex];
	
	currentScrollIndex = manageScrollVar();				
	
	var image2 = scrollItems[currentScrollIndex];
	var imageReturns2 = calculateCorrectChanges(image2,1,fadeInOrOutTime,numOfChanges);
	var changeEachTime2 = imageReturns2[0];
	var timeBetween2 = imageReturns2[1];
	
	var text2 = scrollTexts[currentScrollIndex];
	text2.style.zIndex='0';
	
	changeOpacity(image1,changeEachTime1,timeBetween1,numOfChanges,0);
	changeOpacity(text1,changeEachTime1,timeBetween1,numOfChanges,0);
	
	setTimeout(function () {
		changeOpacity(image2,changeEachTime2,timeBetween2,numOfChanges,0);
		changeOpacity(text2,changeEachTime2,timeBetween2,numOfChanges,0);
	}, offsetFadeInTime);
	
	setTimeout(updateScrollFunc,fadeTime);
}
function calculateCorrectChanges(element,op2,miliseconds,changes){
	var changeEachTime = (op2-element.style.opacity)/changes;
	var timeBetweenEach = Math.abs(miliseconds/changes);
	return [changeEachTime,timeBetweenEach];
}