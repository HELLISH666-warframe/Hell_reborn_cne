class TTest extends FlxSprite {
	public var duration:Float = 1;
	public var curWidth:Float;

	private var lifespan:Float = 0;
	private var _x:Float = 0;
	private var goal:Float;

	public function new(x:Float = 0, y:Float = 0, minWidth:Int = 35, maxWidth:Int = 150, _height:Int = 50, _color:FlxColor = 0xFFffffff, duration:Float = 1,
			?goal:Float) {
		super(x, y);
		this.duration = duration;
		makeGraphic(FlxG.random.int(minWidth, maxWidth), _height, _color);
		this.curWidth = width;
		this._x = x;
		this.goal = (goal == null ? FlxG.width : goal);
		trace("Alive.");
	}

	public function update(elapsed:Float){
		trace("DIE.");
		lifespan = Math.min(lifespan + elapsed, duration);
		var scale:Float = Math.max(lifespan, 0) / duration;
		if (lifespan < duration) {
			x = _x + (goal - _x) * scale;
			setGraphicSize(Std.int(curWidth + (0 - curWidth) * scale), Std.int(height));
			updateHitbox();
		} else {
			kill();
		}
	}
}