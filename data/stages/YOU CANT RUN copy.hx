var stars:FlxSprite;
var sky:FlxSprite;
function create()
{
    
	sky = new FlxSprite(-2400,-10);
	sky.frames = Paths.getSparrowAtlas('stages/YCR/staticBACKGROUND2');

    var sky2:FlxSprite = new FlxSprite(-1800, -10).loadGraphic(Paths.image('stages/misc/Sky'));
    
    var farBack:FlxSprite = new FlxSprite(-1800, -10).loadGraphic(Paths.image('stages/YCR/Further Back Trees'));

    var back:FlxSprite = new FlxSprite(-1800, -10).loadGraphic(Paths.image('stages/YCR/Back Trees'));

    var floor:FlxSprite = new FlxSprite(-600, -10).loadGraphic(Paths.image('stages/YCR/Grass And Trees'));
    
    var bushes:FlxSprite = new FlxSprite(-2300, -10).loadGraphic(Paths.image('stages/YCR/Front Bushes'));
    
    thing1.animation.addByPrefix('static', 'menuSTATICNEW instance ', 24, true);
	thing1.animation.play('static', true);

    var sunset_Floor:FlxSprite = new FlxSprite(-2300, -700).loadGraphic(Paths.image('stages/YCR/Sunset Hill Floor'));
    
    var sunset_Back:FlxSprite = new FlxSprite(-3000, -2600).loadGraphic(Paths.image('stages/YCR/Sunset Hill Back'));
    //setProperty('Sunset Floor.visible', false);
    //setProperty('Sunset Back.visible', false);
    
    var Hill_Floor:FlxSprite = new FlxSprite(-2300, -1850).loadGraphic(Paths.image('stages/YCR/Green Hill Floor'));
    
    var sunset_Back:FlxSprite = new FlxSprite(-3000, -2600).loadGraphic(Paths.image('stages/YCR/Sunset Hill Back'));
    
    makeLuaSprite('Hill Floor', 'YCR/Green Hill Floor', -2300, -1850);
    makeLuaSprite('Hill Back', 'YCR/Green Hill Back', -3000, -4000);
    setProperty('Hill Floor.visible', false);
    setProperty('Hill Back.visible', false);
    makeLuaSprite('Angel', 'YCR/Angel Island', -1500, -650);
    setProperty('Angel.visible', false);

    insert(1,sunky);
}

function postCreate()
{
    boyfriend.forceIsOnScreen = true; 
}

function update(elapsed)
{
}