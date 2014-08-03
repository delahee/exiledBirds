package volute.fx;

using Lambda;

class FXManager
{
	public var rep : List<FX>;
	public static var self : FXManager;
	
	public function new() {
		rep = new List<FX>();
		self = this;
	}
	
	public function update() {
		if ( rep.length > 0) 
			rep = rep.filter( function(fx) { 
				var cont = fx.update();
				if ( !cont ) fx.kill();
				return cont;
			});
	}
	
	public function add(  x :FX ){
		rep.add(x);
	}
}