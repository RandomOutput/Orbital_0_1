package
{
	public class StaticConfigHandler
	{
		public static const FORCE_MULT:int = 20;
		
		public static var LEFT_VEC:b2Vec2 	= 	new b2Vec2(-1, 0);
		public static var RIGHT_VEC:b2Vec2	= 	new b2Vec2( 1, 0);
		public static var UP_VEC:b2Vec2 	= 	new b2Vec2( 0,-1);
		public static var DOWN_VEC:b2Vec2 	= 	new b2Vec2( 0, 1);

		public static var pixelsPerMeter:Number = 30;

		public function StaticConfigHandler()
		{

		}
	}
}