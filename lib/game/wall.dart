import 'package:flame_forge2d/flame_forge2d.dart';

class Wall extends BodyComponent {
  final Vector2 startPosition;
  final Vector2 endPosition;

  Wall({
    required this.startPosition,
    required this.endPosition,
  });

  @override
  Body createBody() {
    EdgeShape shape = EdgeShape();

    shape.set(startPosition, endPosition);

    FixtureDef fixtureDef = FixtureDef(shape);
    fixtureDef.restitution = 1.0; // 반발력
    fixtureDef.friction = 0.0;

    BodyDef bodyDef = BodyDef();
    bodyDef.type = BodyType.static;
    bodyDef.position = Vector2.zero();
    Body body = world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    return body;
  }
}
