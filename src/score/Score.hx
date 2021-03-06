package score;
import nme.display.Sprite;
import nme.text.Font;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import nme.Lib;
import nme.Assets;

/**
 * ...
 * @author pistillphil
 */

class Score extends Sprite
{
	private var font:Font;
	
	private var score:Float;
	private var scoreText:TextField;
	private var scoreFormat:TextFormat;
	
	private var fontSize:Int = 30;
	private var color:Int;
	
	private var scoreRate:Float;
	private var defaultScoreRate:Float;

	public function new() 
	{
		super();
		
		this.fontSize = 30;
		this.color = 0x050505;
		
		this.score = 0;
		
		this.x = fontSize;
		this.y = 0;
		
		font = Assets.getFont("fonts/aesymatt.ttf");
		scoreText = new TextField();
		scoreText.y = Lib.current.stage.stageHeight - (fontSize*2);
		scoreText.width = 500;
		scoreText.selectable = false;
		scoreText.text = "Score: " + Std.string(Math.floor(score));
		
		
		scoreFormat = new TextFormat (font.fontName, this.fontSize, this.color);
		scoreFormat.align = TextFormatAlign.LEFT;
		
		scoreText.setTextFormat (scoreFormat);
		scoreText.embedFonts = true;
		
		addChild(scoreText);
	}
	
	public function addScoreBy(add:Float)
	{
		score += add;
		scoreText.text = "Score: " + Std.string(Math.floor(score));
		scoreText.setTextFormat (scoreFormat);
	}
	
	public function addScore():Void 
	{
		addScoreBy(scoreRate + (Main.hud.getNumPowerUps() * 0.01));
		//trace(scoreRate + (Main.hud.getNumPowerUps() * 0.01));
		
		/*if (score % 75 == 0)
		{
			scoreRate *= 2;
			Main.obstacleManager.changeFrequencyBy( -5, -5);
		}*/
	}
	
	public function setScoreRate(rate:Float):Void 
	{
		scoreRate = rate;
		defaultScoreRate = rate;
	}
	/*
	public function changeScoreRateBy(rate:Float):Void 
	{
		scoreRate + rate;
	}
	
	public function resetScoreRate():Void 
	{
		scoreRate = defaultScoreRate;
	}*/
	
}