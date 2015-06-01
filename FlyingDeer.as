package jungle
{
	/**
	 * ...
	 * @author srini
	 */
	
	import citrus.objects.Box2DPhysicsObject;
	import Box2D.Common.Math.b2Vec2;
	import starling.display.MovieClip;
	
	public class FlyingDeer extends Box2DPhysicsObject
	{
		
		private var mc:MovieClip; //keep a reference perhaps?
		
		public function FlyingDeer(name:String, params:Object = null)
		{
			updateCallEnabled = true;
			_beginContactCallEnabled = true;
			
			super(name, params);
			
			mc = new MovieClip(GetAssets.getAtlas().getTextures("deer_"), 12);
			mc.scaleX = 0.5;
			mc.scaleY = 0.5;
			view = mc;
			
		}
		
		override public function update(timeDelta:Number):void
		{
			super.update(timeDelta);
			
		var removeGravity:b2Vec2 = new b2Vec2();
			removeGravity.Subtract(_box2D.world.GetGravity());
			removeGravity.Multiply(body.GetMass());
			
			_body.ApplyForce(removeGravity, _body.GetWorldCenter());
			
			_body.SetLinearVelocity(new b2Vec2(0,0)); 
		
			
		}
		//stripped a lot of cool and useful/important functions
		//you may need later
	}
}