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
	
	private var image2:Bitmap;

	public function new(bridgePos:Float, bridgeWidth:Float) 
	{
		super();
		this.x = 0;
		this.y = -64;
		
		this.image = new Bitmap(new BitmapData(Math.round(bridgePos), riverBreadth, false, 0x0000FF));
		this.image2 = new Bitmap(new BitmapData(Lib.current.stage.stageWidth, riverBreadth, false, 0x0000FF));
		image2.x = bridgePos + bridgeWidth;
		addChild(image2);
		addChild(image);
	}
	
	public override function checkCollision():Void 
	{
		if (this.y < Main.player.y)
			{
				if (this.image.hitTestObject(Main.player))
				{
					Main.player.explode();
				}
				
				else if(this.image2.hitTestObject(Main.player))
				{
					Main.player.explode();
				}
			}
	}
}