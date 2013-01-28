package hud;
import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import nme.Lib;

/**
 * ...
 * @author pistillphil
 */

class HUD extends Sprite
{
	
	private var numPowerUps:Int;
	private var waveCount:Int;
	
	private var hudText:TextField;
	private var hudWave:TextField;
	
	private var hudFormat:TextFormat;
	private var fontSize:Int = 30;
	private var color:Int = 0x050505;

	public function new() 
	{
		super();
		
		numPowerUps = 0;
		waveCount = 0;
		
		this.x = fontSize;
		this.y = 0;
		
		hudText = new TextField();
		hudText.y = Lib.current.stage.stageHeight - (fontSize*2);
		hudText.width = Lib.current.stage.stageWidth - 64;
		hudText.selectable = false;
		hudText.text = "Number of PowerUps: " + Std.string(numPowerUps);
		
		hudWave = new TextField();
		hudWave.y = 8;
		hudWave.width = Lib.current.stage.stageWidth - 64;
		hudWave.selectable = false;
		hudWave.text = "Wave: " + waveCount;
		
		
		hudFormat = new TextFormat ("_sans", this.fontSize, this.color);
		hudFormat.align = TextFormatAlign.RIGHT;
		
		hudText.setTextFormat(hudFormat);
		hudWave.setTextFormat(hudFormat);
		
		addChild(hudText);
		addChild(hudWave);
		
	}
	
	public function addPowerUp():Void 
	{
		numPowerUps++;
		
		hudText.text = "Number of PowerUps: " + Std.string(numPowerUps);
		hudText.setTextFormat(hudFormat);
	}
	
	public function clearPowerUp():Void 
	{
		numPowerUps = 0;
		
		hudText.text = "Number of PowerUps: " + Std.string(numPowerUps);
		hudText.setTextFormat(hudFormat);
	}
	
	public function setWaveCount(wave:Int):Void 
	{
		this.waveCount = wave;
		
		hudWave.text = "Wave: " + waveCount;
		hudWave.setTextFormat(hudFormat);
	}
	
	public function getNumPowerUps():Int 
	{
		return numPowerUps;
	}
	
}