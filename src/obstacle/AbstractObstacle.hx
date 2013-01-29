package obstacle;
import nme.display.Sprite;
import nme.display.Bitmap;

/**
 * ...
 * @author pistillphil
 */

class AbstractObstacle extends Sprite
{
	public var image:Bitmap;
	public static var speed:Int;

	public function new() 
	{
		super();
		
		
	}
	
	public function checkCollision():Void 
	{
		if (this.y < Main.player.y)
			{
				if (this.image.hitTestObject(Main.player))
				{
					Main.player.explode();
				}
			}
	}
	
}