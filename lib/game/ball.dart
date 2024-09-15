import 'package:brick_breaker/component/event_bus.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Ball extends BodyComponent {
  final Vector2 initialPosition;

  Ball({required this.initialPosition});

  @override
  Body createBody() {
    CircleShape shape = CircleShape();
    shape.radius = 0.15; // 공의 반지름 설정

    BodyDef bodyDef = BodyDef();
    bodyDef.position = initialPosition; // 공의 초기 위치 설정
    bodyDef.type = BodyType.dynamic; // 공은 동적인 객체

    FixtureDef fixtureDef = FixtureDef(shape);
    fixtureDef.restitution = 1.0; // 탄성 계수. 1이면 완전 탄성
    fixtureDef.friction = 0.0; // 마찰 계수. 0이면 마찰이 없음
    fixtureDef.density = 1.0; // 밀도
    Body body = game.world.createBody(bodyDef);
    body.createFixture(fixtureDef);

    return body;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (body.position.y > 7.4) {
      EventBus().publish(ballOutEvent);
      removeFromParent();
    }
  }
}
