
class Coll {
	var grid : haxe.ds.Vector<IntStack>;
	
	public function new(lw,lh) 	{
		grid = new haxe.ds.Vector( (lw << 10) * lh );
	}
	
	public function key(x, y) {
		return (x << 10 ) | y;
	}
	
	public function update() {
		
		
	}
}