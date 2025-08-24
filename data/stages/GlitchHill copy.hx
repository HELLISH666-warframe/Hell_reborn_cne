import flixel.addons.display.FlxBackdrop;
var background:FlxBackdrop;
var time:Float = 0;
function create()
{
}
function postCreate()
{
   // var background:FlxSprite = new FlxSprite(600, 2100).loadGraphic(Paths.image('stages/misc/GlitchHillz'));
	background = new FlxBackdrop(Paths.image('stages/misc/GlitchHillz'), FlxAxes.X, 0, 0);
    background.y = 2100;
    background.x = 600;
    background.scale.set(6, 6);
    insert(1,background);
    boyfriend.scale.set(0.5, 0.5);
    dad.scale.set(0.5, 0.5);
}
function stepHit(curStep){
    if (curStep == 496)
    {
        dad.scale.set(0.5, 0.5);
    }
    if (curStep == 1041)
    {
        boyfriend.scale.set(0.5, 0.5);
        dad.scale.set(0.5, 0.5);
        var rainbTmr = new FlxTimer().start(0.005, function(tmr:FlxTimer)
            {
                background.x -= (Math.sin(time)/2)+9;
                tmr.reset(0.005);}
            );
    }
}