
function stepHit(curStep)
{
    if (curStep == 1439)
    {
    FlxTween.tween(camHUD, {alpha: 0}, 5, {ease: FlxEase.linear});
    trace('fucking_dumb');
    }
}
