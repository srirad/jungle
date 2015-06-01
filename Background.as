package jungle
{
	import citrus.sounds.groups.BGMGroup;
	import starling.display.Sprite;
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import flash.ui.Keyboard;
	import citrus.physics.box2d.Box2D;
	import citrus.objects.platformer.box2d.Platform;
	
	public class Background extends Sprite
	{
		private var bg:Image;
		private var bg1:Image;
		
		private var cloud:Image;
		private var cloud1:Image;
		
		public var speed:Number = 5;
		public var parallax:Number = 15;
		private var platform:Platform;
		
		public function Background()
		{
			
			addEventListener(starling.events.Event.ADDED_TO_STAGE, addstage);
		}
		
		private function addstage(event:Event):void
		{
			
			/*	var box2D:Box2D = new Box2D("box2D");
			   box2D.visible = true;
			   add(box2D);
			 */
			
			bg = new Image(GetAssets.getTexture("bg"));
			bg1 = new Image(GetAssets.getTexture("bg"));
			bg.x = 0;
			
			bg1.x = bg.x + bg.width;
			bg.y = stage.stageHeight - bg.height;
			bg1.y = stage.stageHeight - bg.height;
			this.addChild(bg);
			this.addChild(bg1);
			
			cloud = new Image(GetAssets.getTexture("cloud"));
			
			cloud.x = Math.random() * (stage.stageWidth - 50) + 50;
			cloud.y = Math.random() * 200;
			trace("cloud position", cloud.x, ",", cloud.y);
			this.addChild(cloud);
			
			cloud1 = new Image(cloud.texture);
			cloud1.x = Math.random() * (stage.stageWidth - 50) + 50;
			cloud1.y = Math.random() * 200;
			
			trace("cloud position", cloud.x, ",", cloud.y);
			this.addChild(cloud);
			this.addChild(cloud1);
			
			/*	platform = new Platform("cloud", { x:350, y:stage.stageHeight, width:700 } );
			   add(platform);
			 */
			this.addEventListener(starling.events.Event.ENTER_FRAME, enterframe);
		}
		
		private function enterframe(e:EnterFrameEvent):void
		{
			bg.x -= 50 * e.passedTime;
			bg1.x -= 50 * e.passedTime;
			cloud.x -= 250 * e.passedTime;
			cloud1.x -= 300 * e.passedTime;
			
			if (cloud.x <= -cloud.width)
			{
				cloud.x = stage.stageWidth;
				cloud.y = Math.random() * 200;
			}
			
			if (cloud1.x <= -cloud1.width)
			{
				cloud1.x = stage.stageWidth;
				cloud1.y = Math.random() * 200;
			}
			
			if (bg.x <= -bg.width)
			{
				bg.x = bg1.x + bg1.width;
				
			}
			if (bg1.x <= -bg1.width)
			{
				
				bg1.x = bg.x + bg.width;
			}
		}
		
		public function initialize():void
		{
			this.visible = true;
		}
	}

}