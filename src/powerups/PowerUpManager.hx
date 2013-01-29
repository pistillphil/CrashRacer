package powerups;
import nme.display.Bitmap;
import nme.display.Sprite;
import nme.Assets;
import nme.events.Event;
import nme.Lib;
import nme.media.Sound;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.ui.Keyboard;

import obstacle.AbstractObstacle;

/**
 * ...
 * @author pistillphil
 */

class PowerUpManager extends Sprite
{
	public var powerUps:Array<PowerUp>;
	private var powerUpsToBeRemoved:Array<PowerUp>;
	private var star:Bitmap;
	private var create:Bool;
	
	private var min:Int;
	private var max:Int;
	private var counter:Int;
	private var wait:Float;
	
	private var powerUpScale:Float;
	
	private var invincibilityDuration:Int;
	private var currentDuration:Int;
	
	private var collectSound:Sound;
	private var useSound:Sound;

	public function new() 
	{
		super();
		
		this.create = false;
		this.min = 100;
		this.max = 155;
		this.counter = 60;
		this.wait = 120;
		this.invincibilityDuration = 180;
		
		
		powerUps = new Array<PowerUp>();
		star = new Bitmap(Assets.getBitmapData("img/star.png"));
		collectSound = Assets.getSound("sounds/pup.wav");
		useSound = Assets.getSound("sounds/pup2.wav");
		powerUpScale = 0.1;
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, usePowerUp);
	}
	
	public function update(event:Event):Void 
	{
		checkCollision();
		checkCreate();
		move();
		checkInvincibility();
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
		var temp:PowerUp = new PowerUp(Math.random() * (Lib.current.stage.stageWidth -32), -32, star.bitmapData, powerUpScale);
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
		}
	}
	
	private function checkCollision():Void 
	{
		powerUpsToBeRemoved = new Array<PowerUp>();
		
		for (pup in powerUps)
		{
			if (pup.image.hitTestObject(Main.player))
			{
				powerUpsToBeRemoved.push(pup);
				Main.hud.addPowerUp();
				collectSound.play();
			}
		}
		
		for (pup in powerUpsToBeRemoved)
		{
			powerUps.remove(pup);
			Lib.current.stage.removeChild(pup);
		}
		
		powerUpsToBeRemoved = null;
		
	}
	
	private function usePowerUp(event:KeyboardEvent):Void 
	{
		if (event.keyCode == Keyboard.SPACE && Main.hud.getNumPowerUps() != 0 && Main.active)
		{
			Main.hud.clearPowerUp();
			useSound.play();
			Main.invincible = true;
			Main.player.alpha = 0.4;
			currentDuration = 0;
		}
	}
	
	private function checkInvincibility():Void 
	{
		if (Main.invincible == true)
		{
			if (currentDuration > invincibilityDuration)
			{
				Main.invincible = false;
				Main.player.alpha = 1;
			}
			
			else
			{
				currentDuration++;
			}
		
		}
	
	}
}