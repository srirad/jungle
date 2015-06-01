package jungle 
{
	import starling.display.Sprite;
	import starling.display.Image;
	/**
	 * ...
	 * @author srini
	 */
	public class SJungle extends Sprite
	{
		
		private var loginImg:Image;
		
		private var platform:Background;
		
		public function SJungle() 
		{
			platform = new Background();
			platform.y = 0;
			platform.x = 0;
			addChild(platform);
		//	platform.speed = 5;
		}
		
	}

}