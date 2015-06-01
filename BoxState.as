package jungle
{
	
	import Box2D.Collision.Shapes.b2CircleShape;
	import Box2D.Collision.Shapes.b2PolygonShape;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2FixtureDef;
	import Box2D.Dynamics.b2World;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.events.Event;
	
	/**
	 * @author Aymeric
	 */
	public class BoxState extends Sprite
	{
		
		/* from boxEX*/
		
		private var mMainMenu:Sprite;
		private var bodyDef:b2BodyDef;
		private var inc:int;
		public var m_world:b2World;
		public var m_velocityIterations:int = 10;
		public var m_positionIterations:int = 10;
		public var m_timeStep:Number = 1.0 / 30.0;
		
		private var world:b2World;
		private var worldScale:Number = 30;
		
		public function BoxState()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void
		{
			// Define the gravity vector
			var gravity:b2Vec2 = new b2Vec2(20.0, 0.0);
			// Allow bodies to sleep
			var doSleep:Boolean = true;
			// Construct a world object
			m_world = new b2World(gravity, doSleep);
			var body:b2Body;
			var boxShape:b2PolygonShape;
			var circleShape:b2CircleShape;
			
			// Add ground body
			bodyDef = new b2BodyDef();
			bodyDef.position.Set(200, 19);
			
//bodyDef.angle = 0.1;
			boxShape = new b2PolygonShape();
			boxShape.SetAsBox(0, 0);
			var fixtureDef:b2FixtureDef = new b2FixtureDef();
			fixtureDef.shape = boxShape;
			fixtureDef.friction = 0.3;
// static bodies require zero density
			fixtureDef.density = 80;
		// Add sprite to body userData
			var box:Quad = new Quad(200, 200, 0xCCCCCC);
			box.x = 400; //bodyDef.position.x;
			box.y = 400; //bodyDef.position.y;
			box.pivotX = box.width / 2.0;
			box.pivotY = box.height / 2.0;
			bodyDef.userData = box;
		/*	bodyDef.userData.width = 34 * 2 * 30;
			bodyDef.userData.height = 30 * 2 * 3;
			*/
			body = m_world.CreateBody(bodyDef); 
			body.CreateFixture(fixtureDef);
			
			addChild(bodyDef.userData);
			addChild(box);
			addEventListener(Event.ENTER_FRAME, updateWorld);
		
		}
		
		private function updateWorld(e:Event):void
		{
			m_world.Step(1 / 30, 10, 10);
			m_world.ClearForces();
			m_world.DrawDebugData();
		
		}
	
	}
}
