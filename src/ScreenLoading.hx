import h2d.comp.Component;
import h2d.Text;
import openfl.Assets;

class ScreenLoading extends Screen {

	var document : Component;
	
	public function new() {
		super();
	}
	
	public override function resize() {
		document.setStyle(null);
	}
	
	function onPlay() {
		var fx = new fx.Fadeout(this);
		fx.onKill = function() {
			parent.addChild(new ScreenGame().init());
		}
		kill();
	}
	
	public override function init() {
		super.init();
		
		document = h2d.comp.Parser.fromHtml( openfl.Assets.getText("assets/loading.html"), {onPlay:onPlay} );
		addChild( document );
		
		//var arial = hxd.res.FontBuilder.getFont("arial", 40);
		/*
		var oflNokia = Assets.getFont("assets/nokiafc22.ttf");
		trace(oflNokia.fontName);
		var nokia = hxd.res.FontBuilder.getFont(oflNokia.fontName, 40);
		var txt = new Text( nokia, this );
		txt.text = "SALUT";
		txt.x = 100;
		txt.y = 100;
		*/
		
		return this;
	}
}