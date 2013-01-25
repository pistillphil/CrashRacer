package powerups;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Sprite;

/**
 * ...
 * @author pistillphil
 */

class PowerUp extends Sprite
{
	public var image:Bitmap;

	public function new(posX:Float, posY:Float,image:BitmapData,scale:Float) 
	{
		super();
		
		this.x = posX;
		this.y = posY;
		this.scaleX = scale;
		this.scaleY = scale;
		this.image = new Bitmap(image);
		
		
		addChild(this.image);
		checkObstacleCollision();
	}
	
	private function checkObstacleCollision():Void 
	{
		for (obs in Main.obstacleManager.obstacles) 
		{
			if (this.hitTestObject(obs))
			{
				this.y -= 256;
			}
			
		}
		
	}
	
}