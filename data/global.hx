//
import funkin.menus.TitleState;
function new()
{   
        if (FlxG.save.data.hud_side == null) FlxG.save.data.hud_side = true;
    
}
function update(elapsed:Float)
	if (FlxG.keys.justPressed.F5) FlxG.resetState();

var redirectStates:Map<FlxState, String> = [
    MainMenuState => "MainMenuSubState", 
	TitleState => "TitleState"
];

function preStateSwitch() {
	for (redirectState in redirectStates.keys())
		if (FlxG.game._requestedState is redirectState)
			FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}