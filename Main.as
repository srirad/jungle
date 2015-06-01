package jungle
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import starling.core.Starling;
	[SWF(width="1280",height="752",frameRate="60",backgroundColor="#002143")]
	
	public class Main extends Sprite
	{
		private var mStarling:Starling;
		
		public function Main()
		{
		
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;

			mStarling = new Starling(SJungle, stage);
			mStarling.antiAliasing = 1;

			mStarling.start();
		}
	}
}