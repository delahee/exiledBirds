import flash.display.Bitmap;

class Screen extends h2d.Sprite {
	public var isStarted = false;
	public var paused = false;
	
	public static var me : Screen;
	public static var ALL : List<Screen>= new List();
	
	public function new() 
	{
		super();
		visible = false;
		me = this;
		name = getName();
		ALL.push(this);
	}

	public function getName() :String return Std.string(Type.getClass(this));
	
	public function resize() {
		
	}
	
	/** Dont forget to call me */
	public function init(){
		me = this;
		isStarted = true;
		visible = true;
		return this;
	}
	
	/** returns true whether you shoould continue the kill */
	public function kill()
	{
		if ( !isStarted ) return false;
		
		isStarted = false;
		visible = false;
		
		ALL.remove(this);
		
		return true;
	}
	
	public static function updateAll()	{
		for ( a in ALL )
			a.update();
	}
	
	public function update()
	{
		if (!isStarted) return;
	}
}