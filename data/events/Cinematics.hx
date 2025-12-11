var upperBar = new FunkinSprite(0, -120).makeGraphic(1280, 120, 0xFF000000);
var lowerBar = new FunkinSprite(0, 720).makeGraphic(1280, 120, 0xFF000000);
var StartStop = 0;

var speed = 0;

function postCreate() {
	lowerBar.camera = upperBar.camera = camHUD;
	insert(0,upperBar);
    insert(0,lowerBar);
}

function onEvent(_) {
	if (_.event.name == 'Cinematics') {
		for(i in [upperBar,lowerBar]) FlxTween.cancelTweensOf(i, ['y']);
		var speed:Float = Std.parseFloat(_.event.params[1]);
		if (_.event.params[0] == true){
		FlxTween.tween(upperBar, {y: 0}, speed, {ease: FlxEase.linear});
		FlxTween.tween(lowerBar, {y: 600}, speed, {ease: FlxEase.linear});
		for (i in 0...playerStrums.members.length){ FlxTween.tween(playerStrums.members[i], {y: playerStrums.members[i].y + 80}, speed, {ease: FlxEase.linear});
		FlxTween.tween(cpuStrums.members[i], {y: cpuStrums.members[i].y + 80}, speed, {ease: FlxEase.linear});
		}
		for(i in [scoreTxt,missesTxt,accuracyTxt,iconP1,iconP2,timeBar,timeBarBG,timeTxt])
		FlxTween.tween(i, {alpha: 0}, 0.1);
		}
		if (_.event.params[0] == false){
		FlxTween.tween(upperBar, {y: -120}, speed, {ease: FlxEase.linear});
		FlxTween.tween(lowerBar, {y: 720}, speed, {ease: FlxEase.linear});
		for (i in 0...playerStrums.members.length){ FlxTween.tween(playerStrums.members[i], {y: playerStrums.members[i].y - 80}, speed, {ease: FlxEase.linear});
		FlxTween.tween(cpuStrums.members[i], {y: cpuStrums.members[i].y - 80}, speed, {ease: FlxEase.linear});
		}
		for(i in [scoreTxt,missesTxt,accuracyTxt,iconP1,iconP2,timeBar,timeBarBG,timeTxt])
		FlxTween.tween(i, {alpha: 1}, 0.1);
		}
	}
}