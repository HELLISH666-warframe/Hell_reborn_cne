var stars:FlxSprite;
var sky:FlxSprite;
var thing1:FlxSprite;
function postCreate()
{
    
	sky = new FlxSprite(-2400,-10);
	sky.frames = Paths.getSparrowAtlas('stages/YCR/staticBACKGROUND2');

    var sky2:FlxSprite = new FlxSprite(-1800, -10).loadGraphic(Paths.image('stages/misc/Sky'));
    
    var farBack:FlxSprite = new FlxSprite(-1800, -10).loadGraphic(Paths.image('stages/YCR/Further Back Trees'));

    var back:FlxSprite = new FlxSprite(-1800, -10).loadGraphic(Paths.image('stages/YCR/Back Trees'));

    var floor:FlxSprite = new FlxSprite(-600, -10).loadGraphic(Paths.image('stages/YCR/Grass And Trees'));
    
    var bushes:FlxSprite = new FlxSprite(-2300, -10).loadGraphic(Paths.image('stages/YCR/Front Bushes'));
    
    sky.animation.addByPrefix('static', 'menuSTATICNEW instance ', 24, true);
	sky.animation.play('static', true);

    var sunset_Floor:FlxSprite = new FlxSprite(-2300, -700).loadGraphic(Paths.image('stages/YCR/Sunset Hill Floor'));
    
    var sunset_Back:FlxSprite = new FlxSprite(-3000, -2600).loadGraphic(Paths.image('stages/YCR/Sunset Hill Back'));

    sunset_Back.visible=false;
    sunset_Floor.visible=false;

    var hill_Floor:FlxSprite = new FlxSprite(-2300, -1850).loadGraphic(Paths.image('stages/YCR/Green Hill Floor'));
    
    var hill_Back:FlxSprite = new FlxSprite(-3000, -4000).loadGraphic(Paths.image('stages/YCR/Green Hill Back'));

    hill_Floor.visible=false;
    hill_Back.visible=false;
        
    var angle:FlxSprite = new FlxSprite(-1500, -650).loadGraphic(Paths.image('stages/YCR/Angel Island'));
    
    angle.visible=false;
    //setProperty('Angel.visible', false);

    var black_vig:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('stages/blackvignette'));
    black_vig.camera = camHUD;
    black_vig.screenCenter(FlxAxes.X);

    insert(1,sky2);
    
    insert(2,farBack);
    insert(3,sky);
    insert(4,back);
    insert(5,floor);
    insert(2222,bushes);
    insert(7,sunset_Back);
    insert(8,hill_Floor);
    insert(9,sunset_Floor);
    insert(10,hill_Back);
    insert(11,angle);
    insert(12,black_vig);
}


function update(elapsed)
{
}