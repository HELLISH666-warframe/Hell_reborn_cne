//This_old-ass_state_i_coded_makes_me_want_blood.
import flixel.graphics.FlxGraphic;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxTypedEmitter;
import flixel.text.FlxTextAlign;
import flixel.addons.display.FlxBackdrop;

var black1:FlxSprite;
public var middleSprite:FlxSprite;
var time:Float = 0;
var camText:FlxCamera = new FlxCamera();
camText.bgColor = null;
FlxG.cameras.add(camText);
camText.x += 6000;
var iconArray2:Array<HealthIcon> = [];
function create() {
}
function postCreate() {
	FlxG.cameras.add(camText, false);
	grpSongs.camera = camText;
	for (i in grpSongs.members) i.camera = camText;
	for (i in iconArray) remove(i);

	middleSprite = new FlxSprite(0, FlxG.height - 300).makeGraphic(FlxG.width, 300, 0xFFe8d8c0);
	middleSprite.scrollFactor.set(0, 0);
	add(middleSprite);

	diffText = new FlxText(0, FlxG.height-200, 0, '< NORMAL >', 60);
	diffText.font = Paths.font("Futura.otf");
	diffText.color = 0xFF19181a;
	add(diffText);

	scoreText = new FlxText(FlxG.width-330, FlxG.height-150, 0, "", 20);
	scoreText.setFormat(Paths.font("Futura.otf"), 55, 0xFF19181a, 'center');
	scoreText.alignment = 'center';
	add(scoreText);

	black1 = new FlxSprite(-20, -40).makeGraphic(610, FlxG.height + 100, 0xFF19181a);
	black1.scrollFactor.set(0, 0);
	black1.angle = -3;
	add(black1);
	for (i in 0...songs.length) {
		var songText:FlxText = new FlxText(0, (70 * i) + 30, 0, songs[i].displayName.toUpperCase(), 80);
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

		iconArray2.push(icon);
		add(icon);
	}
	for (i in grpSongs.members){insert(3333,i);}
}
function onChangeSelection(event) {
	FlxTween.tween(camText, {x: camText.x + 45}, 0.00001, {ease: FlxEase.quintIn, onComplete: function(twn:FlxTween) {
		for (i in 0...iconArray2.length) iconArray2[i].alpha = 0;
	    iconArray2[curSelected].alpha = 1;
	
		for (item in grpSongs.members) {
			FlxTween.tween(item, {y: (70*item.ID)-(70*curSelected)+15}, 0.2, {ease: FlxEase.smoothStepInOut});
			if (item.ID == curSelected)
				item.color = 0xFFffdf02;
			else
				item.color = 0xFFe8d8c0;
		}
	}});
}