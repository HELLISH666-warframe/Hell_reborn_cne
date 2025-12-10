import flixel.text.FlxTextBorderStyle;
import flixel.util.FlxStringUtil;
import flixel.ui.FlxBar;
public var timeTxt;
public var timeBarBG;
public var timeBar;
public var songLength = FlxG.sound.music.length;
public var budAndBludsShitVar=[];
function create() {
    timeTxt = new FlxText(42 + (FlxG.width / 2) - 248, 19, 400,curSong);
	timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, 'center', FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	timeTxt.scrollFactor.set();
	timeTxt.alpha = 1;
	timeTxt.borderSize = 2;

    timeBarBG = new FlxSprite().loadGraphic(Paths.image('timeBar'));
	timeBarBG.x = timeTxt.x;
	timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
	timeBarBG.scrollFactor.set();
	//timeBarBG.alpha = 0;
	//timeBarBG.visible = showTime;
	timeBarBG.color = FlxColor.BLACK;
	add(timeBarBG);

    timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, 'LEFT_TO_RIGHT', Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), null, '', 0, 1);
	timeBar.scrollFactor.set();
	timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
	timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
	timeBar.alpha = 1;
	add(timeBar);
    add(timeTxt);
    for(i in [timeBar,timeTxt,timeBarBG])i.camera=camHUD;
}
function postCreate()
    budAndBludsShitVar = [scoreTxt, healthBarBG, healthBar, iconP1, iconP2, accuracyTxt, missesTxt,timeTxt,timeBarBG,timeBar];
var editableTime:Float;
function update(elapsed:Float) {
    var songCalc:Float = (songLength - Conductor.songPosition);
    if(FlxG.save.data.TimeBar == "elapsed") songCalc = Conductor.songPosition;
	if(songCalc < 0) songCalc = 0;
    timeTxt.text = FlxStringUtil.formatTime(songCalc/1000, false);
    timeBar.percent = (Conductor.songPosition/songLength)*100;
}
