var stars:FlxSprite;
function create()
{
    var theSky:FlxSprite = new FlxSprite(-200, -200).loadGraphic(Paths.image('stages/broken_cart/Blue Sphere'));
    theSky.scrollFactor.set(0.2, 0.2);
        
    insert(1,theSky);

}

function postCreate()
{
}

function update(elapsed)
{
}