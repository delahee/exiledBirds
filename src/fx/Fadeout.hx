package fx;

import h2d.Drawable;
import h2d.Sprite;

import volute.fx.FX;

class Fadeout extends FX {
	var parent : Sprite;
	var alpha = 1.0;
	var alphalimit = 0.3;
	
	public function new(p) {
		super();
		this.parent = p;
	}
	
	public override function update() {
		var dalpha : Float = 1.0 /  C.time2frame( 2000 );
		alpha -= dalpha;
		parent.traverse( function(c) {
			if ( Std.is( c, h2d.Drawable)) {
				var d : h2d.Drawable = cast c;
				if ( d != null) d.alpha -= dalpha;
			}
		});
		
		trace( alpha);
		return alpha >= alphalimit; 
	}
	
}