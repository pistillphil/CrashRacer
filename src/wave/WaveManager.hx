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
	private var waveCount:Int;
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
			trace("Will use last waveData for new wave!!!");
			waveCount--;	//Tells your which wave is the last
		}
		else
		{
		waveData = Json.parse(data);
		trace("Wave" + (waveCount + 1) +" active!");
		}
		Main.hud.setWaveCount(waveCount + 1);
		
		Main.obstacleManager.setFrequency(waveData.minSpawnTime, waveData.maxSpawnTime);
		Main.obstacleManager.setNumRocks(waveData.numberOfRocks);
		Main.obstacleManager.setRockScale(waveData.rockScale);
		Main.obstacleManager.setNumRivers(waveData.numberOfRivers);
		Main.obstacleManager.setBridgeWidth(waveData.bridgeWidthFactor);
		AbstractObstacle.speed = waveData.driveSpeed;
		Main.score.setScoreRate(waveData.scoreRate);
		
	}
	
	public function loadNextWave():Void 
	{
		waveCount++;
		loadWave();
	}
	
}