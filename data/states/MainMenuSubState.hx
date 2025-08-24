import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import funkin.menus.ModSwitchMenu;
import funkin.options.OptionsMenu;

var time:Float = 0;
static var bg:FlxSprite;
var options:Array<String> = ['StoryMode', 'FreePlay', 'Options', 'Extras'];
var curOption:Int = 0;
var optionGroup:FlxTypedGroup = new FlxTypedGroup();
//var optionGroup:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();
var sheddar:CustomShader  = new CustomShader("glitchShader2");

var camAchievement:FlxCamera;
override function create() {
    bg = new FlxSprite().loadGraphic(Paths.image('menus/menuBG'));
    bg.alpha = 0;
    add(bg);
	FlxTween.tween(bg, {alpha: 1}, 0.3);
	FlxG.camera.addShader(sheddar);

    for (i in 0...options.length){
		var option:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/MainMenu/' + options[i]));
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

	camAchievement = new FlxCamera();
	FlxG.cameras.add(camAchievement);
}
override function update(elapsed:Float){
	time += elapsed;
	sheddar.data.iTime.value = [time];
	if (controls.BACK)
	{
		FlxG.sound.play(Paths.sound('cancelMenu'));
        TitleState.closedMenuState();
		FlxTween.tween(bg, {alpha: 0}, 0.3);
		close();
	}
	if (controls.LEFT_P)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		changeSelection(1);
	}
	if (controls.RIGHT_P)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'));
		changeSelection(-1);
	}
	if (controls.ACCEPT)
	{
        switch(options[curOption]){
			case 'StoryMode': FlxG.switchState(new StoryMenuState());
			case 'FreePlay': FlxG.switchState(new FreeplayState());
			case 'Options': FlxG.switchState(new OptionsMenu());
			case 'Extras':
				LoadingState.loadAndSwitchState(new GalleryState());
        }
    }
	if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = false;
		persistentDraw = true;
		import funkin.editors.EditorPicker;
		openSubState(new EditorPicker());
	}
	if (controls.SWITCHMOD) {
		openSubState(new ModSwitchMenu());
		persistentUpdate = false;
		persistentDraw = true;
	}
}
function changeSelection(who:Int = 1){
    curOption += who;
	if (curOption >= optionGroup.length)
		curOption = 0;
	if (curOption < 0)
		curOption = optionGroup.length - 1;
	optionGroup.forEach(function(spr:FlxSprite)
	{  
		FlxTween.tween(spr, {x: (spr.width + 10) * Math.abs(spr.ID - curOption), alpha: (spr.ID == curOption ? 1 : 0.35)}, 0.5, {ease: FlxEase.quadInOut});
    });
	trace(curOption);
}