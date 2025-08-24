var hand:FlxSprite;

function postCreate()
{
    hand = new FlxSprite(80, 700).loadGraphic(Paths.image('stages/Green Hill/Hand'));
    hand.scale.set(0.5, 0.5);
    hand.visible = false;

    insert(7,hand);
    dead_mountain.visible = false;
    dead_grass.visible = false;
    hand.visible = false;
}
function dead(){  
    dead_mountain.visible = true;
    dead_grass.visible = true;
}
function alive(){  
    dead_mountain.visible = false;
    dead_grass.visible = false;
}