package obstacle;
import nme.geom.Rectangle;
import nme.display.Bitmap;
import obstacle.AbstractObstacle;

import nme.Assets;

/**
 * ...
 * @author pistillphil
 */

class Rock extends AbstractObstacle
{

	public function new(posX:Float, posY:Float) 
	{
		super();
		
		this.x = posX;
		this.y = posY;
		
		image = new Bitmap(Assets.getBitmapData("img/a_0.png"));
		image.scaleX = 0.1;
		image.scaleY = 0.1;
		addChild(image);
		
		//testing hitboxes
		/*
		var temp:Rectangle = image.getBounds(this);
		graphics.beginFill(0x000000);
		graphics.drawRect(temp.left, temp.top, temp.width, temp.height);
		graphics.endFill();
		*/
		
	}
	
	
}