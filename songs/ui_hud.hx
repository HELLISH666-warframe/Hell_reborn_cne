import funkin.editors.charter.Charter;
import funkin.game.PlayState;
import flixel.text.FlxTextAlign;
import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxStringUtil;
import flixel.ui.FlxBar;
public var songLength:Float = 0;
public var healthBar1:CherryBar;
public var healthBar2:CherryBar;
public var timeTxt:FlxText;
function create() {
    healthBar1 = new CherryBar(FlxG.width-20, FlxG.height-(FlxG.height*50)/100, 1, 2, 'height', FlxG.height, 0xFFffffff);
    healthBar2 = new CherryBar(0, FlxG.height-(FlxG.height*50)/100, 1, 2, 'height', FlxG.height, 0xFFffffff);

    healthBar1.scrollFactor.set(0, 0);
    healthBar2.scrollFactor.set(0, 0);
}
function postCreate() {
	iconP1.y=iconP2.y=(FlxG.height/2)-50;
	remove(healthBar);
	remove(healthBarBG);
	remove(scoreTxt);
	remove(missesTxt);
	remove(accuracyTxt);

    add(healthBar1);
    add(healthBar2);
    healthBar1.cameras = [camHUD];
    healthBar2.cameras = [camHUD];

    healthBar1.color = boyfriend.iconColor;
    healthBar2.color = dad.iconColor;

	scoreTxt.x = 50;
	scoreTxt.y = FlxG.height-160;
	scoreTxt.setFormat(Paths.font("Futura.otf"), 40, 0xFF19181a, 'LEFT', FlxTextBorderStyle.OUTLINE, 0xFFe8d8c0);
	scoreTxt.scrollFactor.set();
	scoreTxt.borderSize = 1.25;
	scoreTxt.angle = -3;
	add(scoreTxt);

	accuracyTxt.x = 50;
	accuracyTxt.y = FlxG.height-100;
	accuracyTxt.setFormat(Paths.font("Futura.otf"), 40, 0xFF19181a, 'LEFT', FlxTextBorderStyle.OUTLINE, 0xFFe8d8c0);
	accuracyTxt.scrollFactor.set();
	accuracyTxt.borderSize = 1.25;
	accuracyTxt.angle = -3;
	add(accuracyTxt);

	missesTxt.x = 40;
	missesTxt.y = FlxG.height-260;
	missesTxt.setFormat(Paths.font("Futura.otf"), 40, 0xFFffdf02, 'LEFT', FlxTextBorderStyle.OUTLINE, 0xFF19181a);
	missesTxt.scrollFactor.set();
	missesTxt.borderSize = 1.25;
	missesTxt.angle = -3;
	add(missesTxt);

	timeTxt = new FlxText(45, FlxG.height-210, 0, "Time:   M:SS", 40);
	timeTxt.setFormat(Paths.font("Futura.otf"), 40, 0xFF19181a, 'LEFT', FlxTextBorderStyle.OUTLINE, 0xFFe8d8c0);
	timeTxt.scrollFactor.set();
	timeTxt.angle = -3;
	timeTxt.borderSize = 1.025;
	timeTxt.cameras = [camHUD];
	add(timeTxt);
}

function postUpdate(elapsed:Float) {
	iconP1.x = healthBar1.x - healthBar1.width/2 - iconP1.width;
	iconP2.x = healthBar2.x + healthBar2.width/2;

    healthBar1.currentAmount = health;
	opponentHealth = Math.max(0, 2-health);
	healthBar2.currentAmount = opponentHealth;
    if (healthBar1.percent == 100)
        healthBar1.alpha = FlxMath.lerp(healthBar1.alpha, 0, elapsed*2);
    else
        healthBar1.alpha = FlxMath.lerp(healthBar1.alpha, 1, elapsed*2);
	var secondsTotal:Float = (songLength - Conductor.songPosition);
	if(secondsTotal < 0) secondsTotal = 0;
	timeTxt.text = 'Time:  '+ FlxStringUtil.formatTime(secondsTotal/1000, false);

	accuracyTxt.text = 'Accuracy:'  + "-%(" + CoolUtil.quantize(accuracy * 100, 100)+')';

	if (healthBar1.percent < 20)
		iconP1.animation.curAnim.curFrame = 1;
	else
		iconP1.animation.curAnim.curFrame = 0;

	if (healthBar2.percent < 20)
		iconP2.animation.curAnim.curFrame = 1;
	else
		iconP2.animation.curAnim.curFrame = 0;
}
class CherryBar extends FlxSprite{
	public var currentAmount:Float;
	public var maxAmount:Float;
	public var field:Dynamic;
	public var maxField:Float;

	private var lerpedAmount:Float;

	public function new(x:Float, y:Float, amount:Float, maxAmount:Float, field:Dynamic, maxField:Float, color:FlxColor){
		currentAmount = amount;
		this.maxAmount = maxAmount;
		this.field = field;
		this.maxField = maxField;
		lerpedAmount = amount;

		super(x, y);
		makeGraphic(20, 20, color);
	}
	override function update(elapsed:Float)
	{
		lerpedAmount = FlxMath.lerp(lerpedAmount, currentAmount, FlxMath.bound(elapsed * 30, 0, 1));
		var theething:Int = Math.floor((maxField*(lerpedAmount*100))/(maxAmount*100)/*for some optional shit*/);
		if (field == 'width'){
			setGraphicSize(theething, 20);
			updateHitbox();
			x = (maxField-theething);
		}else{ if (field == 'height'){
			setGraphicSize(20, theething);
			updateHitbox();
			y = (maxField-theething);
		}}

		super.update(elapsed);
	}
	public var percent(get, never):Int;
	function get_percent():Int
	{
		return Math.floor((currentAmount * 100)/maxAmount);
	}
}
function onSongStart() {
	songLength = FlxG.sound.music.length;
}

updateIconPositions = () -> null;