﻿package{	import flash.display.MovieClip;	import flash.display.Sprite;	import flash.events.Event;	import flash.events.KeyboardEvent;	import Box2D.Dynamics.*;	import Box2D.Collision.*;	import Box2D.Collision.Shapes.*;	import Box2D.Dynamics.Joints.*;	import Box2D.Dynamics.Contacts.*;	import Box2D.Common.Math.*;	import StaticConfigHandler;	import StaticInputHandler;		public class Main extends MovieClip	{		private var world:b2World;		private var timestep:Number;		private var iterations:uint;		var shipBody:b2Body;		var dock_body:b2Body;		var ship:CSM;		var debugPort:MovieClip;		var debugPin:MovieClip;		var ships:Vector<Ship>; 		public function Main()		{			super();			makeWorld();			makeWalls();			makeDebugDraw();			if(stage) init();			else addEventListener(Event.ADDED_TO_STAGE, init);		}		private function makeWorld():void		{			//define gravity			var gravity:b2Vec2 = new b2Vec2(0.0, 0.0);			//Allow bodies to sleep			var doSleep:Boolean = true;			//Construct a world;			world = new b2World(gravity, doSleep);			world.SetWarmStarting(true);			timestep = 1.0 / 30.0;			iterations = 10;		}		private function makeWalls():void		{			var wall:b2PolygonShape = new b2PolygonShape();			var wallBd:b2BodyDef = new b2BodyDef();			var wallB:b2Body;			//Left			wallBd.position.Set( -95 / pixelsPerMeter, 400 / pixelsPerMeter / 2);			wall.SetAsBox(100/pixelsPerMeter, 400/pixelsPerMeter/2);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture2(wall);			// Right			wallBd.position.Set((640 + 95) / pixelsPerMeter, 400 / pixelsPerMeter / 2);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture2(wall);			// Top			wallBd.position.Set(640 / pixelsPerMeter / 2, -95 / pixelsPerMeter);			wall.SetAsBox(680/pixelsPerMeter/2, 100/pixelsPerMeter);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture2(wall);			// Bottom			wallBd.position.Set(640 / pixelsPerMeter / 2, (400 + 95) / pixelsPerMeter);			wallB = world.CreateBody(wallBd);			wallB.CreateFixture2(wall);		}		private function makeDebugDraw():void		{			var debugDraw:b2DebugDraw = new b2DebugDraw();			var debugSprite:Sprite = new Sprite();			addChild(debugSprite);			debugDraw.SetSprite(debugSprite);			debugDraw.SetDrawScale(30.0);			debugDraw.SetFillAlpha(0.3);			debugDraw.SetLineThickness(1.0);			debugDraw.SetFlags(b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit);			world.SetDebugDraw(debugDraw);		}		private function init(e:Event = null):void		{			removeEventListener(Event.ADDED_TO_STAGE, init);			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);						LEFT_VEC.Multiply(FORCE_MULT);			RIGHT_VEC.Multiply(FORCE_MULT);			UP_VEC.Multiply(FORCE_MULT);			DOWN_VEC.Multiply(FORCE_MULT);						createShip();			createDockingPort();			createDebugPoints();			addEventListener(Event.ENTER_FRAME, update);			ship = new CSM();			stage.addChild(ship);			ship.alpha = 0.5;		}		private function createDebugPoints():void		{			debugPort = new DebugPoint();			debugPin = new DebugPoint();			stage.addChild(debugPort);			stage.addChild(debugPin);		}		private function createShip():void		{			var shipBd:b2BodyDef;			var fd:b2FixtureDef;			var boxDef:b2PolygonShape = new b2PolygonShape();			shipBd = new b2BodyDef();			shipBd.type = b2Body.b2_dynamicBody;			fd = new b2FixtureDef();			fd.shape = boxDef;			fd.density = 1;			fd.friction = 0.5;			fd.restitution = 0.1;			boxDef.SetAsBox(41 / 2 / pixelsPerMeter, 100 / 2 / pixelsPerMeter);			shipBd.position.Set(320 / pixelsPerMeter, 240 / pixelsPerMeter);			shipBody = world.CreateBody(shipBd);			shipBody.CreateFixture(fd);		}		private function createDockingPort():void		{			var bd_dock:b2BodyDef = new b2BodyDef();			bd_dock.type = b2Body.b2_staticBody;			bd_dock.position.Set(100 / pixelsPerMeter, 50 / pixelsPerMeter);						var boxDef:b2PolygonShape = new b2PolygonShape();			boxDef.SetAsBox(50/2/pixelsPerMeter, 50/2/pixelsPerMeter);			var fd_dock:b2FixtureDef = new b2FixtureDef();			fd_dock.shape = boxDef;			fd_dock.density = 1;			fd_dock.friction = 0.5;			fd_dock.restitution = 0.1;						dock_body = world.CreateBody(bd_dock);			dock_body.CreateFixture(fd_dock);					}		private function makeABunchOfDynamicBodies():void		{			var i:int			var body:b2Body;			var fd:b2FixtureDef;			//Add rectangles			for (i = 0; i < 5; i++){				var bodyDef:b2BodyDef = new b2BodyDef();				bodyDef.type = b2Body.b2_dynamicBody;				var boxDef:b2PolygonShape = new b2PolygonShape();				fd = new b2FixtureDef();				fd.shape = boxDef;				fd.density = 1.0;				// Override the default friction.				fd.friction = 0.3;				fd.restitution = 0.1;				boxDef.SetAsBox((Math.random() * 5 + 10) / pixelsPerMeter, (Math.random() * 5 + 10) / pixelsPerMeter);				bodyDef.position.Set((Math.random() * 400 + 120) / pixelsPerMeter, (Math.random() * 150 + 50) / pixelsPerMeter);				bodyDef.angle = Math.random() * Math.PI;				body = world.CreateBody(bodyDef);				body.CreateFixture(fd);			}			// Add Circles			for (i = 0; i < 5; i++){				var bodyDefC:b2BodyDef = new b2BodyDef();				bodyDefC.type = b2Body.b2_dynamicBody;				var circDef:b2CircleShape= new b2CircleShape((Math.random() * 5 + 10) / pixelsPerMeter);				fd = new b2FixtureDef();				fd.shape = circDef;				fd.density = 1.0;				// Override the default friction.				fd.friction = 0.3;				fd.restitution = 0.1;				bodyDefC.position.Set((Math.random() * 400 + 120) / pixelsPerMeter, (Math.random() * 150 + 50) / pixelsPerMeter);				bodyDefC.angle = Math.random() * Math.PI;				body = world.CreateBody(bodyDefC);				body.CreateFixture(fd);			}			// Add irregular convex polygons			for (i = 0; i < 15; i++){				var bodyDefP:b2BodyDef = new b2BodyDef();				bodyDefP.type = b2Body.b2_dynamicBody;				var polyDef:b2PolygonShape = new b2PolygonShape();				// Draw a polygon point by point				if (Math.random() > 0.66) {					polyDef.SetAsArray([						new b2Vec2((-10 -Math.random()*10) / pixelsPerMeter, ( 10 +Math.random()*10) / pixelsPerMeter),						new b2Vec2(( -5 -Math.random()*10) / pixelsPerMeter, (-10 -Math.random()*10) / pixelsPerMeter),						new b2Vec2((  5 +Math.random()*10) / pixelsPerMeter, (-10 -Math.random()*10) / pixelsPerMeter),						new b2Vec2(( 10 +Math.random() * 10) / pixelsPerMeter, ( 10 +Math.random() * 10) / pixelsPerMeter)						]);				}				else if (Math.random() > 0.5)				{					var array:Array = [];					array[0] = new b2Vec2(0, (10 +Math.random()*10) / pixelsPerMeter);					array[2] = new b2Vec2((-5 -Math.random()*10) / pixelsPerMeter, (-10 -Math.random()*10) / pixelsPerMeter);					array[3] = new b2Vec2(( 5 +Math.random()*10) / pixelsPerMeter, (-10 -Math.random()*10) / pixelsPerMeter);					array[1] = new b2Vec2((array[0].x + array[2].x), (array[0].y + array[2].y));					array[1].Multiply(Math.random()/2+0.8);					array[4] = new b2Vec2((array[3].x + array[0].x), (array[3].y + array[0].y));					array[4].Multiply(Math.random() / 2 + 0.8);					polyDef.SetAsArray(array);				}				else				{					polyDef.SetAsArray([						new b2Vec2(0, (10 +Math.random()*10) / pixelsPerMeter),						new b2Vec2((-5 -Math.random()*10) / pixelsPerMeter, (-10 -Math.random()*10) / pixelsPerMeter),						new b2Vec2(( 5 +Math.random() * 10) / pixelsPerMeter, ( -10 -Math.random() * 10) / pixelsPerMeter)					]);				}				fd = new b2FixtureDef();				fd.shape = polyDef;				fd.density = 1.0;				fd.friction = 0.3;				fd.restitution = 0.1;				bodyDefP.position.Set((Math.random() * 400 + 120) / pixelsPerMeter, (Math.random() * 150 + 50) / pixelsPerMeter);				bodyDefP.angle = Math.random() * Math.PI;				body = world.CreateBody(bodyDefP);				body.CreateFixture(fd);			}		}		private function update(e:Event = null):void		{			if(iKey) shipBody.ApplyForce(shipBody.GetWorldVector(RIGHT_VEC), shipBody.GetWorldPoint(new b2Vec2(-1,-1)));			if(oKey) shipBody.ApplyForce(shipBody.GetWorldVector(LEFT_VEC), shipBody.GetWorldPoint(new b2Vec2( 1,-1)));			if(kKey) shipBody.ApplyForce(shipBody.GetWorldVector(RIGHT_VEC), shipBody.GetWorldPoint(new b2Vec2(-1, 1)));			if(lKey) shipBody.ApplyForce(shipBody.GetWorldVector(LEFT_VEC), shipBody.GetWorldPoint(new b2Vec2( 1, 1)));			if(uKey) shipBody.ApplyForce(shipBody.GetWorldVector(DOWN_VEC), shipBody.GetWorldPoint(new b2Vec2( 0, 0)));			if(jKey) shipBody.ApplyForce(shipBody.GetWorldVector(UP_VEC), shipBody.GetWorldPoint(new b2Vec2( 0, 0)));			world.Step(timestep, iterations, iterations);			checkDocking();			updateShipAsset();			updateDebugPoints();			world.ClearForces();			world.DrawDebugData();		}				private function checkDocking():void		{			//docking port b2Vec2			var dockingPort:b2Vec2 = dock_body.GetWorldPoint(new b2Vec2(.8,0));						//docking pin b2Vec2			var dockingPin:b2Vec2 = shipBody.GetWorldPoint(new b2Vec2(0,-1.65));			//distance			var dist:Number = Math.sqrt(Math.pow(dockingPort.x - dockingPin.x, 2) + Math.pow(dockingPort.y - dockingPin.y, 2));			dist = dist * pixelsPerMeter;						//relative angle			var relAngle:Number = Math.abs(dock_body.GetAngle() - shipBody.GetAngle());			relAngle = relAngle * ( 180 / Math.PI );			relAngle -= 90;						trace("dist: " + dist);			trace("relAngle: " + relAngle);			//if distance and angle good			if(dist < 3 && relAngle < 5 && relAngle > -5)			{				//create joint & lock				var revoluteJointDef:b2RevoluteJointDef = new  b2RevoluteJointDef();				revoluteJointDef.Initialize(dock_body, shipBody, dockingPin);				 				revoluteJointDef.maxMotorTorque = 1.0;				revoluteJointDef.enableMotor = true;				 				world.CreateJoint(revoluteJointDef);				dock_body.SetType(2);			}		}		private function updateShipAsset():void		{			ship.x = shipBody.GetPosition().x * pixelsPerMeter;			ship.y = shipBody.GetPosition().y * pixelsPerMeter;			ship.rotation = shipBody.GetAngle() * ( 180 / Math.PI );			//trace("angle: " + shipBody.GetAngle());		}		private function updateDebugPoints():void		{			debugPort.x = dock_body.GetWorldPoint(new b2Vec2(.8,0)).x * pixelsPerMeter;			debugPort.y = dock_body.GetWorldPoint(new b2Vec2(.8,0)).y * pixelsPerMeter;						trace("port: " + debugPort.x + ", " + debugPort.y);			debugPin.x = shipBody.GetWorldPoint(new b2Vec2(0, -1.65)).x * pixelsPerMeter;			debugPin.y = shipBody.GetWorldPoint(new b2Vec2(0, -1.65)).y * pixelsPerMeter;						trace("pin: " + debugPin.x, ", " + debugPin.y);						//debugPin.x = 320;			//debugPin.y = 110;					}	}}