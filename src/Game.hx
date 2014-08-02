import mt.Ticker;
import volute.fx.FXManager;

class Game extends flash.display.Sprite {
	var engine : h3d.Engine;
	var time : Ticker = new Ticker(C.FPS);
	
	var game : h2d.Scene;
	var render : h2d.Scene;
	
	var tileRender : h2d.Tile;
	var bmpTileRender : h2d.Bitmap;
	
	var screenRect = new h3d.Vector(0, 0, 1280, 720);
	
	static var fxMan = new FXManager();
	static var me : Game;
	
	function new() {
		super();
		me = this;
		engine = new h3d.Engine();
		engine.onReady = init;
		engine.backgroundColor = 0xFFCCCCCC;
		engine.init();
	}
	
	function init() {
		hxd.System.setLoop(update);
		game = new h2d.Scene();
		render = new h2d.Scene();
		
		game.addChild( new ScreenLoading().init() );
		
		#if !NoRTT 
		tileRender = h2d.Tile.fromTexture( new h3d.mat.Texture(2048,2048,false,true ) );
		bmpTileRender = new h2d.Bitmap( tileRender, render );
		#end
		
		Data.init();
	}
	
	function update() 	{
		time.update();
		game.checkEvents();
		
		for( i in 0...time.dfr)
			fxMan.update();
		
		#if !NoRTT 
		game.captureBitmap(tileRender);
		engine.render(render);
		#else
		engine.render(game);
		#end
		
		engine.restoreOpenfl();
	}
	
	static function main() {
		new Game();
	}
}
