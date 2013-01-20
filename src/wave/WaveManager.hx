package wave;

import nme.Assets;
import haxe.Json;

import obstacle.AbstractObstacle;

/**
 * ...
 * @author pistillphil
 */

class WaveManager 
{
	private var waveCount:Int = 0;
	private var waveData:Dynamic;

	public function new(waveCount:Int) 
	{
		this.waveCount = waveCount;
	}
	
	public function loadWave():Void
	{

		var data:String = Assets.getText("waves/wave_" + waveCount + ".json");
		
		if (data == null)
		{
			trace("No such file: " + "waves/wave_" + waveCount + ".json");
		}
		else
		{
		waveData = Json.parse(data);
		
		Main.obstacleManager.setFrequency(waveData.minSpawnTime, waveData.maxSpawnTime);
		Main.obstacleManager.setNumRocks(waveData.numberOfRocks);
		AbstractObstacle.speed = waveData.driveSpeed;
		Main.score.setScoreRate(waveData.scoreRate);
		
		}
	}
	
	public function loadNextWave():Void 
	{
		waveCount++;
		loadWave();
	}
	
}