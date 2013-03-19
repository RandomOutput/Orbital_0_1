package
{
	private class Part extends MovieClip
	{
		var body_part:b2Body;
		var partVisual:MovieClip;
		var partType:String;

		public function Part(_partType:String = "")
		{
			super();
			partType = _partType;
			init();
		}

		public function init():void
		{
			var BD_part:b2BodyDef = new b2BodyDef();
			var FD_part:b2FixtureDef = new b2FixtureDef();
			var boxDef:b2PolygonShape = new b2PolygonShape();

			switch(partType)
			{
				case "playerShip":
					//TODO: PLayer Ship
					break;
				default:
					//Physics
					BD_part.type = b2Body.b2_dynamicBody;
					FD_part.shape = boxDef;
					FD_part.density = 1;
					FD_part.friction = 0.5;
					FD_part.restitution = 0.1;
					boxDef.SetAsBox(41 / 2 / pixelsPerMeter, 100 / 2 / pixelsPerMeter);
					body_part.position.Set(320 / pixelsPerMeter, 240 / pixelsPerMeter);
					body_part = world.CreateBody(BD_part);
					body_part.CreateFixture(FD_part);

					//Visuals
					partVisual = new CSM();
					this.addChild(partVisual);
					partVisual.alpha = 0.5;
					update();
					break;
			}
		}

		public function update():void
		{
			partVisual.x = body_part.GetPosition().x * pixelsPerMeter;
			partVisual.y = body_part.GetPosition().y * pixelsPerMeter;
			partVisual.rotation = body_part.GetAngle() * ( 180 / Math.PI );
		}
	}
}