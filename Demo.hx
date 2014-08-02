

class Demo extends flash.display.Sprite {
	var engine : h3d.Engine;
	
	var game : h2d.Scene;
	var render : h2d.Scene;
	
	var tileRender : h2d.Tile;
	var bmpTileRender : h2d.Bitmap;
	
	function new() {
		super();
		engine = new h3d.Engine();
		engine.onReady = init;
		engine.backgroundColor = 0xFFCCCCCC;
		engine.init();
	}
	
	function init() {
		hxd.System.setLoop(update);
		game = new h2d.Scene();
		render = new h2d.Scene();
		
		tileRender = h2d.Tile.fromTexture( new h3d.mat.Texture(2048,2048,false,true ) );
		bmpTileRender = new h2d.Bitmap( tileRender, render );
	}
	
	function update() 	{
		game.captureBitmap(tileRender);
		
		engine.render(render);
		
		engine.restoreOpenfl();
	}
	
	static function main() {
		new Demo();
	}
}
