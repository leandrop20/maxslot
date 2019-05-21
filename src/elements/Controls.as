package elements 
{
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	/**
	 * ...
	 * @author LeleoSan
	 */
	public class Controls extends Sprite
	{
		/** parameters */
		private var callBack:Function;
		/** consts */
		private const TYPE_BETS:Array = new Array("1", "10", "50", "100");
		
		public function Controls(_callBack:Function) 
		{
			callBack = _callBack;
			
			createBtn("Menu", -11, -8);
			createBtn("Clear", 21, 646);
			createBtn("Max", 126, 646);
			createBtn("Spin", 235, 644);
			for (var i:int = 0; i < 4; i++) {
				createBtn("Bet" + TYPE_BETS[i], (107 * i) + 20.3, 486);
			}
		}
		private function createBtn(_texture:String, _x:Number = 0, _y:Number = 0):Button
		{
			var btn:Button = new Button(Root.assets.getTextureAtlas("spriteAll").getTexture("btn" + _texture + ".png"));
			btn.name = _texture; btn.scaleWhenDown = 0.95; btn.x = _x; btn.y = _y;
			addChild(btn);
			return btn;
		}
		private function getTouch(e:TouchEvent):void
		{
			var touch:Touch = e.getTouch(this);
			if (touch) {
				if (touch.phase == TouchPhase.BEGAN) {
					callBack(touch.target.name);
				}
			}
		}
		public function events(_type:String):void
		{
			this[_type+"EventListener"](TouchEvent.TOUCH, getTouch);
		}
		public function destroy():void
		{
			events("remove");
			removeChildren(0, -1, true);
			removeFromParent(true);
		}
	}

}