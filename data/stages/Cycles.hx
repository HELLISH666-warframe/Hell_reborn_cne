 var thing1:FlxSprite;
public var thing2:FlxSprite;
function create()
{
	//defaultCamZoom = 0.5;
}

function postCreate()
{
	var seemslikefarmland:FlxSprite = new FlxSprite(-400, -450).loadGraphic(Paths.image('stages/Cycles/floor'));

    var sharpcrap:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('stages/Cycles/hills1'));
    
    var ppsky:FlxSprite = new FlxSprite(-800, -400).loadGraphic(Paths.image('stages/Cycles/sky'));

	var ppskyefx:FlxSprite = new FlxSprite(-800, -400).loadGraphic(Paths.image('stages/Cycles/skyeffect'));

	var fronttree:FlxSprite = new FlxSprite(-800, -200).loadGraphic(Paths.image('stages/Cycles/front_trees'));

	var cloud1:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('stages/Cycles/Clouds1'));

	var cloud:FlxSprite = new FlxSprite(-800, -300).loadGraphic(Paths.image('stages/Cycles/Clouds'));

	thing1 = new FlxSprite(100,500);
	thing1.frames = Paths.getSparrowAtlas('stages/Cycles/smallflower');
	thing1.animation.addByPrefix('okay', 'Idle', 24, true);
	thing1.animation.play('okay', true);

	thing2 = new FlxSprite(1750,250);
	thing2.frames = Paths.getSparrowAtlas('stages/Cycles/smallflower2');
	thing2.animation.addByPrefix('lol', 'Idle', 24, true);
	thing2.animation.play('lol', true);

	seemslikefarmland.scale.set(0.8, 0.8);
	fronttree.scale.set(1.5, 1.5);

	ppsky.scrollFactor.set(0.9, 0.9);
	sharpcrap.scrollFactor.set(0.8, 0.8);
	cloud.scrollFactor.set(0.9, 0.9);
	cloud1.scrollFactor.set(0.5, 0.5);

	insert(1,ppsky);
    insert(2,cloud1);
    insert(3,cloud);
    insert(4,sharpcrap);
    insert(5,seemslikefarmland);
    insert(6,thing1);
    insert(7,thing2);
	insert(10,fronttree);
	insert(11,ppskyefx);
}

function update(elapsed)
{
}