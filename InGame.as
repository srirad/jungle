package jungle
{
	import citrus.core.starling.StarlingState;
	import flash.utils.Timer;
	import jungle.JGameBackground;
	import citrus.physics.box2d.Box2D;
	import Box2D.Common.Math.b2Vec2;
	import citrus.objects.platformer.box2d.Platform;
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import starling.display.MovieClip;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import citrus.objects.platformer.box2d.Hero;
	import citrus.objects.platformer.box2d.Missile;
	import citrus.view.starlingview.AnimationSequence;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.Image;
	import flash.display.Bitmap;
	import citrus.objects.Box2DPhysicsObject;
	import flash.events.TimerEvent;
	import starling.events.TouchEvent;
	import starling.events.Touch;
	import starling.events.TouchPhase;
	import jungle.FireBullet;
	import citrus.objects.platformer.box2d.Enemy;
	
//import games.hungryhero.com.hsharma.hungryHero.gameElements.GameBackground;
	/**
	 * ...
	 * @author srini
	 */
	public class InGame extends StarlingState
	{
		
		private var bg:JGameBackground;
		private var _box2D:Box2D;
		private var floor:Platform;
		private var floor1:Platform;
		private var gravvec:b2Vec2;
		private var obstacle1:CitObj;
		private var obstacle2:CitObj;
		private var heroView:CitObj;
		private var enemyView:CitObj;
		private var hero:CustomHero;
		private var miss:MissileExtend;
		private var deerObj:Box2DPhysicsObject
		
		private var added:Boolean = false;
		//	private var chero:CusHero;
		
		private var worldScale:Number;
		
		[Embed(source="/../embed/Hero.xml",mimeType="application/octet-stream")]
		private var _heroConfig:Class;
		
		[Embed(source="/../embed/Hero.png")]
		private var _heroPng:Class;
		//private var boxObj
		
		[Embed(source="/../embed/games/tinywings/ball.png")]
		public static const HeroView:Class;
		
		public function InGame()
		{
			
			super();
		
			// Is hardware rendering?
			//		isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
			//		isHardwareRendering = Starling.context.driverInfo.toLowerCase().indexOf("software") == -1;
		
		}
		
		override public function initialize():void
		{
			
			super.initialize();
			
			_box2D = new Box2D("box2d");
		//	_box2D.visible = true;
			_box2D.gravity = new b2Vec2(0, 10);
			add(_box2D);
			worldScale = 30;
			
			drawGame();
			
			stage.addEventListener(TouchEvent.TOUCH, onTouch);
			
			var timer:Timer = new Timer(500);
			timer.addEventListener(TimerEvent.TIMER, timerEnemy);
			timer.start();
		}
		
		private function timerEnemy(e:TimerEvent):void
		{
			createFlyingDeer();
			
			var chance:Number = Math.random();
			
		//	if (chance < 0.10)
		//		createEnemy();
			//	trace("Times Fired: " + e.currentTarget.currentCount);
			//trace("Time Delayed: " + e.currentTarget.delay);
		}
		
		private function drawGame():void
		{
			// Draw background.
			bg = new JGameBackground();
			add(bg);
			bg.parallaxY = 20;
			createPlatform();
			
			//		createFlyingDeer();
			//	createObstacles();
			createHero();
			//	createEnemy();
			createEnemy();
			
			this.addEventListener(Event.ENTER_FRAME, onGameTick);
		}
		
		private function createCustomHeroBox(pX:Number, pY:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.userData = new Object();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(5 / worldScale, 20 / worldScale);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 0.1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			
			//	bodyDef.userData.view = new Image(GetAssets.getTexture("bg"));
			//	bodyDef.userData.
			/*	bodyDef.userData=new Object();
			   bodyDef.userData.name="floor";
			   bodyDef.userData.asset=new Floor();
			   addChild(bodyDef.userData.asset);
			 */
			
			var herotex:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("deer_"), 12);
			bodyDef.userData.asset = herotex;
			var theIdol:b2Body = _box2D.world.CreateBody(bodyDef);
			theIdol.CreateFixture(fixtureDef);
			
			var bW:Number = 5 / worldScale;
			var bH:Number = 20 / worldScale;
			var boxPos:b2Vec2 = new b2Vec2(0, 10 / worldScale);
			var boxAngle:Number = -Math.PI / 4;
			
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			//	fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
			boxAngle = Math.PI / 4;
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			//	fixtureDef.shape = polygonShape;
			//	theIdol.view = herotex;
			theIdol.CreateFixture(fixtureDef);
			//theIdol.set
		
		}
		
		private function createPlatform():void
		{
			floor = new Platform("FLOOR", {x: 0, y: stage.stageHeight - 20, width: stage.stageWidth, height: 40});
			add(floor);
			
			floor1 = new Platform("FLOOR1", {x: floor.x + floor.width, y: stage.stageHeight - 20, width: stage.stageWidth, height: 40});
			add(floor1);
		}
		
		private function createFlyingDeer():void
		{
			var herotex:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("bird_"), 8);
			herotex.scaleX = 0.5;
			herotex.scaleY = 0.5;
			
			/*   var deerObj:Box2DPhysicsObject = new Box2DPhysicsObject("deer", {x: 100, y: 100, width: herotex.width, height: herotex.height});
			   deerObj.view = herotex;
			   add(deerObj);
			 added = true;*/
			miss = new MissileExtend("missile", {x: stage.stageWidth, y: 10 + 200 * Math.random()});
			
			//		miss.view = herotex;
			//	miss.body.SetLinearVelocity(new b2Vec2(0,0)) ;
			//	var objDeer:FlyingDeer = new FlyingDeer("deer", {x: 100, y: 100, width: 100, height: 100, mass: 100});
			
			add(miss);
			//	miss.addEventListener(Event.ENTER_FRAME, onGameTick);
			//	miss.body.SetLinearVelocity(new b2Vec2(0,-10)) ;
			//	add(objDeer);
		}
		
		private function createObstacles():void
		{
			var obsTex1:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("deer_"), 12);
			
			obsTex1.scaleX = 0.5;
			obsTex1.scaleY = 0.5;
			
			obstacle1 = new CitObj("deer", {view: obsTex1});
			obstacle1.y = floor.y - (floor.height << 1);
			obstacle1.x = stage.stageWidth + 50;
		
		/*		var obsTex2:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("bird_"), 8);
		
		   obsTex2.scaleX = 0.35;
		   obsTex2.scaleY = 0.35;
		
		   obstacle2 = new CitObj("parrot", {view: obsTex2});
		   obstacle2.y = 100;
		   obstacle2.x = stage.stageWidth + 50;
		
		   add(obstacle1);
		 add(obstacle2);*/
		
		}
		
		private function createEnemy():void
		{
			
			var enemytex:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("goat_"), 10);
			
			enemytex.scaleX = -0.5;
			enemytex.scaleY = 0.5;
			
			var enemy:Enemy = new Enemy("enemy", {x: stage.stageWidth + 100, y: 300, width: 150, height: 110, mass: 20});
			
			add(enemy);
			enemy.offsetX = 150;
			
			enemy.offsetY = 10;
			enemy.view = enemytex;
			
			//	hero.body.SetLinearVelocity(new b2Vec2(0, 10));
			hero.body.ApplyImpulse(new b2Vec2(10, 0), hero.body.GetWorldCenter());
		
		}
		
		private function createHero():void
		{
			
			var herotex:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("deer"), 10);
			
			herotex.scaleX = -0.5;
			herotex.scaleY = 0.5;
			
			heroView = new CitObj("deer", {view: herotex});
			
			hero = new CustomHero("hero", {x: 300, y: 300, width: 150, height: 110, mass: 1000});
			
			add(hero);
			hero.offsetX = 150;
			hero.friction = 80;
			hero.jumpHeight = 12;
			hero.offsetY = 10;
			hero.view = herotex;
			hero.x = 200;
			//	hero.body.SetLinearVelocity(new b2Vec2(0, 10));
			hero.body.ApplyImpulse(new b2Vec2(10, 0), hero.body.GetWorldCenter());
		
		}
		
		private function createBricks():void
		{
			
			brick(275, 435, 30, 30);
			brick(365, 435, 30, 30);
			brick(320, 405, 120, 30);
			brick(320, 375, 60, 30);
			brick(305, 345, 90, 30);
			brick(320, 300, 120, 60);
		}
		
		// To create totem
		private function brick(pX:int, pY:int, w:Number, h:Number):void
		{
			
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(pX / 30, pY / 30);
			bodyDef.type = b2Body.b2_dynamicBody;
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(w / 2 / 30, h / 2 / 30);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 2;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			var theBrick:b2Body = _box2D.world.CreateBody(bodyDef);
			theBrick.CreateFixture(fixtureDef);
		}
		
		private function idol(pX:Number, pY:Number):void
		{
			var bodyDef:b2BodyDef = new b2BodyDef();
			bodyDef.position.Set(pX / worldScale, pY / worldScale);
			bodyDef.type = b2Body.b2_dynamicBody;
			bodyDef.userData.asset = new JGameBackground();
			
			var polygonShape:b2PolygonShape = new b2PolygonShape();
			polygonShape.SetAsBox(5 / worldScale, 20 / worldScale);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = polygonShape;
			fixtureDef.density = 0.1;
			fixtureDef.restitution = 0.4;
			fixtureDef.friction = 0.5;
			
			var theIdol:b2Body = _box2D.world.CreateBody(bodyDef);
			theIdol.CreateFixture(fixtureDef);
			
			var bW:Number = 5 / worldScale;
			var bH:Number = 20 / worldScale;
			var boxPos:b2Vec2 = new b2Vec2(0, 10 / worldScale);
			var boxAngle:Number = -Math.PI / 4;
			
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			//	fixtureDef.shape = polygonShape;
			theIdol.CreateFixture(fixtureDef);
			boxAngle = Math.PI / 4;
			polygonShape.SetAsOrientedBox(bW, bH, boxPos, boxAngle);
			//	fixtureDef.shape = polygonShape;
			
			theIdol.CreateFixture(fixtureDef);
			
			var herotex:MovieClip = new MovieClip(GetAssets.getAtlas().getTextures("deer_"), 12);
		
		}
		
		private function onTouch(e:TouchEvent):void
		{
			
			var touch:Touch = e.getTouch(stage) as Touch;
			if (touch && touch.phase == TouchPhase.ENDED)
			{
				trace("touch GLOBAL : ", touch.globalX);
				trace("Stage divided : ", stage.stageWidth >> 1);
				if (touch.globalX > stage.stageWidth >> 1)
				{
					//do something
					trace("Begin jump");
					hero.jumpNow();
				}
				else
				{
					var fireB:FireBullet = new FireBullet("FIRE", {x: hero.x + hero.width/2, y: hero.y - 20});
					add(fireB);
					
				}
			}
		}
		
		private function onGameTick(event:Event):void
		{
			if (obstacle1 != null)
			{
				obstacle1.x -= 5 * Math.random();
				if (obstacle1.x <= -stage.stageWidth / 2)
				{
					obstacle1.x = stage.stageWidth + 50;
					
				}
			}
			
			if (obstacle2 != null)
			{
				obstacle2.x -= 5;
				if (obstacle2.x <= -stage.stageWidth / 2)
				{
					obstacle2.x = stage.stageWidth + 50;
						//	miss.explode();
					
				}
			}
			
			if (floor1.x <= -stage.stageWidth / 2)
			{
				
				floor1.x = floor.x + stage.stageWidth;
			}
			
			var timeStep:Number = 1 / 30;
			var velIterations:int = 10;
			var posIterations:int = 10;
			var antiGravity:b2Vec2;
			
			/*	if (deerObj.body.GetUserData() != null)
			   {
			
			   antiGravity = new b2Vec2(0.0,-10.0*deerObj.body.GetMass());
			   deerObj.body.ApplyForce(antiGravity,deerObj.body.GetWorldCenter());
			
			
			 } */
			_box2D.world.Step(timeStep, velIterations, posIterations);
		
		}
	
	}

}