private class StackIterator {
	var b : Array<Int>;
	var len : Int;
	var pos : Int;
	public inline function new( b : Array<Int>,len:Int )  {
		this.b = b;
		this.len = len;
		this.pos = 0;
	}
	public inline function hasNext() {
		return pos < len;
	}
	public inline function next() {
		return b[pos++];
	}
}

class IntStack {
	var arr : Array<Int>=[];
	var pos = 0;
	
	public var length(get, never):Int; inline function get_length() return pos;
	public inline function new() {}
	
	/**
	 * slow, breaks order but no realloc
	 */
	public #if !debug inline #end  function remove(v):Bool{
		var i = arr.indexOf(v);
		if ( i < 0 ) return false;
		
		if( pos > 1 ){
			arr[i] = arr[pos-1];
			arr[pos-1] = 0;
			pos--;
		}
		else {
			arr[0] = 0;
			pos = 0;
		}
		return true;
	}
	
	public inline function push(v) {
		arr[pos++] = v;
	}
	
	public inline function pop() :int {
		if ( pos == 0 ) return null;
			
		var v = arr[pos-1]; 
		arr[pos-1] = 0;
		pos--;
		return v;
	}
	
	public inline function reset() {
		for ( i in 0...arr.length) arr[i] = 0;
		pos = 0;
	}
	
	public inline function iterator() {
		return new StackIterator(arr,get_length());
	}
	
	public inline function toString() {
		var s = "";
		for ( i in 0...pos) {
			s += Std.string(arr[i]);
		}
		return s;
	}
}