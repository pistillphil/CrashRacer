package obstacle;
import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nme.Vector;

/**
 * ...
 * @author pistillphil
 */

class ObstacleManager extends Sprite
{
	private var counter:Int;
	private var create:Bool;
	private var wait:Float;
	
	private var obstacles:List<AbstractObstacle>;
	
	private static var min:Int = 60;
	private static var max:Int = 180;

	public function new() 
	{
		super();
		
		this.x = 0;
		this.y = 0;
		
		this.obstacles = new List<AbstractObstacle>();
		
		counter = 0;
		create = true;
		wait = 0;
	}
	
	public function update(event:Event):Void 
	{
		move();
		checkCollision();
		checkCollision();
		checkCreate();
		checkRemove();
		
	}
	
	private function checkCreate()
	{
		if (create)
		{
			createObstacle();
			counter = 0;
			wait = (Math.random() * max) + min;
			create = false;
			trace(wait);
		}
		else 
		{
			if (counter > wait)
			{
				create = true;
			}
			else
			{
				counter++;
			}
		}
		
	}
	
	private function createObstacle()
	{
		var temp:AbstractObstacle = new Rock(Math.random()*Lib.current.stage.stageWidth, -64);
		obstacles.add(temp);
		Lib.current.stage.addChild(temp);
		Lib.current.stage.setChildIndex(temp, 0);
	}
	
	private function move()
	{
		for (obs in obstacles)
		{
			obs.y += obs.speed;
		}
		
	}
	
	private function checkRemove():Void 
	{
		for (obs in obstacles)
		{
			if (obs.y > Lib.current.stage.stageHeight)
			{
				Lib.current.stage.removeChild(obs);
				obstacles.remove(obs);
			}
		}
	}
	
	private function checkCollision():Void
	{
		for (obs in obstacles)
		{
			if (obs.y < Main.player.y)
			{
				if (obs.image.hitTestObject(Main.player))
				{
					trace("bam");
				}
			}
		}
	}
	
}