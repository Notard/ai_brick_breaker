import 'package:brick_breaker/component/event_bus.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Paddle extends BodyComponent {
  @override
  Future<void> onLoad() {
    EventBus().subscribe(paddleMoveEvent, move);
    return super.onLoad();
  }

  @override
  void onRemove() {
    EventBus().unsubscribe(paddleMoveEvent, move);
    super.onRemove();
  }

  @override
  Body createBody() {
    PolygonShape shape = PolygonShape();
    shape.setAsBoxXY(1.5, 0.1);
    FixtureDef fixtureDef = FixtureDef(shape);
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.4;

    BodyDef bodyDef = BodyDef();
    bodyDef.type = BodyType.kinematic; // 사용자 조작에 따라 움직임
    bodyDef.position = Vector2(0, 6.5);
    Body body = game.world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }

  void move(double x) {
    // now position
    Vector2 nowPos = body.position;
    double paddleX = x + nowPos.x;
    paddleX /= 100;
    if (paddleX < -3 || paddleX > 3) {
      return;
    }
    body.setTransform(Vector2(paddleX, 6.5), 0);
  }
}
