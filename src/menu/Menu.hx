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
	private var buttonStart:MenuButton;
	private var buttonHelp:MenuButton;
	
	private var buttonOffsetX:Float;
	private var buttonOffsetY:Float;

	public function new() 
	{
		super();
		
		this.buttonOffsetX = 64;
		this.buttonOffsetY = 145;
		
		image = new Bitmap(Assets.getBitmapData("img/menu.png"));
		buttonStart = new MenuButton("img/buttonStart.png");
		buttonStart.x = image.x + buttonOffsetX;
		buttonStart.y = image.height - buttonOffsetY;
		buttonHelp = new MenuButton("img/buttonHelp.png");
		buttonHelp.x = image.width - buttonHelp.width - buttonOffsetX;
		buttonHelp.y = image.height - buttonOffsetY;
		addChild(image);
		addChild(buttonStart);
		addChild(buttonHelp);
		buttonStart.addEventListener(MouseEvent.CLICK, handleStartClick);
		buttonHelp.addEventListener(MouseEvent.CLICK, handleHelpClick);
		
	}
	
	function handleStartClick(event:MouseEvent):Void 
	{
		Main.mainObj = new Main();
		Lib.current.addChild(Main.mainObj);
		Lib.current.removeChild(this);
		buttonStart.removeEventListener(MouseEvent.CLICK, handleStartClick);
	}
	
	function handleHelpClick(event:MouseEvent):Void 
	{
		trace("I will not help you");
	}
}