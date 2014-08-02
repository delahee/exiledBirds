import flash.display.Bitmap;

class Screen extends h2d.Sprite {
	public var isStarted = false;
	public static var me : Screen;
	public function new() 
	{
		super();
		visible = false;
		me = this;
		name = getName();
	}

	public function getName() :String return Std.string(Type.getClass(this))
	
	/** Dont forget to call me */
	public function init(){
		me = this;
		isStarted = true;
		visible = true;
	}
	
	/** returns true whether you shoould continue the kill */
	public function kill()
	{
		if ( !isStarted ) return false;
		
		isStarted = false;
		visible = false;
		
		return true;
	}
	
	public function update()
	{
		if (!isStarted) return;
	}
}