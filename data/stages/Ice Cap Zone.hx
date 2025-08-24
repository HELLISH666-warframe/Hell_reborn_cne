var bfZoom:Float = 0.45;
var bossZoom:Float = 0.6;

function postCreate()
    boyfriend.forceIsOnScreen = true; 

function postUpdate(){
    if (strumLines.members[curCameraTarget].characters[0].isPlayer == true){
        defaultCamZoom = bfZoom;
    }else{
        defaultCamZoom = bossZoom;
    }
}