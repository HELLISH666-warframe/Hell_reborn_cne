function onEvent(_) {
	if (_.event.name == 'hud_fade') {
		var timeNeeded = _.event.params[0];
		var targetAlpha:Float = Std.parseFloat(_.event.params[1]);
		FlxTween.tween(camHUD, {alpha: targetAlpha}, timeNeeded, {ease: FlxEase.linear});
	}
}