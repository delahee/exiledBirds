
/**
 * Provides 
 */
class OffscreenScene extends h2d.Scene {
	var wantedWith : Int;
	var wantedHeight : Int;
	
	public function new(w,h) {
		super();
		wantedWith = w;
		wantedHeight = h;
	}
	
	override function screenXToLocal(mx:Float) {
		return (mx - x) * wantedWith / (stage.width * scaleX);
	}

	override function screenYToLocal(my:Float) {
		return (my - y) * wantedHeight / (stage.height * scaleY);
	}
	
	public function renderOffscreen( target : h2d.Tile) {
		var engine = h3d.Engine.getCurrent();
		if( target == null ) {
			var tw = 1, th = 1;
			while( tw < width ) tw <<= 1;
			while( th < height ) th <<= 1;
			var tex = new h3d.mat.Texture(tw, th,false,true);
			target = new h2d.Tile(tex, 0, 0, Math.round(width), Math.round(height));
			#if cpp 
			target.flipY();
			#end
			target.getTexture().alpha_premultiplied = true;
		}
		
		
		
		var oc = engine.triggerClear;
		engine.triggerClear = true;
		engine.begin();
		
		engine.setRenderZone(target.x, target.y, wantedWith, wantedHeight);
		
		var tex = target.getTexture();
		engine.setTarget(tex,false);
		var ow = width, oh = height, of = fixedSize;
		setFixedSize(tex.width, tex.height);
		
		render(engine);
		width = ow;
		height = oh;
		fixedSize = of;
		
		engine.setTarget(null,false,null);
		engine.setRenderZone();
		engine.end();
	}
	
}