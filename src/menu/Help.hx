package menu;
import nme.display.Sprite;
import nme.Assets;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.Lib;

/**
 * ...
 * @author pistillphil
 */

class Help extends Sprite
{
	private var font:Font;
	private var text:TextField;
	private var format:TextFormat;
	private var fontSize:Int;
	private var color:Int;

	public function new() 
	{
		super();
		
		this.fontSize = 24;
		this.color = 0xFFFFFF;
		
		this.font = Assets.getFont("fonts/aesymatt.ttf");
		text = new TextField();
		text.width = Lib.current.stage.stageWidth;
		text.height = Lib.current.stage.stageHeight;
		text.text = Assets.getText("img/help.txt");
		text.embedFonts = true;
		
		format = new TextFormat (font.fontName, this.fontSize, this.color);
		
		text.setTextFormat(format);
		
		addChild(text);
	}
	
}