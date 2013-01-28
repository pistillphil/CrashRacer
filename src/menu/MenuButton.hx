package menu;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;

/**
 * ...
 * @author pistillphil
 */

class MenuButton extends Sprite
{
	private var image:Bitmap;

	public function new(path:String) 
	{
		super();
		
		image = new Bitmap(Assets.getBitmapData(path));
		addChild(image);
		
	}
	
}