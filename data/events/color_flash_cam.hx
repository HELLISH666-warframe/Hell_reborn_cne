public var colorfucker:FlxSprite = new FlxSprite(0, 0).makeGraphic(1920, 1080, 0xFFFFFFFF);

function postCreate() {
	colorfucker.scrollFactor.set(0,0);
	colorfucker.scale.set(2,2);
	add(colorfucker).alpha=0;
}

function onEvent(_) {
	if (_.event.name == 'color_flash_cam') {
		FlxTween.globalManager.completeTweensOf(colorfucker, ['alpha']);
		var getTheFuckingColor = switch(_.event.params[1]) {
            case 'Red': 0xff0000;
            case 'Black': 0x000000;
            case 'Purple': 0x800080;
			case 'White': 0xffffff;
        };
		colorfucker.color=getTheFuckingColor;
		colorfucker.alpha=1;
		FlxTween.tween(colorfucker, {alpha: 0}, _.event.params[0], {ease: FlxEase.linear});
	}
}