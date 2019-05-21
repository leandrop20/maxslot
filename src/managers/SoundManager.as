package managers 
{
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author LeleoSan
	 */
	public class SoundManager 
	{
		/** objects */
		public static var channelEffects:SoundChannel = new SoundChannel();
		public static var channelVoices:SoundChannel = new SoundChannel();
		public static var channelMusics:SoundChannel = new SoundChannel();
		public static var transEffects:SoundTransform = new SoundTransform();
		public static var transVoices:SoundTransform = new SoundTransform();
		public static var transMusics:SoundTransform = new SoundTransform();
		/** consts */
		public static const C_EFFECTS:String = "channelEffects";
		public static const C_VOICES:String = "channelVoices";
		public static const C_MUSICS:String = "channelMusics";
		/** FXs */
		public static const FX_BET:String = "bet";
		public static const FX_CLICK_MENU:String = "clickMenu";
		public static const FX_END_TURN:String = "endTurn";
		public static const FX_JACKSPOT0:String = "jackpot";
		public static const FX_JACKSPOT1:String = "jackpot2";
		public static const FX_ACCUMULATED:String = "accumulated";
		public static const FX_LEVER:String = "lever";
		public static const FX_NOMONEY:String = "noMoney";
		public static const FX_PAY:String = "pay";
		public static const FX_TURNING:String = "turning";
		public static const FX_ADD_MONEY:String = "addMoney";
		/**
		 * 
		 * @param	_soundName
		 * @param	_type
		 */
		public static function initVolumes(_volEffects:Number = .5, _volVoices:Number = 1, _volMusics:Number = .5):void
		{
			SoundManager.transEffects.volume = _volEffects;
			SoundManager.transVoices.volume = _volVoices;
			SoundManager.transMusics.volume = _volMusics;
		}
		public static function play(_soundName:String, _loop:int = 0, _channel:String = SoundManager.C_MUSICS):void
		{
			if (_channel == SoundManager.C_MUSICS) {
				SoundManager.channelMusics.stop();
			}
			if (_channel == SoundManager.C_VOICES) {
				SoundManager.channelVoices.stop();
			}
			SoundManager[_channel] = Root.assets.playSound(_soundName,0, _loop);
			if (_channel == SoundManager.C_EFFECTS) {
				SoundManager[_channel].soundTransform = SoundManager.transEffects;
			} else if (_channel == SoundManager.C_VOICES) {
				SoundManager[_channel].soundTransform = SoundManager.transVoices;
			} else {
				SoundManager[_channel].soundTransform = SoundManager.transMusics;
			}
		}
	}

}