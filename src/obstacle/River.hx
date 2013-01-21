package obstacle;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Lib;
/**
 * ...
 * @author pistillphil
 */

class River extends AbstractObstacle
{
	
	private var riverBreadth:Int = 64;
	private var bridgePosition:Float;
	private var bridgeWidth:Float;

	public function new(bridgePos:Float) 
	{
		super();
		this.x = 0;
		this.y = -64;
		bridgeWidth = Main.player.width * 1.6;
		
		this.image = new Bitmap(new BitmapData(Lib.current.stage.stageWidth, riverBreadth, false, 0x0000FF));
		addChild(image);
	}
	
}