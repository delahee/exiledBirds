import mt.Ticker;
import volute.fx.FXManager;

class Game extends flash.display.Sprite {
	var engine : h3d.Engine;
	var time : Ticker = new Ticker(C.FPS);
	
	var game : OffscreenScene;
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
		game = new OffscreenScene(Math.round(screenRect.z),Math.round(screenRect.w));
		render = new h2d.Scene();
		
		game.addChild( new ScreenLoading().init() );
		
		tileRender = h2d.Tile.fromTexture( new h3d.mat.Texture(2048,1024,false,true ) );
		bmpTileRender = new h2d.Bitmap( tileRender, render );
		
		Data.init();
	}
	
	function update() 	{
		time.update();
		
		for( i in 0...time.dfr)
			fxMan.update();
		
		game.renderOffscreen(tileRender);
		engine.render(render);
	
		
		engine.restoreOpenfl();
	}
	
	static function main() {
		new Game();
	}
}
