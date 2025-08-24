var stars:FlxSprite;
function create()
{
    var glitch:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/Glitch'));

    var frontTrees:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/FrontTrees'));

    var farBG1:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/FarBG1'));
    
    var farBG2:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/FarBG2'));
    
    var farBG3:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/FarBG2.5'));
    
    var farBG2_5:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/FarBG3'));
    
    var farBG4:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/FarBG4'));
        
    var ground:FlxSprite = new FlxSprite(-1300, -1150).loadGraphic(Paths.image('stages/Lord X stage/Ground'));
        
    insert(1,glitch);
    insert(2,farBG4);
    insert(3,farBG3);
    insert(4,farBG2);
    insert(5,farBG2_5);
    insert(6,farBG1);
    insert(7,ground);
    insert(13,frontTrees);

}

function postCreate()
{
}

function update(elapsed)
{
}