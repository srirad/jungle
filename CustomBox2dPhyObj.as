package jungle 
{
	
	import citrus.objects.Box2DPhysicsObject;
	/**
	 * ...
	 * @author srini
	 */
	public class CustomBox2dPhyObj extends extends Box2DPhysicsObject
	{
		public var segmentTexture:Texture;
		public function CustomBox2dPhyObj(name:String, params:Object = null) {
			
		//	updateCallEnabled = true;
		//	_preContactCallEnabled = true;
			
			super(name, params);
			
		//	onHang = new Signal();
			onHangEnd = new Signal();
			
	//		moveTimer = new Timer(50, 0);
		//	moveTimer.addEventListener(TimerEvent.TIMER, onMoveTimer);
		}
		
	}

}