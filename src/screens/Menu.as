package screens 
{
	import managers.SoundManager;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	/**
	 * ...
	 * @author LeleoSan
	 */
	public class Menu extends Sprite
	{
		/** parameters */
		private var callBack:Function;
		/** objects */
		private var btnPlay:Button;
		private var particle:PDParticleSystem;
		
		public function Menu(_callBack:Function) 
		{
			callBack = _callBack;
			
			addChild(new Image(Root.assets.getTexture("bg")));
			addChild(new Image(Root.assets.getTexture("effectMenu")));
			addChild(new Image(Root.assets.getTextureAtlas("spriteAll").getTexture("logoMax.png")));
			
			btnPlay = new Button(Root.assets.getTextureAtlas("spriteAll").getTexture("btnPlay.png"));
			btnPlay.alignPivot();
			btnPlay.x = Main.SIZE.x * 0.5;
			btnPlay.y = 545;
			addChild(btnPlay);
			
			particle = new PDParticleSystem(Root.assets.getXml("particleMenu"), Root.assets.getTexture("particleMenu"));
			particle.x = 10;
			particle.y = 350;
			addChild(particle);
			Starling.juggler.add(particle);
			particle.start();
			
			events("add");
		}
		private function getClick(e:Event):void
		{
			SoundManager.play(SoundManager.FX_CLICK_MENU, 0, SoundManager.C_EFFECTS);
			destroy();
			callBack();
		}
		private function events(_type:String):void
		{
			btnPlay[_type+"EventListener"](Event.TRIGGERED, getClick);
		}
		public function destroy():void
		{
			events("remove");
			removeChildren(0, -1, true);
			removeFromParent(true);
		}
	}

}