package obstacle;
import nme.display.Bitmap;
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
	
	public var obstacles:List<AbstractObstacle>;
	
	private var min:Int;
	private var max:Int;
	
	private var numRocks:Int;
	private var rockImages:Array<BitmapData>;
	private var rockScale:Float;
	
	private var numRivers:Int;
	private var riverTimeCount:Int;
	private var riverTimeOut:Int;
	
	private var bridgeWidth:Float;
	
	public var backGround1:Bitmap;
	public var backGround2:Bitmap;

	public function new() 
	{
		super();
		
		
		this.riverTimeCount = 0;
		this.riverTimeOut = 60;
		
		this.x = 0;
		this.y = 0;
		
		backGround1 = new Bitmap(Assets.getBitmapData("img/Road.png"));
		backGround2 = new Bitmap(Assets.getBitmapData("img/Road.png"));
		
		backGround1.y = - (backGround1.bitmapData.height - Lib.current.stage.stageHeight);
		backGround2.y = - (backGround1.bitmapData.height - Lib.current.stage.stageHeight) - backGround2.bitmapData.height;
		
		Lib.current.stage.addChildAt(backGround1, 0);
		Lib.current.stage.addChildAt(backGround2, 0);
		
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
		checkWave();
		moveBackground();
		riverTimeCount++;
		
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
		else if ( riverTimeCount > riverTimeOut)
		{
			createRiver();
			riverTimeCount = 0;
		}
		else
		{
			createRock();
		}
		
		
	}
	
	private function createRock():Void
	{
		if (numRocks > 0)
		{
			var randomImage:Int = Math.round(Math.random() * (rockImages.length - 1));
			var temp:AbstractObstacle = new Rock(Math.random()* (Lib.current.stage.stageWidth -32), (-512 * rockScale), rockImages[randomImage],rockScale);
			obstacles.add(temp);
			addChild(temp);
			numRocks--;
		}
	}
	
	private function createRiver():Void 
	{
		if (numRivers > 0)
		{
			var temp:AbstractObstacle = new River(Math.random() * (Lib.current.stage.stageWidth - bridgeWidth), bridgeWidth );
			obstacles.add(temp);
			addChild(temp);
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
				removeChild(obs);
				obstacles.remove(obs);
			}
		}
	}
	
	private function checkCollision():Void
	{
		if (!Main.invincible)
		{
		
			for (obs in obstacles)
			{
				obs.checkCollision();
			}
		
		}
	}
	
	private function checkWave():Void 
	{
		if (numRocks + numRivers < 1 && numChildren < 1)
		{
			Main.waveManager.loadNextWave();
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
	
	public function setBridgeWidth(width:Float):Void 
	{
		this.bridgeWidth = width * Main.playerWidth;

	}
	
	private function moveBackground():Void 
	{
		backGround1.y += AbstractObstacle.speed;
		backGround2.y += AbstractObstacle.speed;
		
		if (backGround1.y >= Lib.current.stage.stageHeight)
		{
			backGround1.y =  (backGround2.y - backGround1.height);
		}
		
		if (backGround2.y >= Lib.current.stage.stageHeight)
		{
			backGround2.y =  (backGround1.y - backGround2.height);
		}
	}
	
}