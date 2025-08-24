// I'm so exhausted man
var beans:FlxSprite;
function Create() {}
introLength = 0;
function onCountdown(event) event.cancel();
function postCreate(){
    beans = new FlxSprite(-200, -200).makeGraphic(4000,4000, FlxColor.WHITE);
    beans.camera = camHUD;
    beans.scrollFactor.set(0, 0);
    beans.alpha = 0.0001;
    insert(1,beans);
}
function dumbfuckingzoom(){
    FlxG.camera.zoom += 0.015;
    camHUD.zoom += 0.015;
}
function dumbfuckingvisthing(){
    FlxTween.tween(beans, {alpha: 0}, 3, {ease: FlxEase.linear});
}
function dumbfuckingvisthingIN(){
    FlxTween.tween(beans, {alpha: 1}, 1, {ease: FlxEase.linear});
}
function stepHit(curStep)
{
    switch (curStep)
    {
        case 24|89|275:
            FlxTween.tween(beans, {alpha: 1}, 1, {ease: FlxEase.linear});//in_white_speed_1
        case 31 | 95:
            FlxTween.tween(beans, {alpha: 0}, 3, {ease: FlxEase.linear});//out_white_speed_3
//        case 176 | 239 | 303 | 1031:
//            FlxTween.tween(FlxG.camera, {zoom: 1.2}, 0.6, {ease: FlxEase.elasticOut});
        case 404|406|408|410|411|412|413|414|415|442|443|444|445|446|447:
            FlxG.camera.zoom += 0.015;
            camHUD.zoom += 0.015;
    }
}
