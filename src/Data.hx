import h2d.Tile;
import openfl.Assets;
import hxd.res.FontBuilder;

class Data {
	public static var nokia : h2d.Font;
	public static var arial : h2d.Font;
	
	public static var sheet : Tile;
	
	public static function init() {
		var oflNokia = Assets.getFont("assets/nokiafc22.ttf");
		if ( oflNokia == null ) throw "assert font";
		
		nokia = FontBuilder.getFont(oflNokia.fontName, 12);
		FontBuilder.addFontAlias("nokia", oflNokia.fontName );
	}
}