package obstacle;
import nme.display.BitmapData;
import nme.geom.Rectangle;
import nme.display.Bitmap;
import obstacle.AbstractObstacle;

/**
 * ...
 * @author pistillphil
 */

class Rock extends AbstractObstacle
{

	public function new(posX:Float, posY:Float, image:BitmapData) 
	{
		super();
		
		this.x = posX;
		this.y = posY;
		
		this.image = new Bitmap(image);
		this.image.scaleX = 0.1;
		this.image.scaleY = 0.1;
		addChild(this.image);
		
		//testing hitboxes
		/*
		var temp:Rectangle = image.getBounds(this);
		graphics.beginFill(0x000000);
		graphics.drawRect(temp.left, temp.top, temp.width, temp.height);
		graphics.endFill();
		*/
		
	}
	
	
}