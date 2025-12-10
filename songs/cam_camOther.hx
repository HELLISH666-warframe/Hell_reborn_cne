public var camOther:HudCamera;
function create() {
    FlxG.cameras.add(camOther = new HudCamera(), false);
    camOther.bgColor = 0x00000000;
}
function postCreate() {
    FlxG.cameras.remove(camOther, false);
    FlxG.cameras.add(camOther = new HudCamera(), false);
    camOther.bgColor = 0x00000000;
}