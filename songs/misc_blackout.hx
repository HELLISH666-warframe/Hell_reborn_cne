import funkin.editors.charter.Charter;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;
public var blackFlash:FlxSprite;
function create() {
	blackFlash = new FlxSprite(-800, -900).loadGraphic(Paths.image('stages/BlackFlash'));
	blackFlash.scrollFactor.set(0, 0);
	blackFlash.scale.set(18,22);
	blackFlash.alpha = 0.0001;
	blackFlash.screenCenter(FlxAxes.X);
	add(blackFlash);
	//blackFlash.camera = camHUD;
}

function update(elapsed:Float) {
}
function blackflashtrue(){  
	blackFlash.alpha = 1;
}
function blackflashfalse(){  
	blackFlash.alpha = 0.0001;
}