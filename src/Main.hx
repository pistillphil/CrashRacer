package ;

import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.events.Event;
import nme.geom.Point;
import nme.Lib;
import obstacle.ObstacleManager;
import player.Player;
import nme.Assets;
import nme.events.KeyboardEvent;
import nme.ui.Keyboard;
import score.Score;
import wave.WaveManager;

/**
 * ...
 * @author pistillphil
 */

class Main extends Sprite 
{
	public static var player:Player;
	public static var score:Score;
	public static var active:Bool = true;
	public static var obstacleManager:ObstacleManager;
	public static var waveManager:WaveManager;
	
	private var initialWave:Int = 0;
	
	public function new() 
	{
		super();
		#if iphone
		Lib.current.stage.addEventListener(Event.RESIZE, init);
		#else
		addEventListener(Event.ADDED_TO_STAGE, init);
		#end
	}

	private function init(e) 
	{
		// entry point
		waveManager = new WaveManager(0);
		player = new Player(cast(Lib.current.stage.stageWidth/2 - 32,Int), cast(Lib.current.stage.stageHeight - 128, Int));
		addChild(player);
		score = new Score();
		addChild(score);
		obstacleManager = new ObstacleManager();
		addChild(obstacleManager);
		addEventListener(Event.ENTER_FRAME, update);
		waveManager.loadWave();
	}
	
	private function update(event:Event):Void 
	{
		if (active) 
		{	
			setChildIndex(player, this.numChildren -1);
			player.update(event);
			obstacleManager.update(event);
			score.addScore();
			//trace(Lib.current.stage.numChildren);
		}
		else
		{
			player.animateExplosion();
		}
	}
	
	

	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
	
}
