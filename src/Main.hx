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

/**
 * ...
 * @author pistillphil
 */

class Main extends Sprite 
{
	private var player:Player;
	private var obstacleManager:ObstacleManager;
	
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
		player = new Player(cast(Lib.current.stage.stageWidth/2 - 32,Int), cast(Lib.current.stage.stageHeight - 128, Int));
		addChild(player);
		obstacleManager = new ObstacleManager();
		addChild(obstacleManager);
		addEventListener(Event.ENTER_FRAME, update);
	}
	
	private function update(event:Event):Void 
	{
		setChildIndex(player, this.numChildren -1);
		player.update(event);
		obstacleManager.update(event);
		//trace(Lib.current.stage.numChildren);
	}
	

	
	static public function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = nme.display.StageScaleMode.NO_SCALE;
		stage.align = nme.display.StageAlign.TOP_LEFT;
		
		Lib.current.addChild(new Main());
	}
	
}
