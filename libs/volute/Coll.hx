package volute;
import mt.deepnight.T;
import mt.gx.math.Vec2;

class MovingSphere{
	radius : Float;
	
	ox : Float;
	oy : Float;
	
	nx : Float;
	ny : Float;

	public inline function new (r, opx, opy, npx, npy) {
		radius = r;
		ox = opx;
		oy = opy;
		
		nx = npx;
		ny = npy;
	}
}

class Coll{
	
	public static inline function testCircleCircle( x : Float, y : Float, r : Float, xx  : Float, yy : Float, rr : Float) {
		var cx = xx - x;
		var cy = yy - y;
		var r3 = r + rr;
		return cx*cx + cy*cy< r3*r3;
	}
	
	public static inline function testCircleRectAA(cx:Float,cy:Float, cr:Float, rx,ry, rw,rh) {
		var closestx = MathEx.clamp(cx, rx, rx + rw);
		var closesty = MathEx.clamp(cy, ry, ry + rh);
		
		var dx = cx - closestx;
		var dy = cy - closesty;
		
		return dx * dx + dy * dy < cr * cr;
	}
	
	public static inline function testPointRectAA(px:Float,py:Float,rx:Float,ry,rw,rh) {
		return px >= rx && py >= ry && px <= rx + rw && py <= ry + rh;
	}
	
	inline function quadraticFormula(a, b, c, res) : Bool{
		var q = b * b - 4 * a * c;
		if (q >= 0) {
			var sq = Math.sqrt( q );
			var d = 1 / 2 * a;
			res.x = (-b+sq)  *d;
			res.y = (-b-sq)  *d;
			return true;
		}
		else {
			return false;
		}
	}
	
	public static inline function sphereSphereSweep( ms0 : MovingSphere,ms1:MovingSphere, res:Vec2) : Bool{
		var move0 	= new Vec2( ms0.nx - ms0.ox, 
								ms0.ny - ms0.oy );
								
		var move1 	= new Vec2( ms1.nx - ms1.ox, 
								ms1.ny - ms1.oy );
								
		var diffO 	= new Vec2(	ms1.ox - ms0.ox, 
								ms1.oy - ms0.oy);
								
		var vel 	= new Vec2(	move1.x - move0.x, 
								move1.y - move.x);
								
		var rab 	= ms0.r + ms1.r;
		
		var a = vel.dot(vel);
		var b = 2 * vel.dot( diff0);
		var c = diff0.dot(diff0) - rab * rab;
		
		if ( diff0.dot(diff0) < rab * rab ) {
			res.x = 0;
			res.y = 0;
			return true;
		}
		
		if ( quadraticFormula( a,b,c,res) ) {
			if ( res.x > res.y ){
				var tmp = res.y;
				res.y = res.x;
				res.x = tmp;
			}
			
			return true;
		}
		
		return false;
	}
}