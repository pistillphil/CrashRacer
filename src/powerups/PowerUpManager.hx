package powerups;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
import nme.Lib;

import obstacle.AbstractObstacle;

/**
 * ...
 * @author pistillphil
 */

class PowerUpManager extends Sprite
{
	public var powerUps:Array<PowerUp>;
	private var star:Bitmap;
	private var create:Bool = false;
	
	private var min:Int = 100;
	private var max:Int = 120;
	private var counter:Int = 60;
	private var wait:Float = 120;
	
	private var powerUpScale:Float;

	public function new() 
	{
		super();
		powerUps = new Array<PowerUp>();
		star = new Bitmap(Assets.getBitmapData("img/star.png"));
		powerUpScale = 0.1;
	}
	
	public function update(event:Event):Void 
	{
		checkCreate();
		move();
		checkRemove();
		
	}
	
	private function checkCreate():Void
	{
		if (create)
		{
			createPowerUp();
			counter = 0;
			wait = (Math.random() * max) + min;
			create = false;
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
	
	private function createPowerUp():Void 
	{
		var temp:PowerUp = new PowerUp(Math.random() * (Lib.current.stage.stageWidth -32), -64, star.bitmapData, powerUpScale);
		powerUps.push(temp);
		Lib.current.stage.addChild(temp);
		Lib.current.stage.setChildIndex(temp, 0);
	}
	
	private function checkRemove():Void 
	{
		for (pup in powerUps)
		{
			if (pup.y > Lib.current.stage.stageHeight)
			{
				Lib.current.stage.removeChild(pup);
				powerUps.remove(pup);
			}
		}
	}
	
	private function move():Void 
	{
		for (pup in powerUps)
		{
			pup.y += AbstractObstacle.speed;
			trace(pup.y);
		}
	}
	
}