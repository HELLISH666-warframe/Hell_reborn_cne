var time:Float = 0;
function GO_UP() {
    trace('UP');
    var UPtimer = new FlxTimer().start(1, function(tmr:FlxTimer)
        {
            FlxTween.tween(dad, {y: 600}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    {DOWNNN1();}});
            //FlxTween.tween(dad, {y: -300}, 1.5,{ease: FlxEase.linear});
            //dad.y -= (Math.sin(time)/2)+300;
           // DOWNNN();
        }
        );
	var UPbtimer = new FlxTimer().start(0.1, function(tmr:FlxTimer)
		{
			FlxTween.tween(boyfriend, {y: 600}, 1.5,{ 
				ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
					{DOWNNN1B();  trace('UPB');}});
		}
		);
}
function DOWNNN1() {
    trace('DOWN1');
    var DOWNtimer = new FlxTimer().start(1.3, function(tmr:FlxTimer)
        {
            FlxTween.tween(dad, {y: 1000}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    {GO_UP1();}});
           // dad.y += (Math.sin(time)/2)+200;
          //  GO_UP();}
         }
        );
}
function DOWNNN1B() {
    trace('DOWN1B');
    var DOWNtimer = new FlxTimer().start(1.1, function(tmr:FlxTimer)
        {
            FlxTween.tween(boyfriend, {y: 1000}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    {GO_UP1B();trace('DOWN1B');}});
           // dad.y += (Math.sin(time)/2)+200;
          //  GO_UP();}
         }
        );
}
function STRAIAIGHT() {
    trace('MIDDLE');
    var DOWNtimer = new FlxTimer().start(5.5, function(tmr:FlxTimer)
        {
            DOWNNN2();
			DOWNNN2b();
         }
        );
}
function DOWNNN2b() {
    trace('DOWN2B');
    var DOWNtimer = new FlxTimer().start(0.01, function(tmr:FlxTimer)
        {
            FlxTween.tween(boyfriend, {y: 1000}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    {    trace('DOWN2B');}});
           // dad.y += (Math.sin(time)/2)+200;
          //  GO_UP();}
         }
        );
}
function DOWNNN2() {
    trace('DOWN2');
    var DOWNtimer = new FlxTimer().start(1.1, function(tmr:FlxTimer)
        {
            FlxTween.tween(dad, {y: 1000}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    {STRAIAIGHT1();}});
           // dad.y += (Math.sin(time)/2)+200;
          //  GO_UP();}
         }
        );
}
function GO_UP1B() {
    trace('UP2B');
    var UPtimer = new FlxTimer().start(1.3, function(tmr:FlxTimer)
        {
            FlxTween.tween(boyfriend, {y: 600}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    { trace('UP2B');}});
        }
    );
}
function GO_UP1() {
    trace('UP2');
    var UPtimer = new FlxTimer().start(1.3, function(tmr:FlxTimer)
        {
            FlxTween.tween(dad, {y: 600}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    {STRAIAIGHT();}});
        }
    );
}
function GO_UP2() {
    trace('UP3');
    var UPtimer = new FlxTimer().start(1.2, function(tmr:FlxTimer)
        {
            FlxTween.tween(dad, {y: 600}, 1.5,{ 
                ease: FlxEase.linear, onComplete: function(twn:FlxTween) 
                    {STRAIAIGHT1();}});
            //FlxTween.tween(dad, {y: -300}, 1.5,{ease: FlxEase.linear});
            //dad.y -= (Math.sin(time)/2)+300;
           // DOWNNN();
        }
        );
}
function STRAIAIGHT1() {
    trace('MIDDLE2');
    var DOWNtimer = new FlxTimer().start(3, function(tmr:FlxTimer)
        {
            GO_UP();
         }
        );
}