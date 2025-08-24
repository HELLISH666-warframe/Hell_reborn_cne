import funkin.backend.MusicBeatState;
var bg1:FlxSprite;
var bg2:FlxSprite;
var time:Float = 1;

public var blackishGrayThing:FlxSprite;
public var whiteThing:FlxSprite;
public var redThing:FlxSprite;
var radish:CustomShader  = new CustomShader("glitchShader2");
function postCreate(){

	redThing = new FlxSprite(FlxG.width+50, FlxG.height-350).makeGraphic(FlxG.width, 400, 0xFfac0001);
	blackishGrayThing = new FlxSprite(FlxG.width+425, 0).makeGraphic(440, FlxG.height+150, 0xFF19181a);
	whiteThing = new FlxSprite(-25, -350).makeGraphic(650, 280, 0xFFe8d8c0);
	weekDescription = new FlxText(-400, FlxG.height-50, 0, '...', 35);

	//FlxG.camera.zoom=0.3;

	weekDescription.alignment = 'center';
	weekDescription.font = Paths.font('Futura.otf');
	weekDescription.color = 0xFFe8d8c0;
	FlxG.camera.addShader(radish);	
	for(i in members)
	remove(i);

	tracklist = new FlxText(-400, 0, 0, 'Tracks', 40);
	tracklist.alignment = 'center';
	tracklist.font = "Futura.otf";
	tracklist.color = 0xFFe9a642;

	weekTitle = new ShakyText(0, -480, 0, '', 100, Paths.font('Futura.otf'), 0xFF19181a, 0xFFac0001, 5);

	redThing.scrollFactor.set(0, 0);
	blackishGrayThing.scrollFactor.set(0, 0);
	whiteThing.scrollFactor.set(0, 0);
	weekTitle.scrollFactor.set(0, 0);
	tracklist.scrollFactor.set(0, 0);
	weekDescription.scrollFactor.set(0, 0);

	blackishGrayThing.angle = -3;
	whiteThing.angle = -3;
	weekTitle.angle = -3;
	tracklist.angle = -3;
	weekDescription.angle = -3;

	add(redThing);
	add(blackishGrayThing);
	add(whiteThing);
	add(weekTitle);
	add(tracklist);
	add(weekDescription);

	FlxTween.tween(blackishGrayThing, {x: -15}, 0.4, {ease: FlxEase.expoIn, onComplete: function(posi:FlxTween){
		FlxTween.tween(blackishGrayThing, {"scale.x": 2}, 0.2, {ease: FlxEase.elasticOut, type: FlxEase.BACKWARD});
		FlxTween.tween(whiteThing, {y: -45}, 0.3, {ease: FlxEase.smoothStepInOut, onComplete: function(poru:FlxTween){
			changeWeek(0);
			FlxTween.tween(redThing, {x: 0}, 0.15, {ease: FlxEase.smoothStepInOut});
		}});
	}});

	bg1 = new FlxSprite(-100).loadGraphic(Paths.image('menus/storymenu/menu_friends'));
	bg1.scrollFactor.x = 0;
	bg1.scrollFactor.y = 0.10;
	bg1.setGraphicSize(Std.int(bg1.width * 1.1));
	bg1.updateHitbox();
	bg1.alpha = 0.0001;
	insert(1,bg1);

	bg2 = new FlxSprite(-100).loadGraphic(Paths.image('menus/storymenu/menu_stage'));
	bg2.scrollFactor.x = 0;
	bg2.scrollFactor.y = 0.10;
	bg2.setGraphicSize(Std.int(bg2.width * 1.1));
	bg2.updateHitbox();
	bg2.alpha = 0.0001;
	insert(2,bg2);
}
function onChangeWeek(event){
	if (event.change == 0) event.playMenuSFX = false;
	var val = event.value;
	FlxTween.tween(weekTitle, {y: weekTitle.y + 0}, 0.00001, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween) {
		secondtween();
	}});
}
function onChangeDifficulty(){
	trace(curDifficulty);
}
function secondtween(){
	if (curWeek == 0){
		bg1.alpha = 1;	bg2.alpha = 0;
		}else	bg2.alpha = 1;

		FlxTween.tween(weekTitle, {x: whiteThing.x+whiteThing.width/2-weekTitle.width/2, y: whiteThing.y+whiteThing.height/2-weekTitle.height/2}, 0.2, {ease: FlxEase.elasticOut});

		FlxTween.tween(tracklist, {x: blackishGrayThing.x+blackishGrayThing.width/2-tracklist.width/9, y: whiteThing.y+whiteThing.height+20}, 0.15, {ease: FlxEase.elasticOut});
		
		FlxTween.tween(weekDescription, {x: blackishGrayThing.x+blackishGrayThing.width/2-weekDescription.width/2, y: (FlxG.height-weekDescription.height)-5}, 0.15, {ease: FlxEase.elasticOut});
}
override function update(elapsed:Float) {
	time += elapsed;
	radish.iTime = (Math.cos(time)/9999)+1;
}
function postUpdate(elapsed:Float) {
	if (controls.ACCEPT){
		FlxTween.tween(blackishGrayThing, {x: -FlxG.width}, 0.25, {ease: FlxEase.smootherStepInOut});
		FlxTween.tween(whiteThing, {y: -350}, 0.25, {ease: FlxEase.smootherStepInOut});
		FlxTween.tween(tracklist, {y: -350}, 0.25, {ease: FlxEase.smootherStepInOut});
		FlxTween.tween(weekDescription, {y: -350}, 0.25, {ease: FlxEase.smootherStepInOut});
	}
}
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