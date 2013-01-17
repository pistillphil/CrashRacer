package score;
import nme.display.Sprite;
import nme.text.TextField;
import nme.text.TextFormat;
import nme.text.TextFormatAlign;
import nme.Lib;

/**
 * ...
 * @author pistillphil
 */

class Score extends Sprite
{
	private var score:Float;
	private var scoreText:TextField;
	private var scoreFormat:TextFormat;
	
	private var fontSize:Int = 30;
	private var color:Int = 0x050505;
	
	private var scoreRate:Float;

	public function new() 
	{
		super();
		
		this.score = 0;
		this.setScoreRate(0.1);
		
		this.x = fontSize;
		this.y = 0;
		
		scoreText = new TextField();
		scoreText.y = Lib.current.stage.stageHeight - (fontSize*2);
		scoreText.width = 500;
		scoreText.selectable = false;
		scoreText.text = "Score: " + Std.string(Math.floor(score));
		
		
		scoreFormat = new TextFormat ("_sans", this.fontSize, this.color);
		scoreFormat.align = TextFormatAlign.LEFT;
		
		scoreText.setTextFormat (scoreFormat);
		
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
		addScoreBy(scoreRate);
		
		if (score % 75 == 0)
		{
			scoreRate *= 2;
			Main.obstacleManager.changeFrequencyBy( -5, -5);
		}
	}
	
	public function setScoreRate(rate:Float):Void 
	{
		scoreRate = rate;
	}
	
}