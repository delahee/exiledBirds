package volute.fx;

/** @author blackmagic */
class FX
{
	public dynamic function onKill(){}
	public dynamic function onUpdate(t) { }
	
	public function new() {
		FXManager.self.add(this);
	}
	
	public function kill(){
		onKill();
		//allow garbage
		onKill = null;
	}
	
	//return false whence wanna kill
	public function update() :  Bool	{
		return false;
	}
}