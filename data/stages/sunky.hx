var stars:FlxSprite;
function create()
{
    var sunky:FlxSprite = new FlxSprite(-600, -300).loadGraphic(Paths.image('stages/misc/sunky'));
    sunky.scrollFactor.set(0.9, 0.9);

    insert(1,sunky);
}

function postCreate()
{
    boyfriend.forceIsOnScreen = true; 
}

function update(elapsed)
{
}