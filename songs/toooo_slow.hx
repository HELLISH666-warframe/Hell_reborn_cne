import funkin.editors.charter.Charter;
import funkin.game.PlayState;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
public var iconP1new:HealthIcon;
public var iconP2new:HealthIcon;
public var botplayTxt:FlxText;
public var screenstatic:FlxSprite;
function create() {
	screenstatic = new FlxSprite(0,0);
	screenstatic.frames = Paths.getSparrowAtlas('stages/exe/screenstatic');
	screenstatic.animation.addByPrefix('screenstatic', 'screenstatic', 24, true);
	screenstatic.animation.play('screenstatic', true);
	screenstatic.scrollFactor.set(0.05, 0.05);
	screenstatic.screenCenter();
	insert(1, screenstatic);
	screenstatic.alpha = 0.0001;
	screenstatic.camera = camHUD;
	//setObjectCamera('screenstatic','other')
}

function update(elapsed:Float) {
}
function tooslowflash(){  
	screenstatic.alpha = 0.4;
	screenstatic.animation.play('screenstatic');
	FlxG.sound.play(Paths.sound('simplejumpsound'), 0.);
	new FlxTimer().start(0.15, function(tmr:FlxTimer)
	{
		screenstatic.alpha = 0.0001;
	});
}