package
{
	public class Ship extends MovieClip
	{
		private var parts:Vector<Part>;

		public function Ship(_rootPart:Part)
		{
			super();
			parts.push(_rootPart);
		}

		public function update():void
		{
			//This logic won't really work...
			for each(var part:Part in parts)
			{
				part.update();
			}
		}
	}
}