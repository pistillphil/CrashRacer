package obstacle;

import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.Lib;
import nme.Assets;
/**
 * ...
 * @author pistillphil
 */

class River extends AbstractObstacle
{
	
	private var riverBreadth:Int;
	private var bridgePosition:Float;
	private var bridgeWidth:Float;
	
	private var image2:Bitmap;

	public function new(bridgePos:Float, bridgeWidth:Float) 
	{
		super();
		
		this.riverBreadth = 64;
		this.x = 0;
		this.y = -64;
		
		//this.image = new Bitmap(new BitmapData(Math.round(bridgePos), riverBreadth, false, 0x0000FF));
		this.image = new Bitmap(Assets.getBitmapData("img/Mountain.png"));
		this.image.x = bridgePos - image.bitmapData.width;
		//this.image2 = new Bitmap(new BitmapData(Lib.current.stage.stageWidth, riverBreadth, false, 0x0000FF));
		this.image2 = new Bitmap(Assets.getBitmapData("img/Mountain.png"));
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