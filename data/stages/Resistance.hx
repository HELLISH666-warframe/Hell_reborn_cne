function create()
{
}

function postCreate()
{

    var city:FlxSprite = new FlxSprite(-1000, 200).loadGraphic(Paths.image('stages/Resistance/Egg'));
	city.scale.set(1.6, 1.6);
    insert(1, city);
    add(city);
	
    var fuck:FlxSprite = new FlxSprite(-1000, 200).loadGraphic(Paths.image('stages/Resistance/Ground'));
	fuck.scale.set(1.6, 1.6);
    insert(2, fuck);
    add(fuck);
		
    var FUCKER:FlxSprite = new FlxSprite(-6000, 1000).loadGraphic(Paths.image('stages/Resistance/overlay'));
	FUCKER.scale.set(6.3, 6.3);
    insert(2, FUCKER);
    add(FUCKER);
}

function update(elapsed)
{
}