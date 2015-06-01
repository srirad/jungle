package jungle
{
	/**
	 * ...
	 * @author srini
	 */
	
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import starling.text.TextField;
	import starling.display.DisplayObject;
	
	public class Game extends Sprite
	{
		private var q:Quad;
		private var s:Sprite;
		
		public function Game()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			q = new Quad(200, 200);
		
			q.color = 0x00FF00;

			q.x = 1280 >> 1 - 100;
			
		//	addChild(q);
			
			s = new Sprite();
			var legend:TextField = new TextField(100, 20, "Hello Starling!", "Arial", 14, 0xFF0000);
		
			
			s.addChild(q);
			s.addChild(legend);
			s.pivotX = s.width >> 1;
			s.pivotY = s.height >> 1;
		//	s.x = (stage.stageWidth - s.width >> 1) + (s.width >> 1);
		//	s.y = (stage.stageHeight - s.height >> 1) + (s.height >> 1);
			addChild(s);
			
			s.addEventListener(Event.ENTER_FRAME, onFrame);
			
			s.x = 752 >> 1 - 200 >> 1;
			s.y = 752 >> 1 - 200>>1;
		
		}
		
		private function onFrame(e:Event):void
		{
		/*	r -= (r - rDest) * .01;
			g -= (g - gDest) * .01;
			b -= (b - bDest) * .01;*/
		//	var color:uint = r << 16 | g << 8 | b;
			//q.color = color;
// when reaching the color, pick another one
		//	if (Math.abs(r - rDest) < 1 && Math.abs(g - gDest) < 1 && Math.abs(b - bDest))
			//	resetColors();
			(e.currentTarget as DisplayObject).rotation += .01;
		}
	}
}