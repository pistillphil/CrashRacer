package music;
import nme.media.Sound;
import nme.Assets;
import nme.media.SoundChannel;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.ui.Keyboard;
import nme.Lib;

/**
 * ...
 * @author pistillphil
 */

class MusicManager 
{
	private var songs:Array<Sound>;
	private var channel:SoundChannel;
	private var currentSong:Sound;
	private var isPlaying:Bool;
	private var songCount:Int;

	public function new() 
	{
		
		this.songCount = 4;
		this.songs = new Array<Sound>();
		
		for (i in 1...songCount+1)
		{
			songs.push(Assets.getSound("music/song" + i + ".mp3"));
		}
		
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, checkMute);
		
		play();
		
	}
	
	public function play():Void
	{
		if (!isPlaying)
		{
			var ran = Math.floor(Math.random() * (songs.length -0.01));
			currentSong = songs[ran];
			channel = currentSong.play();
			channel.addEventListener(Event.SOUND_COMPLETE, handleStoppedSong);
			isPlaying = true;
		}
	}
	
	 public function stop():Void
        {
            if(isPlaying)
            {
                channel.stop();
                isPlaying = false;
            }
        }
	
	private function handleStoppedSong(ev:Event):Void
        {
            isPlaying = false;
			this.play();
        }
		
	private function checkMute(event:KeyboardEvent):Void
		{
			if (event.keyCode == Keyboard.M)
			{
				if (isPlaying)
				{
					this.stop();
				}
				else
				{
					this.play();
				}
			}
		}
	
}