package managers 
{
	import elements.Roulette;
	import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author LeleoSan
	 */
	public class RouletteManager extends Sprite
	{
		/** parameters */
		private var callBack:Function;
		/** statics */
		public static var values:Array = new Array();
		/** consts */
		private const SPEED:Number = 0.006;
		/** variables */
		private var timers:Array;
		private var currents:Array;
		
		public function RouletteManager() 
		{
			var _mask:Image = new Image(Root.assets.getTextureAtlas("spriteAll").getTexture("mask.png"));
			addChild(_mask);
			
			var roulette:Roulette;
			for (var i:int = 0; i < 3; i++) {
				roulette = new Roulette();
				roulette.name = "roulette" + i;
				roulette.x = (136 * i) + 90;
				roulette.y = (Main.SIZE.y * 0.5) + 500;
				roulette.mask = _mask;
				addChild(roulette);
			}
			updateValues();
			addChild(new Image(Root.assets.getTextureAtlas("spriteAll").getTexture("glass.png")));
			
			timers = new Array();
			var timer:DelayedCall;
			for (var k:int = 0; k < 3; k++) {
				timer = new DelayedCall(update, SPEED, [k, [], 0]);
				timers.push(timer);
			}
		}
		public function turning(_values:Array, _callBack:Function):void
		{
			callBack = _callBack;
			SoundManager.play(SoundManager.FX_TURNING, 0, SoundManager.C_EFFECTS);
			
			const TIMES:Array = new Array(210 + _values[0][1], 410 + _values[1][1], 610 + _values[2][1]);
			for (var i:int = 0; i < timers.length; i++) {
				currents = [0, 0, 0];
				DelayedCall(timers[i]).reset(update, SPEED, [i, _values, TIMES[i] - 10]);
				DelayedCall(timers[i]).repeatCount = TIMES[i];
				Starling.juggler.add(timers[i]);
			}
		}
		private function update(_id:int, _values:Array, time:int):void
		{
			updateMove(_id);
			var roulette:Roulette = Roulette(getChildByName("roulette" + _id));
			if (currents[_id] == time) {
					Starling.juggler.remove(timers[_id]);
					Starling.juggler.tween(roulette, 0.1, { y:roulette.y + 100, onComplete:function():void {
						SoundManager.play(SoundManager.FX_END_TURN, 0, SoundManager.C_EFFECTS);
						Starling.juggler.tween(roulette, 0.5, { y:roulette.y - 100, transition:Transitions.EASE_OUT_BACK, onComplete:last } );
				}} );
			} else {
				roulette.items[0].y += 10;
				last();
			}
			function last():void {
				currents[_id]++;
				if (_id == 2 && currents[_id] == time) {
					updateValues();
					callBack([_values[0][0], _values[1][0], _values[2][0]]);
				}
			}
		}
		private function updateMove(_idR:int):void
		{
			var roulette:Roulette = Roulette(getChildByName("roulette" + _idR));
			for (var i:int = 0; i < Roulette.TYPES.length - 1; i++) {
				roulette.items[i + 1].y = roulette.items[i].y - 100;
				if (roulette.items[0].y >= 100) {
					var firstObj:Image = roulette.items[0];
					roulette.items.shift();
					roulette.items.push(firstObj);
				}
			}
		}
		public function updateValues():void
		{
			var roulette:Roulette;
			for (var i:int = 0; i < 3; i++) {
				roulette = Roulette(getChildByName("roulette" + i));
				values.push([]);
				for (var j:int = 0; j < roulette.numChildren; j++) {
					values[i][j] = [roulette.getChildAt(j).name, roulette.getChildAt(j).y];
				}
			}
			RouletteManager.values = values;
		}
		public function destroy():void
		{
			removeChildren(0, -1, true);
			removeFromParent(true);
		}
	}

}