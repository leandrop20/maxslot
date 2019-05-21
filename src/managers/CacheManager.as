package managers 
{
	import flash.net.SharedObject;
	/**
	 * ...
	 * @author LeleoSan
	 */
	public class CacheManager 
	{
		/** objects */
		private var cash:SharedObject;
		private var time:SharedObject;
		private var achievs:SharedObject;
		
		public function CacheManager() 
		{
			cash = SharedObject.getLocal("cash");
			time = SharedObject.getLocal("time");
			achievs = SharedObject.getLocal("achievs");
		}
		public function saveCash(value:int):void
		{
			cash.data.cash = value;
			cash.flush();
		}
	}

}