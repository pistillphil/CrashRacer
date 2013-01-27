package menu;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.Lib;
import nme.Assets;

/**
 * ...
 * @author pistillphil
 */

class Menu extends Sprite
{
	private var image:Bitmap;

	public function new() 
	{
		super();
		
		image = new Bitmap(Assets.getBitmapData("img/menu.png"));
		addChild(image);
		Lib.current.stage.addEventListener(MouseEvent.CLICK, handleClick);
		
	}
	
	function handleClick(event:MouseEvent):Void 
	{
		Lib.current.addChild(new Main());
		Lib.current.removeChild(this);
		Lib.current.stage.removeEventListener(MouseEvent.CLICK, handleClick);
	}
	
}