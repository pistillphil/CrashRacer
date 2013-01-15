package player;
import enums.Enums;
import nme.display.Bitmap;
import nme.display.BitmapData;
import nme.display.Graphics;
import nme.display.Sprite;
import nme.display.Tilesheet;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;
import nme.Lib;
import nme.Assets;
import nme.events.MouseEvent;
import nme.events.KeyboardEvent;
import nme.media.Sound;
import nme.ui.Keyboard;
import nme.Vector;

/**
 * ...
 * @author pistillphil
 */

class Player extends Sprite
{

	private var speed:Float = 6;		//The speed the car moves Left or Right
	
	private var tiles:Tilesheet;			//Tilesheet containing all Images of the car
	private var sprites:Hash<Array<Float> >;//Holds all relevant images (according to direction)
	
	private var moveLeft:Bool = false;		//Does the car currently move left?
	private var moveRight:Bool = false;		//Does the car currently move left?
	
	private static var spriteWidth:Float;	//The width of the standard car sprite
	
	private var explosionTileSheet:Tilesheet;	//Tilesheet containing all frames  of the explosion
	private var tileCount:Int = 0;				//How many tiles are in the Tilesheet?
	public var explosionSound:Sound;			//Sounds is played when player explodes
	private var explsionAnimation:Array<Array<Float> >;	//The data for the tilesheet (position and framenum)
	public var explosion:Bool;				//Does the car (currently) explode?
	private var explosionFrames:Int	= 64;	//The amount of time the explosion animation should last
	private var tempFrames:Int;				//Helper for the explode() method
	private var frameCount:Int = 0;				//Which frame in the animation is currently displayed?

	//Constructor
	public function new(posX:Int, posY:Int) 
	{
	
		super();

		this.x = posX;
		this.y = posY;
		this.tiles = new Tilesheet(Assets.getBitmapData("img/wj_0.png"));
		this.sprites = new Hash<Array<Float> >();
		
		this.tiles.addTileRect(new Rectangle(138, 9, 36, 50));
		this.tiles.addTileRect(new Rectangle(64, 14, 59, 44));
		this.tiles.addTileRect(new Rectangle(188, 13, 62, 45));
		
		this.sprites.set(Enums.UP, [0, 0, 0]);
		this.sprites.set(Enums.LEFT, [-29/2, 0, 1]);
		this.sprites.set(Enums.RIGHT, [-30/2, 0, 2]);	
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, startMove);
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_UP, endMove);
		
		tiles.drawTiles(graphics, sprites.get(Enums.UP));
		spriteWidth = this.width;
		graphics.clear();
		
		createExplosion();
		
		
	}
	
	//Updates that have to be checked every frame
	public function update(event:Event):Void 
	{
		graphics.clear();
		scaleX = 1;
		scaleY = 1;

		if (moveLeft)
		{
			if (this.x > 0)
			{
				tiles.drawTiles(graphics, sprites.get(Enums.LEFT));
				this.x -= speed;
			}
			else
				moveLeft = false;
		}
		
		if (moveRight)
		{
			if (this.x < Lib.current.stage.stageWidth - spriteWidth)
			{
				tiles.drawTiles(graphics, sprites.get(Enums.RIGHT));
				this.x += speed;
			}
			else
				moveRight = false;
		}
		if((moveRight && moveLeft) || (!moveLeft && !moveRight))
		{
			graphics.clear();
			tiles.drawTiles(graphics, sprites.get(Enums.UP));
			this.scaleX = 0.9;
			this.scaleY = 0.9;
		}
		
		//testing hitboxes
		/*
		var temp:Rectangle = this.getBounds(this);
		graphics.beginFill(0x000000);
		graphics.drawRect(temp.left, temp.top, temp.width, temp.height);
		graphics.endFill();
		*/
		
	}
	
	//The mouse is clicked on the car
	private function onClick(e:MouseEvent):Void
	{

	}
	
	//A Key is down
	private function startMove(event:KeyboardEvent):Void 
	{
		if (event.keyCode == Keyboard.D)
		{
			moveRight = true;
		}
		if (event.keyCode == Keyboard.A)
		{
			moveLeft = true;
		}
		
	}
	
	//Key is up
	private function endMove(event:KeyboardEvent):Void
	{
		if (event.keyCode == Keyboard.D)
		{
			moveRight = false;
		}
		if (event.keyCode == Keyboard.A)
		{
			moveLeft = false;
		}
		
	}
	
	//Creates the graphics and process for the explosion
	private function createExplosion():Void
	{
		this.explosionTileSheet = new Tilesheet(Assets.getBitmapData("img/exp2.png"));
		explsionAnimation = new Array<Array<Float> >();
		explosionSound = Assets.getSound("sounds/exp.wav");
		explosion = false;
		var spriteSize = 63;
		var tilesPerRow = 4;
		
		for (i in 0...tilesPerRow)
		{
			for (j in 0...tilesPerRow)
			{
				explosionTileSheet.addTileRect(new Rectangle(j * spriteSize, i * spriteSize, spriteSize, spriteSize));
				explsionAnimation.push([ -5, -7, tileCount]);
				tileCount++;
			}	
		}
	}
	
	//The car explodes
	public function explode():Void
	{
		Main.active = false;
		explosion = true;
		explosionSound.play();
		
	}
	
	//Animates the explosion
	public function animateExplosion():Void
	{
		if (explosion)
		{
			if (tempFrames > 0)
			{
				tempFrames--;
			}
			else
			{
				frameCount++;
				tempFrames = cast(explosionFrames / tileCount, Int);
				
				
				if (frameCount >= tileCount)
				{
					explosion = false;
					frameCount = 0;
					return;
				}
				
			}
			graphics.clear();
			explosionTileSheet.drawTiles(graphics, explsionAnimation[frameCount]);
		}
	}
	
}