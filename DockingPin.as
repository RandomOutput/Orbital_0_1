package
{
	import Box2D.Dynamics.*;
	import Box2D.Collision.*;
	import Box2D.Collision.Shapes.*;
	import Box2D.Dynamics.Joints.*;
	import Box2D.Dynamics.Contacts.*;
	import Box2D.Common.Math.*;

	public class DockingPin
	{
		public var localCoords:b2Vec2;
		public var state:int = 0;

		public function DockingPin(_coords:b2Vec2)
		{
			localCoords = _coords;
		}
	}
}