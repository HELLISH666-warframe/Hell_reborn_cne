import funkin.menus.FreeplayState.FreeplaySonglist;
import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.text.FlxText.FlxTextFormat;
import funkin.backend.utils.DiscordUtil;
import funkin.savedata.FunkinSave;

var songs=FreeplaySonglist.get().songs;

static var curSelected_FP:Int = 0;

var curDifficulty:Int = -1;
var black1:FlxSprite;

public var middleSprite:FlxSprite;

var scoreText:FlxText;
var lerpScore:Int = 0;
var lerpRating:Float = 0;
var intendedScore:Int = 0;
var intendedRating:Float = 0;

var grpSongs:FlxTypedGroup<FlxText>;
var iconArray:Array<HealthIcon> = [];

var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menus/menuDesat'));
var intendedColor:Int;
var colorTween:FlxTween;

var difficultyText:FlxText;
var kiwi:FlxTextFormatMarkerPair = new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFffdf02), "<_X_>");

function create() {
	CoolUtil.playMenuSong(true);
	persistentUpdate = true;
	DiscordUtil.changePresenceSince("In the Menus", null);
	bg.antialiasing = Options.antialiasing;
	add(bg);
	bg.screenCenter();

	middleSprite = new FlxSprite(0, FlxG.height - 300).makeGraphic(FlxG.width, 300, 0xFFe8d8c0);
	middleSprite.scrollFactor.set(0, 0);
	add(middleSprite);

	difficultyText = new FlxText(0, FlxG.height-200, 0, '< NORMAL >', 60);
	difficultyText.font = Paths.font("Futura.otf");
	difficultyText.color = 0xFF19181a;
	add(difficultyText);

	scoreText = new FlxText(FlxG.width-330, FlxG.height-150, 0, "", 20);
	scoreText.setFormat(Paths.font("Futura.otf"), 55, 0xFF19181a, 'center');
	add(scoreText);

	black1 = new FlxSprite(-20, -40).makeGraphic(610, FlxG.height + 100, 0xFF19181a);
	black1.scrollFactor.set(0, 0);
	black1.angle = -3;
	add(black1);

	grpSongs = new FlxTypedGroup<FlxText>();
	add(grpSongs);

	for (i in 0...songs.length) {
		var songText:FlxText = new FlxText(0, (70 * i) + 30, 0, songs[i].name.toUpperCase(), 80);
		songText.font = Paths.font('Futura.otf');
		songText.color = 0xFFe8d8c0;
		songText.angle = -3;
		songText.ID = i;

		if (songText.width > black1.width-50){
			songText.setGraphicSize(Std.int(black1.width-50), Std.int(songText.height));
			songText.updateHitbox();
		}
		grpSongs.add(songText);

		var icon:HealthIcon = new HealthIcon(songs[i].icon);
		icon.x = 870;
		icon.y = 150;
		icon.setGraphicSize(Std.int(icon.width * 1.5));
		iconArray.push(icon);
		add(icon);
	}
	FlxG.camera.zoom = 3;
	FlxTween.tween(FlxG.camera, {zoom: 1}, 1.5, {ease: FlxEase.expoInOut});

	if (curSelected_FP >= songs.length) curSelected_FP = 0;
	bg.color = songs[curSelected_FP].color;
	intendedColor = bg.color;

	changeSelection(0);
	changeDiff(0);

	var textBG:FlxSprite = new FlxSprite(0, FlxG.height - 26).makeGraphic(FlxG.width, 26, 0xFF000000);
	textBG.alpha = 0.6;
	add(textBG);


	var text:FlxText = new FlxText(textBG.x, textBG.y + 4, FlxG.width, 'Press SPACE to listen to the Song / Press SEVEN to open the editor pciker / Press TAB to switch mods.');
	text.setFormat(Paths.font("vcr.ttf"), 16, FlxColor.WHITE, 'right');
	text.scrollFactor.set();
	add(text);
}
var instPlaying:Int = -1;

public static var vocals:FlxSound = null;

var holdTime:Float = 0;
function update(elapsed:Float) {
	if (FlxG.sound.music.volume < 0.7) FlxG.sound.music.volume += 0.5 * FlxG.elapsed;

	lerpScore = Math.floor(FlxMath.lerp(lerpScore, intendedScore, FlxMath.bound(elapsed * 24, 0, 1)));
	lerpRating = FlxMath.lerp(lerpRating, intendedRating, FlxMath.bound(elapsed * 12, 0, 1));

	if (Math.abs(lerpScore - intendedScore) <= 10) lerpScore = intendedScore;
	if (Math.abs(lerpRating - intendedRating) <= 0.01) lerpRating = intendedRating;
	var ratingSplit:Array<String> = Std.string(floorDecimal(lerpRating * 100, 2)).split('.');
	if (ratingSplit.length < 2) ratingSplit.push('');

	while (ratingSplit[1].length < 2) ratingSplit[1] += '0';

	scoreText.text = 'PERSONAL BEST: ' + lerpScore + ' (' + ratingSplit.join('.') + '%)';
	positionHighscore();

	var shiftMult:Int = 1;
	if (FlxG.keys.pressed.SHIFT) shiftMult = 3;
	if (songs.length > 1) {
		if (controls.UP_P||controls.DOWN_P) {
			changeSelection(controls.UP_P?-shiftMult:shiftMult);
			holdTime = 0;
		}
		if (controls.DOWN_P || controls.UP_P) {
			var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
			holdTime += elapsed;
			var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

			if (holdTime > 0.5 && checkNewHold - checkLastHold > 0) {
				changeSelection((checkNewHold - checkLastHold) * (controls.UP_P ? -shiftMult : shiftMult));
				changeDiff(0);
			}
		}
		if (FlxG.mouse.wheel != 0) {
			FlxG.sound.play(Paths.sound('scrollMenu'), 0.2);
			changeSelection(-shiftMult * FlxG.mouse.wheel, false);
			changeDiff(0);
		}
	}

	if (controls.LEFT_P) changeDiff(-1);
	else if (controls.RIGHT_P) changeDiff(1);
	else if (controls.UP_P || controls.DOWN_P) changeDiff();
	if (controls.BACK) {
		persistentUpdate = false;
		if (colorTween != null) colorTween.cancel();
		FlxG.sound.play(Paths.sound('cancelMenu'));
		FlxG.switchState(new MainMenuState());
		FlxTween.tween(FlxG.camera, {zoom: 5}, 1.5, {ease: FlxEase.expoInOut});
	}
	if (FlxG.keys.justPressed.SPACE) {
		if (instPlaying != curSelected_FP) {
			#if PRELOAD_ALL
			FlxG.sound.playMusic(Paths.inst(songs[curSelected_FP].name, songs[curSelected_FP].difficulties[curDifficulty]), 0.7);
			instPlaying = curSelected_FP;
			#end
		}
	} else if (controls.ACCEPT) {
		for (ioii in grpSongs.members)
			FlxTween.tween(ioii, {alpha: 0}, 0.2, {ease: FlxEase.smoothStepInOut});
		for (icon in 0...iconArray.length)
			FlxTween.tween(iconArray[icon], {alpha: 0}, 0.2, {ease: FlxEase.smoothStepInOut});
			
		FlxTween.tween(black1, {"scale.x": 3.3, "scale.y": 2, x: 180}, 0.3, {ease: FlxEase.expoIn, onComplete: function(t:FlxTween){
			persistentUpdate = false;
			if (colorTween != null) colorTween.cancel();

			PlayState.loadSong(songs[curSelected_FP].name, songs[curSelected_FP].difficulties[curDifficulty].toLowerCase());
			FlxG.switchState(new PlayState());
			FlxG.sound.music.volume = 0;

			destroyFreeplayVocals();
		}});
	}
	if (controls.SWITCHMOD||FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = !persistentDraw;
		import funkin.editors.EditorPicker;
		import funkin.menus.ModSwitchMenu;
		openSubState(controls.SWITCHMOD ? new ModSwitchMenu() : new EditorPicker());
	}
}

public static function destroyFreeplayVocals() {
	if (vocals != null) {
		vocals.stop();
		vocals.destroy();
	}
	vocals = null;
}

function changeDiff(change:Int = 0) {
	curDifficulty = FlxMath.wrap(curDifficulty + change, 0, songs[curSelected_FP].difficulties.length-1);

	intendedScore = FunkinSave.getSongHighscore(songs[curSelected_FP].name, songs[curSelected_FP].difficulties[curDifficulty]).score;
	intendedRating = FunkinSave.getSongHighscore(songs[curSelected_FP].name, songs[curSelected_FP].difficulties[curDifficulty]).accuracy;

	if (change == 1)
		difficultyText.applyMarkup('< '+songs[curSelected_FP].difficulties[curDifficulty].toUpperCase()+' <_X_>><_X_>', [kiwi]);
	if (change == -1)
		difficultyText.applyMarkup('<_X_><<_X_> '+songs[curSelected_FP].difficulties[curDifficulty].toUpperCase()+' >', [kiwi]);
	new FlxTimer().start(0.13, function(tmr:FlxTimer) {
		difficultyText.applyMarkup('< '+songs[curSelected_FP].difficulties[curDifficulty].toUpperCase()+' >', [kiwi]);
	});

	difficultyText.x = (FlxG.width-330)-difficultyText.width/2;
		
	positionHighscore();
}

function changeSelection(change:Int = 0, playSound:Bool = true) {
	if (playSound) FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
	curSelected_FP = FlxMath.wrap(curSelected_FP + change, 0, songs.length-1);
	
	var newColor:Int = songs[curSelected_FP].color;
	if (newColor != intendedColor) {
		if (colorTween != null) colorTween.cancel();
		intendedColor = newColor;
		colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
			onComplete: function(twn:FlxTween) {
				colorTween = null;
			}
		});
	}

	for (i in 0...iconArray.length) iconArray[i].alpha = 0;
	iconArray[curSelected_FP].alpha = 1;

	for (item in grpSongs.members) {
		FlxTween.tween(item, {y: (70*item.ID)-(70*curSelected_FP)+15}, 0.2, {ease: FlxEase.smoothStepInOut});
		if (item.ID == curSelected_FP) item.color = 0xFFffdf02;
		else item.color = 0xFFe8d8c0;
	}
	changeDiff(0);
}

function positionHighscore() {
	scoreText.y = difficultyText.y+difficultyText.height+5;
	scoreText.x = (FlxG.width-330)-scoreText.width/2;

	if (scoreText.width > middleSprite.width/2-20)
		scoreText.setGraphicSize(Std.int(middleSprite.width/2-20));
	else scoreText.scale.set(1, 1);

	for (i in 0...iconArray.length) {
		var icon:HealthIcon = iconArray[i];
		icon.x = 870-icon.width/2;
		icon.y = 150+icon.height/2;
	}
}

public static function floorDecimal(value:Float, decimals:Int):Float{
	if (decimals < 1) return Math.floor(value);
	var tempMult:Float = 1;
	for (i in 0...decimals) tempMult *= 10;
	var newValue:Float = Math.floor(value * tempMult);
	return newValue / tempMult;
}