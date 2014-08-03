/**
 * @author blackmagic
 */
class C{
	public static var W = 1280;
	public static var H = 720;
	public static var FPS = 60.0;
	public static var DT = 1.0 / FPS;
	
	/**
	 * returns a number of frame
	 */
	public static function time2frame( ms ) {
		return ms / (DT * 1000.0);
	}
}