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
import nme.ui.Keyboard;
import nme.Vector;

/**
 * ...
 * @author pistillphil
 */

class Player extends Sprite
{

	public static var speed:Float = 6;
	
	private var tiles:Tilesheet;
	private var sprites:Hash<Array<Float> >;
	
	public var moveLeft:Bool = false;
	public var moveRight:Bool = false;
	
	public static var spriteWidth:Float;

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
		
		
		
	}
	
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
	
	private function onClick(e:MouseEvent):Void
	{

	}
	
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
	
}