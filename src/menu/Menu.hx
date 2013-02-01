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
	private var originalMenu:Bitmap;
	private var buttonStart:MenuButton;
	private var buttonHelp:MenuButton;
	private var buttonBack:MenuButton;
	
	private var buttonOffsetX:Float;
	private var buttonOffsetY:Float;
	
	private var help:Help;

	public function new() 
	{
		super();
		
		this.buttonOffsetX = 32;
		this.buttonOffsetY = 145;
		
		image = new Bitmap(Assets.getBitmapData("img/menu.png"));
		originalMenu = new Bitmap(Assets.getBitmapData("img/originalMenu.png"));
		buttonStart = new MenuButton("img/buttonStart.png");
		buttonStart.x = image.x + buttonOffsetX;
		buttonStart.y = image.height - buttonOffsetY;
		buttonHelp = new MenuButton("img/buttonHelp.png");
		buttonHelp.x = image.width - buttonHelp.width - buttonOffsetX;
		buttonHelp.y = image.height - buttonOffsetY;
		buttonBack = new MenuButton("img/buttonBack.png");
		buttonBack.x = image.width - buttonBack.width - buttonOffsetX;
		buttonBack.y = image.height - buttonOffsetY;
		addChild(image);
		addChild(buttonStart);
		addChild(buttonHelp);
		buttonStart.addEventListener(MouseEvent.CLICK, handleStartClick);
		buttonHelp.addEventListener(MouseEvent.CLICK, handleHelpClick);
		buttonBack.addEventListener(MouseEvent.CLICK, handleBackClick);
		
	}
	
	function handleStartClick(event:MouseEvent):Void 
	{
		Main.mainObj = new Main();
		Lib.current.addChild(Main.mainObj);
		Lib.current.removeChild(this);
		buttonStart.removeEventListener(MouseEvent.CLICK, handleStartClick);
		buttonHelp.removeEventListener(MouseEvent.CLICK, handleHelpClick);
		buttonBack.addEventListener(MouseEvent.CLICK, handleBackClick);
		help = null;
		image = null;
		originalMenu = null;
		buttonBack = null;
		buttonHelp = null;
		buttonStart = null;
	}
	
	function handleHelpClick(event:MouseEvent):Void 
	{
		help = new Help();
		removeChild(buttonStart);
		removeChild(buttonHelp);
		removeChild(image);
		addChild(originalMenu);
		addChild(help);
		addChild(buttonBack);
	}
	
	function handleBackClick(event:MouseEvent):Void 
	{
		removeChild(help);
		removeChild(buttonBack);
		removeChild(originalMenu);
		
		addChild(image);
		addChild(buttonStart);
		addChild(buttonHelp);
	}
}