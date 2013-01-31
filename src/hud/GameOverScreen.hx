package hud;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;
import nme.Lib;

/**
 * ...
 * @author pistillphil
 */

class GameOverScreen extends Sprite
{
	private var image:Bitmap;

	public function new() 
	{
		super();
		
		image = new Bitmap(Assets.getBitmapData("img/gameOver.png"));
		
		this.x = Lib.current.stage.stageWidth / 2 - image.width / 1.6;
		this.y = Lib.current.stage.stageHeight / 2 - image.height / 1.6;
		addChild(image);
	}
	
}