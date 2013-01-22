package obstacle;
import nme.display.DisplayObject;
import nme.display.Sprite;
import nme.events.Event;
import nme.Lib;
import nme.Vector;
import nme.display.BitmapData;
import nme.Assets;

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
	
	private var min:Int;
	private var max:Int;
	
	private var numRocks:Int;
	private var rockImages:Array<BitmapData>;
	private  var rockScale:Float;
	
	private var numRivers:Int;

	public function new() 
	{
		super();
		
		this.x = 0;
		this.y = 0;
		
		this.obstacles = new List<AbstractObstacle>();
		
		counter = 0;
		create = true;
		wait = 0;
		
		//Loads images
		rockImages = new Array<BitmapData>();
		rockImages.push(Assets.getBitmapData("img/a_0.png"));
		rockImages.push(Assets.getBitmapData("img/b_0.png"));
		rockImages.push(Assets.getBitmapData("img/c_0.png"));
	}
	
	public function update(event:Event):Void 
	{
		move();
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
			//trace(wait);
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
	
	private function createObstacle():Void 
	{
		var numObstacles:Int = numRocks + numRivers;
		var rand:Int = Math.round(Math.random() * numObstacles );
		
		if (rand < numRocks)
		{
			createRock();
		}
		else if (true)	//placeholder, will be changed when more kinds of obstacles are implemented
		{
			createRiver();
		}
		
	}
	
	private function createRock():Void
	{
		if (numRocks > 0)
		{
			var randomImage:Int = Math.round(Math.random() * (rockImages.length - 1));
			var temp:AbstractObstacle = new Rock(Math.random()* (Lib.current.stage.stageWidth -32), -64, rockImages[randomImage],rockScale);
			obstacles.add(temp);
			Lib.current.stage.addChild(temp);
			Lib.current.stage.setChildIndex(temp, 0);
			numRocks--;
		}
	}
	
	private function createRiver():Void 
	{
		if (numRivers > 0)
		{
			var temp:AbstractObstacle = new River(Math.random() * (Lib.current.stage.stageWidth -128) + 64 );
			obstacles.add(temp);
			Lib.current.stage.addChild(temp);
			Lib.current.stage.setChildIndex(temp, 1);
			numRivers--;
		}
		
	}
	
	private function move()
	{
		for (obs in obstacles)
		{
			obs.y += AbstractObstacle.speed;
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
			obs.checkCollision();
		}
	}
	
	public function changeFrequencyBy(min:Int, max:Int)
	{
		this.min += min;
		this.max += max;
		
	}
	
	public function setFrequency(min:Int, max:Int)
	{
		this.min = min;
		this.max = max;
	}
	
	public function setNumRocks(rocks:Int):Void 
	{
		this.numRocks = rocks;
	}
	
	public function setRockScale(scale:Float):Void
	{
		this.rockScale = scale;
	}
	
	public function setNumRivers(rivers:Int):Void
	{
		this.numRivers = rivers;
	}
	
}