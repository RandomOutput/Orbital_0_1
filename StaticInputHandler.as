package
{
	public class StaticInputHandler
	{
		//keyboard flags
		private var iKey:Boolean = false;
		private var oKey:Boolean = false;
		private var kKey:Boolean = false;
		private var lKey:Boolean = false;
		private var uKey:Boolean = false;
		private var jKey:Boolean = false;

		public function StaticInputHandler()
		{

		}

		private function onKeyDown(e:KeyboardEvent):void
		{	
			//trace("charCode: " + e.charCode);
			
			switch(e.charCode)
			{
				case 105:
					iKey = true;
					break;
				case 111:
					oKey = true;
					break;
				case 107:
					kKey = true;
					break;
				case 108:
					lKey = true;
					break;
				case 117:
					uKey = true;
					break;
				case 106:
					jKey = true;
					break;
				default:
					break;					
			}
		}

		private function onKeyUp(e:KeyboardEvent):void
		{
			switch(e.charCode)
			{
				case 105:
					iKey = false;
					break;
				case 111:
					oKey = false;
					break;
				case 107:
					kKey = false;
					break;
				case 108:
					lKey = false;
					break;
				case 117:
					uKey = false;
					break;
				case 106:
					jKey = false;
					break;
				default:
					break;					
			}
		}
	}
}