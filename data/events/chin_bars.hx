var upperBar = new FunkinSprite(0, -120).makeGraphic(1280, 120, 0xFF000000);
var lowerBar = new FunkinSprite(0, 720).makeGraphic(1280, 120, 0xFF000000);
var StartStop = 0;

var speed = 0;

function postCreate() {
	lowerBar.camera = upperBar.camera = camHUD;
	insert(1,upperBar);
    insert(1,lowerBar);
}

function onEvent(_) {
	if (_.event.name == 'chin_bars') {
		var speed:Float = Std.parseFloat(_.event.params[1]);
		if (_.event.params[0] == true){
		FlxTween.tween(upperBar, {y: 0}, speed, {ease: FlxEase.linear});
		FlxTween.tween(lowerBar, {y: 600}, speed, {ease: FlxEase.linear});
		for (i in 0...playerStrums.members.length) FlxTween.tween(playerStrums.members[i], {y: playerStrums.members[i].y + 80}, speed, {ease: FlxEase.linear});
		for (i in 0...cpuStrums.members.length) FlxTween.tween(cpuStrums.members[i], {y: cpuStrums.members[i].y + 80}, speed, {ease: FlxEase.linear});
		FlxTween.tween(healthBar1, {alpha: 0}, speed/2.4);
		FlxTween.tween(healthBar2, {alpha: 0}, speed/2.4);
		FlxTween.tween(scoreTxt, {alpha: 0}, speed/2.4);
		FlxTween.tween(iconP1new, {alpha: 0}, speed/2.4);
		FlxTween.tween(iconP2new, {alpha: 0}, speed/2.4);
		FlxTween.tween(accuracyTxt, {alpha: 0}, speed/2.4);
		FlxTween.tween(missesTxt, {alpha: 0}, speed/2.4);
		FlxTween.tween(timeTxt, {alpha: 0}, speed/2.4);
		}
		if (_.event.params[0] == false){
		FlxTween.tween(upperBar, {y: -120}, speed, {ease: FlxEase.linear});
		FlxTween.tween(lowerBar, {y: 720}, speed, {ease: FlxEase.linear});
		for (i in 0...playerStrums.members.length) FlxTween.tween(playerStrums.members[i], {y: playerStrums.members[i].y - 80}, speed, {ease: FlxEase.linear});
		for (i in 0...cpuStrums.members.length) FlxTween.tween(cpuStrums.members[i], {y: cpuStrums.members[i].y - 80}, speed, {ease: FlxEase.linear});
		FlxTween.tween(healthBar1, {alpha: 0}, speed/2.4);
		FlxTween.tween(healthBar2, {alpha: 1}, speed/2.4);
		FlxTween.tween(scoreTxt, {alpha: 1}, speed/2.4);
		FlxTween.tween(iconP1new, {alpha: 1}, speed/2.4);
		FlxTween.tween(iconP2new, {alpha: 1}, speed/2.4);
		FlxTween.tween(accuracyTxt, {alpha: 1}, speed/2.4);
		FlxTween.tween(missesTxt, {alpha: 1}, speed/2.4);
		FlxTween.tween(timeTxt, {alpha: 1}, speed/2.4);
		}
	}
}