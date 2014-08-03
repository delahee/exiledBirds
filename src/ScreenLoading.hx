import h2d.Anim;
import h2d.comp.Component;
import h2d.css.Fill;
import h2d.Drawable;
import h2d.Text;
import h2d.Tile;
import haxe.Timer;
import hxd.Key;
import hxd.res.FontBuilder;
import openfl.Assets;

class ScreenLoading extends Screen {

	var document : Component;
	var t : h2d.Text;
	
	public function new() {
		super();
	}
	
	public override function resize() {
		document.setStyle(null);
	}
	
	function onPlay() {
		if (paused) return;
		
		trace("let's play !");
		var p  = Game.me.game;
		var fx = new fx.Fadeout(this);
		fx.onKill = function() {
			kill();
			trace("let's play fadeout !");
			p.addChild(new ScreenGame().init());
		}
		paused = true;
	}
	
	public override function init() {
		super.init();
		
		document = h2d.comp.Parser.fromHtml( openfl.Assets.getText("assets/loading.html"), {onPlay:onPlay} );
		addChild( document );
		
		t = new Text( FontBuilder.getFont("nokia",30), this );
		t.x = 100;
		t.y = 150; 
		t.text = "Awesome !";
		
		return this;
	}
	
	public function traverseDrawable(parent, f:h2d.Drawable-> Void) {
		parent.traverse( function(c) {
			if ( Std.is( c, h2d.Drawable)) {
				var d : h2d.Drawable = cast c;
				f(d);
			}
		});
	}
}