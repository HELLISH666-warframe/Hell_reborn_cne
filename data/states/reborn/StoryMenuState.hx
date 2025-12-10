import flixel.group.FlxGroup;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.graphics.FlxGraphic;
import funkin.savedata.FunkinSave;
import ShakyText;
import funkin.menus.StoryMenuState.StoryWeeklist;

var camGame = new FlxCamera();

public var blackishGrayThing:FlxSprite;
public var whiteThing:FlxSprite;
public var redThing:FlxSprite;
public var weekBG:FlxSprite;
public var difficultySprite:FlxSprite;

var radish:CustomShader = new CustomShader("glitchShader2");

var weekText:ShakyText;
var trackText:FlxText;
var weekDescription:FlxText;
var bestScore:FlxText;

public static var lerpedBestScore:Int = 0;
static var defaultBestScore:Int = 0;

public var loadedWeeks:StoryWeeklist;

var selectingDifficulty:Bool = false;
var curDifficulty:Int = 1;

static var curWeek:Int = 0;

public function fixTextSize(text:FlxText, sprite:FlxSprite, ?mult:Float = 0) {
    var ratio:Float = (sprite.width + mult) / text.textField.width;
    var originalOrigin:FlxPoint = FlxPoint.get(text.origin.x, text.origin.y);
    text.centerOrigin();
    text.scale.set(ratio, ratio);
    text.updateHitbox();
    text.offset.set(originalOrigin.x, originalOrigin.y);
    text.updateHitbox();
}

function create(){
	loadedWeeks = StoryWeeklist.get(true, false);
	FlxG.cameras.reset(camGame);
	FlxCamera.defaultCameras = [camGame];
	camGame.addShader(radish);	

	PlayState.isStoryMode = true;
	weekBG = new FlxSprite(0, 0);

	redThing = new FlxSprite(FlxG.width+50, FlxG.height-350).makeGraphic(FlxG.width, 400, 0xFfac0001);
	difficultySprite = new FlxSprite(0, 0);
	blackishGrayThing = new FlxSprite(FlxG.width+425, 0).makeGraphic(655, FlxG.height+150, 0xFF19181a);
	whiteThing = new FlxSprite(-25, -350).makeGraphic(650, 280, 0xFFe8d8c0);

	weekText = new ShakyText(0, -480, 0, loadedWeeks.weeks[curWeek].id.toUpperCase(), 100, Paths.font('Futura.otf'), 0xFF19181a, 0xFFac0001, 5);
	trackText = new FlxText(-400, 0, 0, 'Tracks', 40);
	weekDescription = new FlxText(-400, FlxG.height-50, 0, '...', 35);
	bestScore = new FlxText(-300, 0, 0, 'N/A', 40);

	trackText.alignment = 'center';
	trackText.font = Paths.font('Futura.otf');
	trackText.color = 0xFFe9a642;

	weekDescription.alignment = 'center';
	weekDescription.font = Paths.font('Futura.otf');
	weekDescription.color = 0xFFe8d8c0;

	bestScore.alignment = 'center';
	bestScore.font = Paths.font('Futura.otf');
	bestScore.color = 0xFF19181a;

	weekBG.scrollFactor.set(0, 0);
	redThing.scrollFactor.set(0, 0);
	blackishGrayThing.scrollFactor.set(0, 0);
	whiteThing.scrollFactor.set(0, 0);
	weekText.scrollFactor.set(0, 0);
	trackText.scrollFactor.set(0, 0);
	weekDescription.scrollFactor.set(0, 0);
	difficultySprite.scrollFactor.set(0, 0);
	bestScore.scrollFactor.set(0, 0);

	blackishGrayThing.angle = -3;
	whiteThing.angle = -3;
	weekText.angle = -3;
	trackText.angle = -3;
	weekDescription.angle = -3;

	difficultySprite.visible = false;
	bestScore.visible = false;

	add(weekBG);

	add(redThing);
	add(difficultySprite);
	add(blackishGrayThing);
	add(whiteThing);
	add(weekText);
	add(trackText);
	add(weekDescription);
	add(bestScore);

	FlxTween.tween(blackishGrayThing, {x: -15}, 0.4, {ease: FlxEase.expoIn, onComplete: function(posi:FlxTween){
		FlxTween.tween(blackishGrayThing, {"scale.x": 2}, 0.2, {ease: FlxEase.elasticOut, type: FlxEase.BACKWARD});
		FlxTween.tween(whiteThing, {y: -45}, 0.3, {ease: FlxEase.smoothStepInOut, onComplete: function(poru:FlxTween){
			changeWeek(0);
			FlxTween.tween(redThing, {x: 0}, 0.15, {ease: FlxEase.smoothStepInOut});
		}});
	}});
}

function changeDifficulty(who:Int = 0) {
	curDifficulty = FlxMath.wrap(curDifficulty + who, 0, loadedWeeks.weeks[curWeek].difficulties.length-1);

	var currentImage:FlxGraphic = Paths.image('menus/storymenu/difficulties/' +loadedWeeks.weeks[curWeek].difficulties[curDifficulty]);
	difficultySprite.loadGraphic(currentImage);
	FlxTween.tween(difficultySprite, {x: redThing.x+redThing.width/2-difficultySprite.width/2, y: redThing.y+difficultySprite.height}, 0.15, {ease: FlxEase.elasticOut, onComplete: function(posi:FlxTween){
		FlxTween.tween(bestScore, {x: redThing.x+redThing.width/2-bestScore.width/2, y: difficultySprite.y+difficultySprite.height+20}, 0.15, {ease: FlxEase.elasticOut});
	}});
	defaultBestScore = FunkinSave.getWeekHighscore(loadedWeeks.weeks[curWeek].id, loadedWeeks.weeks[curWeek].difficulties[curDifficulty]).score;
}

function changeWeek(who:Int = 0){
	curWeek = FlxMath.wrap(curWeek + who, 0, loadedWeeks.weeks.length-1);

	var leWeek = loadedWeeks.weeks[curWeek];
	trace(leWeek.xml);
	weekText.text = leWeek.id.toUpperCase();
	if (weekText.textField.width > whiteThing.width-100){
		fixTextSize(weekText, whiteThing, -100);
		fixTextSize(weekText.shakyText, whiteThing, -99);
	}

	var stringThing:Array<String> = [];
	for (i in 0...leWeek.songs.length) stringThing.push(leWeek.songs[i].name);
	trackText.text = 'TRACKS\n\n';
	for (i in 0...stringThing.length) trackText.text += stringThing[i].toUpperCase() + '\n';
	weekDescription.text = leWeek.name.toUpperCase();
	Assets.exists(Paths.image('menus/storymenu/weekbgs/' + leWeek.weekBG)) ? fgdf=leWeek.weekBG : fgdf="stage";
	weekBG.loadGraphic(Paths.image('menus/storymenu/weekbgs/' + fgdf));

	changeDifficulty(0);

	FlxTween.tween(weekText, {x: whiteThing.x+whiteThing.width/2-weekText.width/2, y: whiteThing.y+whiteThing.height/2-weekText.height/2}, 0.2, {ease: FlxEase.elasticOut});
	FlxTween.tween(trackText, {x: blackishGrayThing.x+blackishGrayThing.width/2-trackText.width/2, y: whiteThing.y+whiteThing.height+20}, 0.15, {ease: FlxEase.elasticOut});
	FlxTween.tween(weekDescription, {x: blackishGrayThing.x+blackishGrayThing.width/2-weekDescription.width/2, y: (FlxG.height-weekDescription.height)-5}, 0.15, {ease: FlxEase.elasticOut});
}

var no_flavor:Bool = false;
function selectWeek(){
	FlxTween.tween(weekBG, {y: -100-weekBG.height}, 1, {ease: FlxEase.elasticOut});
	FlxTween.tween(redThing, {y: FlxG.height+50+redThing.height}, 0.3, {ease: FlxEase.elasticOut});
	FlxTween.tween(difficultySprite, {y: FlxG.height+50+redThing.height}, 0.3, {ease: FlxEase.elasticOut});
	FlxTween.tween(bestScore, {y: FlxG.height+50+redThing.height}, 0.3, {ease: FlxEase.elasticOut, onComplete: function(posi:FlxTween){
		PlayState.loadWeek(weeklist.weeks[curWeek], difficulties[curDifficulty_storymode]);
		FlxG.switchState(new PlayState());
	}});
}

function update(elapsed:Float){
	radish.data.iTime.value=[Math.cos(9)* elapsed];
	lerpedBestScore = Math.floor(FlxMath.lerp(lerpedBestScore, defaultBestScore, FlxMath.bound(elapsed * 30, 0, 1)));
	if(Math.abs(defaultBestScore - lerpedBestScore) < 10) lerpedBestScore = defaultBestScore;

	bestScore.text = 'PERSONAL BEST:\n'+lerpedBestScore+'\n';

	if (!selectingDifficulty)
		if (controls.UP_P||controls.DOWN_P) changeWeek(controls.UP_P?-1:1);
	else if (!no_flavor)
		if (controls.LEFT_P||controls.RIGHT_P) changeDifficulty(controls.LEFT_P?-1:1);
	
	if (controls.ACCEPT){
		if (!selectingDifficulty) {
			FlxTween.tween(blackishGrayThing, {x: -FlxG.width}, 0.25, {ease: FlxEase.smootherStepInOut});
			FlxTween.tween(whiteThing, {y: -350}, 0.25, {ease: FlxEase.smootherStepInOut});
			FlxTween.tween(trackText, {y: -350}, 0.25, {ease: FlxEase.smootherStepInOut});
			FlxTween.tween(weekDescription, {y: -350}, 0.25, {ease: FlxEase.smootherStepInOut});
			FlxTween.tween(weekText, {y: -350}, 0.25, {ease: FlxEase.smootherStepInOut, onComplete: function(frtie:FlxTween){
				selectingDifficulty = true;
				difficultySprite.visible = true;
				bestScore.visible = true;
				changeDifficulty(0);
			}});
		} else selectWeek();
	}
	if (controls.BACK){
		if (!selectingDifficulty){
			FlxG.sound.play(Paths.sound('cancelMenu'));
			no_flavor = true;
			FlxG.switchState(new MainMenuState());
		}else{
			FlxTween.tween(blackishGrayThing, {x: -15}, 0.4, {ease: FlxEase.smoothStepInOut, onComplete: function(posi:FlxTween){
				FlxTween.tween(whiteThing, {y: -45}, 0.3, {ease: FlxEase.smoothStepInOut, onComplete: function(repu:FlxTween){
					changeWeek(0);
					selectingDifficulty = false;
					FlxTween.tween(bestScore, {x: -400}, 0.3, {ease: FlxEase.expoIn});
					FlxTween.tween(difficultySprite, {x: -400}, 0.3, {ease: FlxEase.expoIn, onComplete: function(psst:FlxTween){
						difficultySprite.visible = false;
						bestScore.visible = false;
					}});
				}});
			}});
		}
	}
}