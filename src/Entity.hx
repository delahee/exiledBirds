import h2d.Sprite;

enum ENT_TYPE
{
	ET_NONE;
	ET_SHIP;
	ET_BULLET;
}

@:publicFields
class Entity {
	var el : h2d.Sprite;
	
	var cx : Int = 0;
	var cy : Int = 0;
	
	var rx : Float = 0.0;
	var ry : Float = 0.0;
	
	var dx : Float = 0.0;
	var dy : Float = 0.0;
	
	var fx = 0.80;
	var fy = 0.80;
	
	var sizeX = 1;
	var sizeY = 1;
	
	var type:ENT_TYPE;
	
	var name: String;
	
	var dead : Bool;
	
	static var uid = 0;
	var id :Int;
	
	var hp = 1;
	
	var cells : IntStack;
	
	public function new() {
		type = ET_NONE;
		dead = false;
		id = uid++;
		ry = 0.5; rx = 0.5;
		cells = new IntStack();
	}

	public function dispose() {
		
	}
	
	public inline function realX() : Float return ((cx << 4) + rx * 16.0);
	public inline function realY() : Float return ((cy << 4) + ry * 16.0);
	
	public inline function getColl() {
		return Game.me.coll;
	}
	
	public inline function staticTest(cx, cy)	{
		return getColl().staticTest(this, cx, cy);
	}
	
	public function onCollideEntity( e : Entity ) {
		trace( this + " has collided " + e );
	}
	
	public function collides(e) {
		return volute.Coll.testCircleCircle( 
			e.realX(), e.realY(), Math.max( e.sizeX, e.sizeY),
			realX(), realY(), Math.max( sizeX, sizeY) );
	}
	
	public inline function dynamicTest(){
		var coll = getColl();
		
		for ( c in cells ) {
			var cellX = coll.getCx(c);
			var cellY = coll.getCy(c);
			
			if(coll.hasEntities(cellX,cellY))
				for ( eid in coll.getEntities(cellX, cellY)) {
					var e = coll.getEntity( eid );
					if ( e == this ) continue;
					
					if ( e.collides(this))
						e.onCollideEntity(this);
				}
		}
	}
	
	public function updateX(){
		var moved = false;
		function m() moved = true;
		
		while (rx > 1) {
			
			if (!staticTest(cx + 1, cy)){
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
			if (!staticTest(cx -1, cy)){
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
	
	public function updateY()	{
		var moved = false;
		
		while (ry > 1){
			if (!staticTest(cx , cy+1)){
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
			if (!staticTest(cx , cy-1)){
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
	
	
	public function update( frac : Float ) {
		
		var coll = getColl();
		
		rx += dx * frac;
		ry += dy * frac;
					
		if (  Math.abs( dx ) < 1e-3 )
			dx = 0;
			
		if (  Math.abs( dy ) < 1e-3 )
			dy = 0;
		
		var uy = updateY();
		var ux = updateX();
		
		while(ux||uy) {
			uy = updateY();
			ux = updateX();
		}
		
		syncPos();
		
		clearFromColl();
		cells.reset();
		
		var loRx = Std.int( realX() ) >>4;
		var hiRx = Math.ceil( (realX() + sizeX)  / 16.0 );
		
		var loRy = Std.int( realY() ) >>4;
		var hiRy = Math.ceil( (realY() + sizeY)  / 16.0 );
		
		var spreadX = hiRx - loRx;
		var spreadY = hiRy - loRy;
		
		for ( ccx in 0...spreadX )
			for ( ccy in 0...spreadY )
				cells.push( coll.getKey(cx + ccx, cy + ccy) );
		
		syncPos();
		
		dynamicTest();
	}
	
	public function clearFromColl() {
		var coll = getColl();
		for ( c in cells ) 
			coll.remove( this, coll.getCx(c),coll.getCy(c) );
	}
	
	public function brakes() {
		dx *= fx;
		dy *= fy;
		
		syncPos();
	}

	public inline function syncPos(){
		el.x = Std.int((cx << 4) + rx * 16.0);
		el.y = Std.int((cy << 4) + ry * 16.0);
	}
		
	
}