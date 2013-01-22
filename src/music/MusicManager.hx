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

	public function new() 
	{
		songs = new Array<Sound>();
		
		songs.push(Assets.getSound("music/song1.mp3"));
		songs.push(Assets.getSound("music/song2.mp3"));
		songs.push(Assets.getSound("music/song3.mp3"));
		songs.push(Assets.getSound("music/song4.mp3"));
		
		Lib.current.stage.addEventListener(KeyboardEvent.KEY_DOWN, checkMute);
		
		play();
		
	}
	
	public function play():Void
	{
		if (!isPlaying)
		{
			var ran = Math.floor(Math.random() * 3.99);
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