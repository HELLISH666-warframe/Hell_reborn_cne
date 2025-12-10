import funkin.editors.charter.Charter;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import funkin.options.keybinds.KeybindsOptions;
import flixel.FlxCamera;
import flixel.util.FlxStringUtil;
import funkin.options.OptionsMenu;
import funkin.options.TreeMenu;
import Conductor;
import funkin.backend.utils.FunkinParentDisabler;

var parentDisabler:FunkinParentDisabler;
    var leTime:Float;
	var time:Float = 0;
    public var curTime:Float;
    public static var songName = '';
    public var thething:FlxSprite;
    public var topSprite:FlxSprite;
    public var middleSprite:FlxSprite;
    public var bottomSprite:FlxSprite;
    var bottomSpriteILLUSION:FlxSprite;
    var forceCamera:Bool = false;
	var difficultyChange:Bool = false;
    public var selectedStuffArr:Array<String>;
	var shaderr:CustomShader  = new CustomShader("glitchShader");
   // public var selectedStuff:FlxTypedGroup<ShakyText> = new FlxTypedGroup<ShakyText>();
	public var selectedStuff:FlxTypedGroup<ShakyText> = new FlxTypedGroup();
    var curSelected:Int = 0;
    var curSelectedBar:FlxSprite = new FlxSprite();
    var pauseText:FlxText;
    var skippingTime:Bool = false;

    var camZoom:Float = PlayState.instance.camGame.zoom;
    public var missCountTxt:FlxText;
    public var timeTxt:FlxText;
    public var scoreTxt:FlxText;

    public static var songArray:Array<String> = [];

    var readyToPress:Bool = false;
    //public function new(x:Float, y:Float){
		override function create() {
            parentDisabler = new FunkinParentDisabler();
            add(parentDisabler);
        FlxG.sound.play(Paths.sound('openPause'), 1);

        var erm:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
        erm.scrollFactor.set(0, 0);
        erm.alpha = 0.3;
        add(erm);

        middleSprite = new FlxSprite(-60, FlxG.height+500).makeGraphic(600, FlxG.height, 0xFFe8d8c0);
        middleSprite.scrollFactor.set(0, 0);
        middleSprite.angle = -3;
        add(middleSprite);

        bottomSprite = new FlxSprite(-600, FlxG.height-200).makeGraphic(600, 220, 0xFFac0001);
        bottomSprite.scrollFactor.set(0, 0);
        bottomSprite.angle = -3;
        add(bottomSprite);

        bottomSpriteILLUSION = new FlxSprite(-600, FlxG.height-185).makeGraphic(600, 500, 0xFFac0001);
        bottomSpriteILLUSION.scrollFactor.set(0, 0);
        bottomSpriteILLUSION.angle = -3;
        add(bottomSpriteILLUSION);

        thething = new FlxSprite(FlxG.width+10, 128).makeGraphic(FlxG.width, 120, 0xFF19181a);
        thething.scrollFactor.set(0, 0);
        thething.angle = -3;
		thething.shader = new CustomShader("glitchShader");
        add(thething);

		FlxG.camera.addShader(shaderr);

        var redThing = new FlxSprite(FlxG.width+10, 158).makeGraphic(Std.int(FlxG.width/2+120), 120, 0xFFac0001);
        var whiteThing = new FlxSprite(FlxG.width+10, 158).makeGraphic(Std.int((FlxG.width/2)+90), 120, 0xFFe8d8c0);

        redThing.scrollFactor.set(0, 0);
        whiteThing.scrollFactor.set(0, 0);

        redThing.angle = -3;
        whiteThing.angle = -3;

        add(redThing);
        add(whiteThing);

        topSprite = new FlxSprite(FlxG.width-300, -300).makeGraphic(600, 300, 0xFFe8d8c0);
        topSprite.angle = -3;
        topSprite.scrollFactor.set(0, 0);
        add(topSprite);

        pauseText = new FlxText(FlxG.width-310, 0, 0, 'PAUSE', 200);
        pauseText.angle = -3;
        pauseText.scrollFactor.set(0, 0);
        pauseText.font = Paths.font('Futura.otf');
        pauseText.color = 0xFF19181a;
        add(pauseText);

        generateStuff(false, false);
        switchItem(0);

        missCountTxt = new FlxText(-190, 240, 0, 'Misses:    '+PlayState.instance.misses, 40);
        missCountTxt.scrollFactor.set(0, 0);
        missCountTxt.angle = -3;
        missCountTxt.font = Paths.font('Futura.otf');
        missCountTxt.color = 0xFFffdf02;
        add(missCountTxt);

		curTime = Conductor.songPosition;
        leTime = curTime;
        var secondsTotal:Int = Math.floor(curTime / 1000);
        if (secondsTotal < 0) secondsTotal = 0;
        timeTxt = new FlxText(-195, 290, 0, 'Time:        '+FlxStringUtil.formatTime(secondsTotal, false)+'/'+FlxStringUtil.formatTime(FlxG.sound.music.length/1000), 40);
        timeTxt.scrollFactor.set(0, 0);
        timeTxt.angle = -3;
        timeTxt.font = Paths.font('Futura.otf');
        timeTxt.color = 0xFF19181a;
        add(timeTxt);

        scoreTxt = new FlxText(-200, 340, 0, 'Score:       '+PlayState.instance.songScore, 40);
        scoreTxt.scrollFactor.set(0, 0);
        scoreTxt.angle = -3;
        scoreTxt.font = Paths.font('Futura.otf');
        scoreTxt.color = 0xFF19181a;
        add(scoreTxt);

        var deathCounter:FlxText;
        if (PlayState.deathCounter > 0)
        {
            deathCounter = new FlxText(-200, 390, 0, 'Deaths:    ' + PlayState.deathCounter, 40);
            deathCounter.scrollFactor.set(0, 0);
            deathCounter.angle = -3;
            deathCounter.font = Paths.font('Futura.otf');
            deathCounter.color = 0xFF19181a;
            add(deathCounter);
        }

        FlxTween.tween(pauseText, {x: FlxG.width-310, y: 100, size: 100}, 0.2, {ease: FlxEase.smootherStepInOut, onComplete: function(posi){
            FlxTween.tween(pauseText, {x: 40, y: 130}, 0.4, {ease: FlxEase.elasticOut});
        }});
        FlxTween.tween(topSprite, {x: FlxG.width-350, y: -85}, 0.1, {ease: FlxEase.smoothStepInOut, onComplete: function(posi:FlxTween){
            FlxTween.tween(topSprite, {x: -90, y: -75}, 0.3, {ease: FlxEase.expoIn, onComplete: function(pero:FlxTween){
                topSprite.scale.x = 0.75;
                middleSprite.origin.x = 0;
                FlxTween.tween(middleSprite, {"scale.x": 0.4}, 0.1, {ease: FlxEase.expoIn, onComplete: function(poru){
                    FlxTween.tween(middleSprite, {"scale.x": 1}, 0.1, {ease: FlxEase.elasticOut, onComplete: function(pasu){
                        middleSprite.origin.x = middleSprite.width/2;
                    }});
                }});
                FlxTween.tween(topSprite.scale, {x: 1}, 0.2, {ease: FlxEase.elasticOut, onComplete: function(poru){
                    readyToPress = true;
                }});
            }});

            FlxTween.tween(middleSprite, {y: FlxG.height-440}, 0.13, {ease: FlxEase.smootherStepInOut});
            FlxTween.tween(missCountTxt, {x: 50}, 0.2, {ease: FlxEase.elasticOut});
            FlxTween.tween(timeTxt, {x: 55}, 0.22, {ease: FlxEase.elasticOut});
            FlxTween.tween(scoreTxt, {x: 60}, 0.24, {ease: FlxEase.elasticOut});
            if (PlayState.deathCounter > 0) FlxTween.tween(deathCounter, {x: 65}, 0.26, {ease: FlxEase.elasticOut});
            selectedStuff.forEachAlive(function(text:ShakyText){
                var theX:Float = (text.ID <= 3) ? 55 : 235;
                FlxTween.tween(text, {x: theX+((text.ID))}, 0.13, {ease: FlxEase.elasticOut});
            });
            FlxTween.tween(curSelectedBar, {x: 0}, 0.13, {ease: FlxEase.elasticOut});
            FlxTween.tween(bottomSprite, {x: -60}, 0.13, {ease: FlxEase.smootherStepInOut});
            FlxTween.tween(bottomSpriteILLUSION, {x: -60}, 0.13, {ease: FlxEase.smootherStepInOut, onComplete: function(guh:FlxTween){
                bottomSprite.updateHitbox();
                bottomSpriteILLUSION.origin.x = 0;
                FlxTween.tween(bottomSpriteILLUSION, {"scale.x": 2.5}, 0.2, {ease: FlxEase.smootherStepInOut, onComplete: function(ww){
                    // bottomSpriteILLUSION.origin.x = bottomSpriteILLUSION.width/2;
                    FlxTween.tween(bottomSpriteILLUSION, {"scale.x": 0.1}, 0.2, {ease: FlxEase.smootherStepInOut, onComplete: function(ww){
                        remove(bottomSpriteILLUSION);
                    }});
                }});
            }});
            FlxTween.tween(redThing, {x: -920, y: 255, "scale.x": 1.4}, 0.19, {ease: FlxEase.smootherStepInOut});
            FlxTween.tween(whiteThing, {x: -950, y: 255}, 0.18, {ease: FlxEase.smootherStepInOut});

            FlxTween.tween(thething.scale, {x: 3.3}, 0.2, {ease: FlxEase.smoothStepInOut, onComplete: function(yuri:FlxTween){
                FlxTween.tween(thething, {x: (-FlxG.width)-989, y: 310}, 0.2, {ease: FlxEase.circIn, onComplete: function(j:FlxTween){
                    FlxTween.tween(thething, {x: thething.x+40.5, "scale.y": 0.5, y: thething.y-20}, 0.1, {ease: FlxEase.elasticOut, onComplete: function(regenerateSPR:FlxTween){
                        thething.destroy();
                        thething = new FlxSprite(-80.5, topSprite.y+topSprite.height-31).makeGraphic(Std.int(topSprite.width), Std.int(thething.height), 0xFF19181a);
                        thething.scale.y = 0.5;
                        thething.angle = -3; 
						thething.shader = new CustomShader("glitchShader");
                        add(thething);
                        thething.scrollFactor.set(0, 0);
                        add(topSprite);
                        missCountTxt = new FlxText(50, 240, 0, 'Misses:    '+PlayState.instance.misses, 40);
                        missCountTxt.scrollFactor.set(0, 0);
                        missCountTxt.angle = -3;
                        missCountTxt.font = Paths.font('Futura.otf');
                        missCountTxt.color = 0xFFffdf02;
                        add(missCountTxt);
                        //kms
                    }});
                }});
            }});
        }});

        FlxTween.tween(PlayState.instance.camHUD, {alpha: 0}, 0.4, {ease: FlxEase.smootherStepInOut});
        //FlxTween.tween(PlayState.instance.camOther, {alpha: 0}, 0.4, {ease: FlxEase.smootherStepInOut});
        FlxTween.tween(PlayState.instance.camGame, {zoom: 1}, 0.1, {ease: FlxEase.smootherStepInOut, onComplete: function(fkf){
            forceCamera = true;
        }});
    }
    var holdTime:Float = 0;
    override function update(elapsed:Float){
        if (forceCamera)
            PlayState.instance.camGame.zoom = 1;
		time += elapsed;
		thething.shader.data.iTime.value = [time * 2];
		shaderr.data.iTime.value = [time * 2];
        if (readyToPress){
            if (controls.UP_P){
                switchItem(-1);
                skippingTime = false;
            }
            if (controls.DOWN_P){
                switchItem(1);
                skippingTime = false;
            }
            if (FlxG.keys.justPressed.ESCAPE)
                skippingTime = false;

                timeTxt.color = 0xFF19181a;
                timeTxt.text = 'Time:        '+FlxStringUtil.formatTime((curTime/1000), false)+'/'+FlxStringUtil.formatTime(FlxG.sound.music.length/1000);
            
            if (FlxG.keys.justPressed.ENTER && !skippingTime){
                if (selectedStuffArr[curSelected] != 'Continue') FlxG.sound.play(Paths.sound('selectPause'), 0.8);
                switch(selectedStuffArr[curSelected]){
                    case 'Continue':
                        FlxG.sound.play(Paths.sound('closePause'), 1);
                        FlxTween.tween(topSprite, {x: -90, y: -75}, 0.3, {ease: FlxEase.expoOut, onComplete: function(sysuf:FlxTween){
                            FlxTween.tween(topSprite, {x: FlxG.width-350, y: -85}, 0.1, {ease: FlxEase.smoothStepInOut, onComplete: function(pero:FlxTween){
								forceCamera = false;
								//PlayState.instance.camGame.setFilters([]);
								FlxTween.tween(PlayState.instance.camHUD, {alpha: 1}, 0.4, {ease: FlxEase.smootherStepInOut});
								//FlxTween.tween(PlayState.instance.camOther, {alpha: 1}, 0.4, {ease: FlxEase.smootherStepInOut});
								FlxTween.tween(PlayState.instance.camGame, {zoom: camZoom}, 0.1, {ease: FlxEase.smootherStepInOut});
								close();
                            }});
                        }});
                    case 'Retry':
                        parentDisabler.reset();
                        FlxG.resetState();
                    case 'Change Options':
                        TreeMenu.lastState = PlayState;
                        FlxG.switchState(new OptionsMenu());
                    case 'Quit':
                        if (PlayState.chartingMode && Charter.undos.unsaved)
                            PlayState.instance.saveWarn(false);
                        else {
                            PlayState.resetSongInfos();
                            if (Charter.instance != null) Charter.instance.__clearStatics();
        
                            // prevents certain notes to disappear early when exiting  - Nex
                            PlayState.instance.strumLines.forEachAlive(function(grp) grp.notes.__forcedSongPos = Conductor.songPosition);
        
                            CoolUtil.playMenuSong();
                            FlxG.switchState(PlayState.isStoryMode ? new StoryMenuState() : new FreeplayState());
                        }
                    case 'Back':
                        generateStuff(false);
                    /*case 'Botplay':
                        PlayState.instance.cpuControlled = !PlayState.instance.cpuControlled;
                        PlayState.instance.botplayTxt.visible = PlayState.instance.cpuControlled;
                        PlayState.instance.botplayTxt.alpha = 1;
                        PlayState.instance.botplaySine = 0;*/
                    /*case 'Practice Mode':
                        PlayState.instance.practiceMode = !PlayState.instance.practiceMode;*/
                    case 'Skip Time':
                        skippingTime = true;
                    case 'Change Controls':
                        persistentDraw = false;
                        openSubState(new KeybindsOptions());
                }
            }
        }
    }
function switchItem(who:Int = 1)
{
    curSelected += who;

    if (curSelected >= selectedStuffArr.length)
        curSelected = 0;
    if (curSelected < 0)
        curSelected = selectedStuffArr.length - 1;

    selectedStuff.forEachAlive(function(text:ShakyText){
        if (text.ID == curSelected){
            text.activate = true;
            if (!(text.ID <= 3)){
                FlxTween.tween(curSelectedBar.scale, {x: 1.5}, 0.1, {ease: FlxEase.smootherStepInOut});
                FlxTween.tween(curSelectedBar, {y: text.y}, 0.1, {ease: FlxEase.smootherStepInOut});
            }else{
                FlxTween.tween(curSelectedBar.scale, {x: 1}, 0.1, {ease: FlxEase.smootherStepInOut});
                FlxTween.tween(curSelectedBar, {y: text.y-5}, 0.1, {ease: FlxEase.smootherStepInOut});
            }
        }else{
            text.activate = false;
        }
    });
    FlxG.sound.play(Paths.sound('scrollPause'), 0.8);
}
public static function restartSong()
{
    PlayState.instance.paused = true;
    FlxG.sound.music.volume = 0;
    PlayState.instance.vocals.volume = 0;
    MusicBeatState.resetState();
}
function generateStuff(tweenThatBih:Bool = true) // guh??
{
    curSelectedBar.destroy();
    curSelectedBar = new FlxSprite(-165, 0).makeGraphic(320, 35, 0xFF19181a);
    curSelectedBar.scrollFactor.set(0, 0);
    curSelectedBar.angle = -3;
    add(curSelectedBar);

    selectedStuff.destroy();
    //selectedStuff = new FlxTypedGroup<ShakyText>();
	selectedStuff = new FlxTypedGroup();
    if (!difficultyChange)
    {
        selectedStuffArr = [
            'Continue',
            'Retry',
            'Change Options',
            'Change Controls',
            'Exit to charter',
            'Quit'
        ];
        if (PlayState.chartingMode){
             selectedStuffArr.push('Skip Time');
        }
    }
    add(selectedStuff);
    for (arrayItems in 0...selectedStuffArr.length){
        var selectedStuffBlah:ShakyText;
        if (arrayItems <= 3){
            selectedStuffBlah = new ShakyText(-120, (FlxG.height-195)+(35*(arrayItems+1)), 0, selectedStuffArr[arrayItems], 25, Paths.font('Futura.otf'), 0xFFf6d2bd, 0xFFac0001, 3);
        }else{
            selectedStuffBlah = new ShakyText(-120, (FlxG.height-205)+(35*(arrayItems-3)), 0, selectedStuffArr[arrayItems], 25, Paths.font('Futura.otf'), 0xFFf6d2bd, 0xFFac0001, 3);
        }
        selectedStuffBlah.scrollFactor.set(0, 0);
        selectedStuffBlah.angle = -3;
        selectedStuffBlah.ID = arrayItems;
        selectedStuff.add(selectedStuffBlah);
    }
    if (tweenThatBih){
        FlxTween.tween(curSelectedBar, {x: 0}, 0.13, {ease: FlxEase.elasticOut});
        selectedStuff.forEachAlive(function(text:ShakyText){
            var theX:Float = (text.ID <= 3) ? 55 : 235;
            FlxTween.tween(text, {x: theX+((text.ID))}, 0.13, {ease: FlxEase.elasticOut});
        });
        switchItem(50); // wdbhrufhejjfjjdfnnddjf
    }
}
/* function switchDifficulty(difficulty:Int)
{
    var songNameThing:String = PlayState.SONG.meta.displayName;
    var formattedStuff = Highscore.formatSong(songNameThing, difficulty);
    PlayState.SONG = Song.loadFromJson(formattedStuff, songNameThing);
    PlayState.storyDifficulty = difficulty;
    MusicBeatState.resetState();
    FlxG.sound.music.volume = 0;
    PlayState.changedDifficulty = true;
    PlayState.chartingMode = false;
    return;
}*/

class ShakyText extends FlxText // shaky shaky
{
    public var activate:Bool;
    public var normalColor:Int;
    public var shakyColor:Int;
    public var shakeValue:Int;

    public var shakyText:FlxText;
    public function new(x:Float = 0, y:Float = 0, width:Int = 0, text:Dynamic = '', size:Int = 8, txtFont:Dynamic, txtColor:Int = 0xFFffffff, shakyColor:Int = 0xFF000000, shakeCraziness:Int = 1)
    {
        this.activate = true;

        this.shakeValue = shakeCraziness;
        this.normalColor = txtColor;
        this.shakyColor = shakyColor;
        super(x, y, width, text, size);
        font = txtFont;
        color = txtColor;

        shakyText = new FlxText(x, y, width, text, size+1);
        shakyText.color = shakyColor;
        shakyText.font = font;
    }
    override function draw()
    {
        shakyText.scrollFactor = scrollFactor;
        shakyText.draw();
        super.draw();
    }
    private function shake(){
        shakyText.x = x + FlxG.random.float(-shakeValue, shakeValue);
        shakyText.y = y + FlxG.random.float(-shakeValue, shakeValue);
    }
    override function update(elapsed:Float)
    {
        if (activate){
            shakyText.angle = angle;
            shakyText.visible = visible;
            shakyText.size = size+1;
            shakyText.cameras = cameras;
            shakyText.text = text;
            shake();
        }else{
            shakyText.visible = false;
            shakyText.x = x;
            shakyText.y = y;
        }
    }
}
function destroy() {
    FlxG.camera.removeShader(shaderr);
    FlxG.sound.destroySound(pauseMusic);
}
public function setSongTime(time:Float)
	{
		if(time < 0) time = 0;

		FlxG.sound.music.pause();
		vocals.pause();

		FlxG.sound.music.time = time;
		FlxG.sound.music.play();

		if (Conductor.songPosition <= vocals.length)
		{
			vocals.time = time;
		}
		vocals.play();
		Conductor.songPosition = time;
		songTime = time;
	}
// Cherif was here >:D