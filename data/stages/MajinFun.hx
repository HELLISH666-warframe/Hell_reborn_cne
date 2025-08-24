public var forr:FlxSprite;
public var camera:FlxSprite;
function create()
{
    forr = new FlxSprite(350,580);
	forr.frames = Paths.getSparrowAtlas('stages/Fun/For');
	forr.animation.addByPrefix('first', 'boom', 24, false);
	forr.animation.play('first', true);
	//forr.scrollFactor.set(0.05, 0.05);
	//forr.screenCenter();

    var smile:FlxSprite = new FlxSprite(-300, 0).loadGraphic(Paths.image('stages/Fun/Smile'));

    var the:FlxSprite = new FlxSprite(-850, 200).loadGraphic(Paths.image('stages/Fun/The'));
    
    camera = new FlxSprite(-200,600);
	camera.frames = Paths.getSparrowAtlas('stages/Fun/Camera');
	camera.animation.addByPrefix('first', 'Bounce', 24, false);
	camera.animation.play('first', true);
	//camera.scrollFactor.set(0.05, 0.05);

    smile.scale.set(1.5, 1.5);
    camera.scale.set(1.9, 1.9);
    the.scale.set(1.5, 1.5);

    insert(1,the);
    insert(2,smile);
    insert(3,forr);
    insert(9,camera);
}

function postCreate()
{
}

function update(elapsed)
{
}