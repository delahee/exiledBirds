import h2d.Bitmap;
import h2d.Tile;

class ScreenGame extends Screen {
	var bg : Bitmap;
	
	public function new() {
		super();
	}
	
	public override function init() {
		super.init();
		bg = new Bitmap(Tile.fromColor(0xFF1B0BA3, C.W, C.H), this);
		return this;
	}
	
	public override function update() {
		super.update();
		
		var a = 0;
	}
	
}