package ;

import hud.HUD;
import menu.Menu;
import music.MusicManager;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.events.Event;
import nme.events.MouseEvent;
import nme.geom.Point;
import nme.Lib;
import obstacle.ObstacleManager;
import player.Player;
import nme.Assets;
import nme.events.KeyboardEvent;
import nme.ui.Keyboard;
import powerups.PowerUpManager;
import score.Score;
import wave.WaveManager;
import obstacle.AbstractObstacle;

/**
 * ...
 * @author pistillphil
 */

class Main extends Sprite 
{
	public static var mainObj:Main;		//couldn't find another way to acces non-static methods in Main...
	public static var player:Player;
	public static var score:Score;
	public static var active:Bool;
	public static var invincible:Bool;
	public static var obstacleManager:ObstacleManager;
	public static var powerUpManager:PowerUpManager;
	public static var waveManager:WaveManager;
	public static var hud:HUD;
	public static var musicManager:MusicManager;
	public static var playerWidth:Int;
	
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
		
		active = true;
		invincible = false;
		playerWidth = 32;
		AbstractObstacle.speed = 10;
		
		waveManager = new WaveManager(0);
		musicManager = new MusicManager();
		player = new Player(cast(Lib.current.stage.stageWidth/2 - 32,Int), cast(Lib.current.stage.stageHeight - 128, Int));
		addChild(player);
		score = new Score();
		addChild(score);
		obstacleManager = new ObstacleManager();
		powerUpManager = new PowerUpManager();
		hud = new HUD();
		addChild(obstacleManager);
		addChild(powerUpManager);
		addChild(hud);
		addEventListener(Event.ENTER_FRAME, update);
		waveManager.loadWave();
	}
	
	private function update(event:Event):Void 
	{
		if (active) 
		{	
			//setChildIndex(player, this.numChildren -1);
			player.update(event);
			obstacleManager.update(event);
			powerUpManager.update(event);
			score.addScore();
			//trace(Lib.current.stage.numChildren);
		}
		else
		{
			player.animateExplosion();
		}
	}
	
	public function restart(event:MouseEvent):Void 
	{
		for (i in 0...Lib.current.stage.numChildren-1)
		{
			Lib.current.stage.removeChildAt(i);
		}
		
		this.removeChild(player);
		this.removeChild(score);
		this.removeChild(obstacleManager);
		this.removeChild(powerUpManager);
		this.removeChild(hud);
		
		
		active = true;
		invincible = false;
		playerWidth = 32;
		AbstractObstacle.speed = 10;
		
		waveManager = new WaveManager(0);
		musicManager = new MusicManager();
		player = new Player(cast(Lib.current.stage.stageWidth/2 - 32,Int), cast(Lib.current.stage.stageHeight - 128, Int));
		addChild(player);
		score = new Score();
		addChild(score);
		obstacleManager = new ObstacleManager();
		powerUpManager = new PowerUpManager();
		hud = new HUD();
		addChild(obstacleManager);
		addChild(powerUpManager);
		addChild(hud);
		addEventListener(Event.ENTER_FRAME, update);
		waveManager.loadWave();
	
	}
	
	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Menu());
	}
	
	
}
