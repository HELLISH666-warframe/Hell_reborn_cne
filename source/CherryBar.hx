class CherryBar extends FlxSprite{
	public var currentAmount:Float;
	public var maxAmount:Float;
	public var field:Dynamic;
	public var maxField:Float;

	private var lerpedAmount:Float;

	public function new(x:Float, y:Float, amount:Float, maxAmount:Float, field:Dynamic, maxField:Float, color:FlxColor){
		currentAmount = amount;
		this.maxAmount = maxAmount;
		this.field = field;
		this.maxField = maxField;
		lerpedAmount = amount;

		super(x, y);
		makeGraphic(20, 20, color);
	}
	override function update(elapsed:Float)
	{
		lerpedAmount = FlxMath.lerp(lerpedAmount, currentAmount, FlxMath.bound(elapsed * 30, 0, 1));
		var theething:Int = Math.floor((maxField*(lerpedAmount*100))/(maxAmount*100)/*for some optional shit*/);
		if (field == 'width'){
			setGraphicSize(theething, 20);
			updateHitbox();
			x = (maxField-theething);
		}else{ if (field == 'height'){
			setGraphicSize(20, theething);
			updateHitbox();
			y = (maxField-theething);
		}}

		super.update(elapsed);
	}
	//public var percent(get, never):Int;
	private function get_percent():Int
	{
		return Math.floor((currentAmount * 100)/maxAmount);
	}
}