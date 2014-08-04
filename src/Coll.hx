import haxe.ds.IntMap;
import hxd.Stack;

class Coll {
	var entities : Map<Int,Entity>;
	var grid : haxe.ds.Vector<IntStack>;
	
	public function new(lx,ly) {
		entities = new Map();
		grid = new haxe.ds.Vector((lx<<10) * ly);
	}
	
	public inline function getCx(key) {
		return key >> 10;
	}
	
	public inline function getKey(cx, cy) {
		#if debug
		if ( cx < 0 || cy < 0 )
			throw "coordinate assert";
		#end
		return cx << 10 | cy;
	}
	
	public inline function getCy(key) {
		return key & ((1<< 10)-1);
	}
	
	public function register( e:Entity ) {
		entities.set(e.id,e);
	}
	
	public function unregister(e:Entity) {
		e.clearFromColl();
		entities.remove(e.id);
	}
	
	public function staticTest(e:Entity,cx:Float, y:Float) {
		return false;
	}
	
	public function dynamicTest(x:Float, y:Float) {
		return false;
	}
	
	public function remove( e:Entity, cx:Int, cy:Int) {
		getEntities(cx, cy).remove(e.id);
	}
	
	public function getEntity(eid) {
		for ( e in entities )
			if ( eid == e.id )
				return e;
		return null;
	}
	
	public function hasEntities(cx:Int, cy:Int) {
		var e = grid[ getKey(cx, cy) ];
		return e != null && e.length > 0;
	}
	
	public function getEntities(cx:Int, cy:Int) {
		return grid[ getKey(cx, cy) ];
	}
	
	public function update() {
		for( i in 0...4)
			for ( e in entities ) {
				e.update(0.25);
			}
			
		for ( e in entities ) {
			e.brakes();
		}
	}
}