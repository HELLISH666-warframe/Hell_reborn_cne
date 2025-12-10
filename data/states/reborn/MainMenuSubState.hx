public static var bg:FlxSprite;
public var options:Array<String> = ['StoryMode', 'FreePlay', 'Options', 'Extras'];
public static var curOption:Int = 0;
var optionGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
function create(){
    bg = new FlxSprite().loadGraphic(Paths.image('menus/menuBG'));
    bg.alpha = 0;
    add(bg);
	FlxTween.tween(bg, {alpha: 1}, 0.3);

    for (i in 0...options.length){
		var option:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/mainmenu/' + options[i]));
        option.scale.set(0.5, 0.5);
        option.updateHitbox();
        option.x = FlxG.width+10+option.width;
        option.ID = i;
        FlxTween.tween(option, {x: (option.width + 10) * Math.abs(i - curOption)}, 0.5, {ease: FlxEase.quadInOut});
		FlxTween.tween(option, {y: (FlxG.height - option.height) / 2}, ((i+1)/10), {ease: FlxEase.quadInOut});
		optionGroup.add(option);
    }

    add(optionGroup);
	changeSelection(0);
}
function update(elapsed:Float){
	if (controls.BACK) {
		FlxG.sound.play(Paths.sound('cancelMenu'));
        TitleState.closedMenuState();
		FlxTween.tween(bg, {alpha: 0}, 0.3);
		close();
	}
	if (controls.LEFT_P) {
		FlxG.sound.play(Paths.sound('scrollMenu'));
		changeSelection(1);
	}
	if (controls.RIGHT_P) {
		FlxG.sound.play(Paths.sound('scrollMenu'));
		changeSelection(-1);
	}
	if (controls.ACCEPT) {
        switch(options[curOption]){
			case 'StoryMode':
				FlxG.switchState(new StoryMenuState());
			case 'FreePlay':
				FlxG.switchState(new ModState('reborn/FreeplayState'));
			case 'Options':
				FlxG.switchState(new options.OptionsState());
			case 'Extras':
				FlxG.loadAndSwitchState(new GalleryState());
        }
    }
	if (controls.SWITCHMOD||FlxG.keys.justPressed.SEVEN) {
		import funkin.menus.ModSwitchMenu; import funkin.editors.EditorPicker;
		controls.SWITCHMOD ? openSubState(new ModSwitchMenu()) :openSubState(new EditorPicker());
		persistentUpdate = !persistentDraw;
	}
}

function changeSelection(who:Int = 0){
    curOption += who;
	if (curOption >= optionGroup.length) curOption = 0;
	if (curOption < 0) curOption = optionGroup.length - 1;
	optionGroup.forEach(function(spr:FlxSprite) {  
		FlxTween.tween(spr, {x: (spr.width + 10) * Math.abs(spr.ID - curOption), alpha: (spr.ID == curOption ? 1 : 0.35)}, 0.5, {ease: FlxEase.quadInOut});
    });
}