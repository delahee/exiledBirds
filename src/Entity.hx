
import h2d.Drawable;
import volute.Coll;
import volute.Time;
import volute.Dice;
using volute.Ex;

enum ENT_TYPE
{
	ET_NONE;
	ET_SHIP;
	ET_BULLET;
}

@:publicFields
class Entity 
{
	var el : h2d.Drawable;
	
	var cx : Int = 0;
	var cy : Int = 0;
	
	var rx : Float = 0.0;
	var ry : Float = 0.0;
	
	var dx : Float = 0.0;
	var dy : Float = 0.0;
	
	var fx = 0.80;
	var fy = 0.80;
	
	var type:ENT_TYPE;
	
	var dead : Bool;
	
	static var uid = 0;
	var id = uid++;
	var idx :Int;
	
	var hp = 1;
	public function new() {
		type = ET_NONE;
		l = M.me.level;
		name = "entity#" + id;
		dead = false;
		idx = -1;
		ry = 0.5; rx = 0.5;
	}

	public function detach()
	{
		el.detach();
		l.remove(this);
	}
	
	public inline function realX() : Float return ((cx << 4) + rx * 16.0);
	public inline function realY() : Float return ((cy << 4) + ry * 16.0);
	
	
	public inline function test(cx, cy)
	{
		return l.staticTest(this,cx, cy);
	}
	
	public function updateX( f : Float )
	{
		var moved = false;
		function m() moved = true;
		
		while (rx > 1) {
			
			if (!test(cx + 1, cy)){
				rx--;
				cx++;
				
				moved = true;
			}
			else{
				rx -= 0.2;
				dx = 0;
				
				moved = true;
			}
		}
		
		while (rx < 0){
			if (!test(cx -1, cy)){
				rx++;
				cx--;
				
				moved = true;
			}
			else{
				rx += 0.2;
				dx = 0;
				
				moved = true;
			}
		}
		
		return moved;
	}
	
	
	public function updateY()
	{
		var moved = false;
		
		while (ry > 1){
			if (!test(cx , cy+1)){
				ry--;
				cy++;
				moved = true;
			}
			else{
				ry -= 0.2;
				dy = 0;
				moved = true;
			}
		}
		
		while (ry < 0){
			if (!test(cx , cy-1)){
				ry++;
				cy--;
				
				moved = true;
			}
			else{
				ry += 0.2;
				dy = 0;
				
				moved = true;
			}
		}
		
		return moved;
	}
	
	
	public function level() : Level{
		return M.me.level;
	}
	
	public inline function syncPos()
	{
		el.x = Std.int((cx << 4) + rx * 16.0);
		el.y = Std.int((cy << 4) + ry * 16.0;
	}
		
	public function kill()
	{
		if (el != null) {
			el.detach();
			
		}
		if( idx > 0 )
			l.remove(this);
	}
	
}