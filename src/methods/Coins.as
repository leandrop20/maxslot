package methods 
{
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.extensions.PDParticleSystem;
	/**
	 * ...
	 * @author LeleoSan
	 */
	public class Coins 
	{
		
		public static function to(_container:Sprite, _numParticles:int = 30, _duration:Number = 0.5, _callBack:Function = null):void
		{
			var particle:PDParticleSystem = new PDParticleSystem(Root.assets.getXml("particleCoins"), Root.assets.getTexture("particleCoins"));
			particle.x = Main.SIZE.x * 0.5
			particle.y = Main.SIZE.y;
			particle.emissionRate = _numParticles;
			_container.addChild(particle);
			if (!Starling.juggler.contains(particle)) {
				Starling.juggler.add(particle);
			}
			particle.start(_duration);
			Starling.juggler.delayCall(destroy, _duration + 1);
			function destroy():void
			{
				if (_callBack != null) {
					_callBack();
				}
			}
		}
		
	}

}