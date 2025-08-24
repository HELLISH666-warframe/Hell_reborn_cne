var stars:FlxSprite;
var bfZoom:Float = 0.45;
var bossZoom:Float = 0.6;
function create()
{
    var sky1:FlxSprite = new FlxSprite(-1000, 300).loadGraphic(Paths.image('stages/Chemical Plant/Sky1'));
    sky1.scale.set(1.6, 1.6);
    insert(1,sky1);

    var sky2:FlxSprite = new FlxSprite(-1000, -300).loadGraphic(Paths.image('stages/Chemical Plant/Sky2'));
    sky2.scale.set(1.6, 1.6);
    insert(2,sky1);
    
    var farbg4:FlxSprite = new FlxSprite(-1000, -700).loadGraphic(Paths.image('stages/Chemical Plant/Farbg4'));
    farbg4.scale.set(1.6, 1.6);
    insert(3,farbg4);
        
    var buildings:FlxSprite = new FlxSprite(-700, 120).loadGraphic(Paths.image('stages/Chemical Plant/Buildings'));
    buildings.scale.set(1.1, 1.1);
    insert(4,buildings);
        
    var plants:FlxSprite = new FlxSprite(-1000, -300).loadGraphic(Paths.image('stages/Chemical Plant/Plants'));
    plants.scale.set(1.6, 1.6);
    insert(5,plants);

    var bottom:FlxSprite = new FlxSprite(-1000, -300).loadGraphic(Paths.image('stages/Chemical Plant/Bottom'));
    bottom.scale.set(1.6, 1.6);
    insert(6,bottom);

    var farbg1:FlxSprite = new FlxSprite(-1000, -700).loadGraphic(Paths.image('stages/Chemical Plant/Farbg1'));
    farbg1.scale.set(1.6, 1.6);
    insert(7,farbg1);

    var farbg3:FlxSprite = new FlxSprite(-1000, -700).loadGraphic(Paths.image('stages/Chemical Plant/Farbg3'));
    farbg3.scale.set(1.6, 1.6);
    insert(8,farbg3);

    var farbg2:FlxSprite = new FlxSprite(-1000, -700).loadGraphic(Paths.image('stages/Chemical Plant/Farbg2'));
    farbg2.scale.set(1.6, 1.6);
    insert(9,farbg2);

    var ground1:FlxSprite = new FlxSprite(-1000, -700).loadGraphic(Paths.image('stages/Chemical Plant/Ground1'));
    ground1.scale.set(1.6, 1.6);
    insert(10,ground1);
    
    var ground2:FlxSprite = new FlxSprite(-1000, -700).loadGraphic(Paths.image('stages/Chemical Plant/Ground2'));
    ground2.scale.set(1.6, 1.6);
    insert(11,ground2);
}

function postCreate()
{
}

function update(elapsed)
{
}
function postUpdate(){
}