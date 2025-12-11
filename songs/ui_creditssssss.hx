var curSong:String = PlayState.SONG.meta.name;
var diff:String = PlayState.difficulty;
var creditPath = Paths.file("songs/" + curSong + "/credits-" + diff + ".txt");
function onSongStart() {
	if (Assets.exists('songs/'+curSong+'/credits-'+diff+'.txt') || Assets.exists('songs/'+curSong+'/credits-'+diff+'.txt')){
	openCredits(Assets.getText('songs/'+curSong+'/credits-'+diff+'.txt'));
	}else{
		if (sys.FileSystem.exists('songs/'+Paths.formatToSongPath(curSong).toLowerCase()+'/credits.txt') || sys.FileSystem.exists('assets/data/'+Paths.formatToSongPath(curSong).toLowerCase()+'/credits.txt'))
		openCredits(Paths.getTextFromFile('data/'+Paths.formatToSongPath(curSong).toLowerCase()+'/credits'+diff+'txt'));
	}
}
function openCredits(textBlah:Dynamic) {		
	var something = new FlxSprite(FlxG.width+300, -20).makeGraphic(600, FlxG.height+150, 0xFFac0001);
	something.scrollFactor.set(0, 0);
	something.camera=camOther;
	something.scale.x = 3.3;
	something.angle = -3;
	add(something);	

	var something2 = new FlxSprite(-37, -400).makeGraphic(600, 280, 0xFFe8d8c0);
	something2.scrollFactor.set(0, 0);
	something2.camera = camOther;
	something2.angle = -3;
	add(something2);

	var songNameThing = new ShakyText(-350, -200, 0, PlayState.SONG.meta.displayName, 100, Paths.font('Futura.otf'), 0xFFe9a642, 0xFFac0001, 5);
	songNameThing.scrollFactor.set(0, 0);
	songNameThing.camera = camOther;
	songNameThing.angle = -3;
	add(songNameThing);	

	if (songNameThing.width > something.width-100){
		fixTextSize(songNameThing, something2, -100);
		fixTextSize(songNameThing.shakyText, something2, -100);
	}

	var creditsThing = new FlxText(-350, 200, 0, "Coders: \n\nArtists: \n\nMusicians: \n\nCharters: \n", 35);
	creditsThing.color = 0xFF19181a;
	creditsThing.scrollFactor.set(0, 0);
	creditsThing.font = Paths.font('Futura.otf');
	creditsThing.camera = camOther;
	creditsThing.angle = -3;
	add(creditsThing);	

	var creditsThing2 = new FlxText(-550, 200, 0, textBlah+'\n', 35);
	creditsThing2.color = 0xFFe8d8c0;
	creditsThing2.scrollFactor.set(0, 0);
	creditsThing2.font = Paths.font('Futura.otf');
	creditsThing2.camera = camOther;
	creditsThing2.angle = -3;
	add(creditsThing2);
		
	FlxTween.tween(something, {x: -20}, 0.3, {ease: FlxEase.expoIn, onComplete: function(posi:FlxTween){
		FlxTween.tween(something2, {y: -70}, 0.2, {ease: FlxEase.expoIn, onComplete: function(paru:FlxTween){
			FlxTween.tween(songNameThing, {x: something2.x+something2.width/2-songNameThing.width/2, y: something2.y+something2.height/2-songNameThing.height/2}, 0.2, {ease: FlxEase.elasticOut});
			FlxTween.tween(something2, {"scale.y": 1.5}, 0.2, {ease: FlxEase.elasticOut, type: FlxEase.BACKWARD});
			FlxTween.tween(something, {"scale.y": 0.6}, 0.2, {ease: FlxEase.elasticOut, type: FlxEase.BACKWARD});
			FlxTween.tween(creditsThing, {x: 10, y: 350}, 0.2, {ease: FlxEase.elasticOut, onComplete: function(posi:FlxTween){
				FlxTween.tween(creditsThing2, {x: creditsThing.x+creditsThing.width+2, y: 340}, 0.2, {ease: FlxEase.elasticOut, onComplete: function(poru:FlxTween){
					new FlxTimer().start(((1/Conductor.bpm)*100)+1, function(tmr:FlxTimer) {
						FlxTween.tween(something, {x: -750}, 0.2, {ease: FlxEase.expoIn, onComplete: function(posi:FlxTween){
							FlxTween.tween(something2, {y: -750}, 0.2, {ease: FlxEase.expoIn});
							FlxTween.tween(songNameThing, {y: -750}, 0.2, {ease: FlxEase.expoIn});
							FlxTween.tween(creditsThing, {x: -750}, 0.2, {ease: FlxEase.expoIn});
							FlxTween.tween(creditsThing2, {x: -750}, 0.2, {ease: FlxEase.expoIn, onComplete: function(boing:FlxTween){
								remove(something);
								remove(something2);
								remove(songNameThing);
								remove(creditsThing);
								remove(creditsThing2);
							}});
						}});
					});
				}});
			}});
		}});
		FlxTween.tween(something, {"scale.x": 1}, 0.2, {ease: FlxEase.elasticOut});
	}});
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
            shakyText.camera = camOther;
            shakyText.text = text;
            shake();
        }else{
            shakyText.visible = false;
            shakyText.x = x;
            shakyText.y = y;
        }
    }
}
public function fixTextSize(text:FlxText, sprite:FlxSprite, ?mult:Float = 0)
{
    var ratio:Float = (sprite.width + mult) / text.textField.width;
    var originalOrigin:FlxPoint = FlxPoint.get(text.origin.x, text.origin.y);
    text.centerOrigin();
    text.scale.set(ratio, ratio);
    text.updateHitbox();
    text.offset.set(originalOrigin.x, originalOrigin.y);
    text.updateHitbox();
}