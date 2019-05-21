package elements 
{
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	/**
	 * ...
	 * @author LeleoSan
	 */
	public class Accumulated extends Sprite
	{
		/** objects */
		private var particle:PDParticleSystem;
		/** statics */
		public static var active:Boolean = false;
		public static var count:int = 0;
		/** consts */
		public const PAY:int = 4;
		
		public function Accumulated() 
		{
			Accumulated.active = false;
			Accumulated.count = 0;
			
			particle = new PDParticleSystem(Root.assets.getXml("accumulated"), Root.assets.getTexture("accumulated"));
			particle.x = Main.SIZE.x * 0.5;
			particle.y = 100;
			addChild(particle);
			Starling.juggler.add(particle);
		}
		public function setStatus(_active:Boolean):void
		{
			if (_active) {
				particle.start();
				Accumulated.active = true;
				Accumulated.count = 0;
			} else {
				Accumulated.count = 0;
				particle.stop();
				Accumulated.active = false;
			}
		}
		public function destroy():void
		{
			particle.stop();
			Starling.juggler.remove(particle);
			removeChildren(0, -1, true);
			removeFromParent(true);
		}
	}

}