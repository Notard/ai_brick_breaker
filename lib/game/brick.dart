import 'package:brick_breaker/component/event_bus.dart';
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class Brick extends BodyComponent {
  final Vector2 centerPosition;
  final Vector2 brickSize;

  Brick({
    required this.centerPosition,
    required this.brickSize,
  });

  @override
  Body createBody() {
    PolygonShape shape = PolygonShape();
    // brickSize보다 조금 작은 크기로 설정
    Vector2 calcedSize = brickSize.clone();
    calcedSize.sub(Vector2(0.1, 0.1));
    shape.setAsBoxXY(calcedSize.x / 2, calcedSize.y / 2);

    FixtureDef fixtureDef = FixtureDef(shape);
    fixtureDef.restitution = 0.0;
    fixtureDef.friction = 0.0;

    BodyDef bodyDef = BodyDef();
    bodyDef.type = BodyType.static; // 벽돌은 움직이지 않음
    bodyDef.position = Vector2(centerPosition.x, centerPosition.y);

    Body body = game.world.createBody(bodyDef);
    body.createFixture(fixtureDef);
    body.userData = this;

    addSprite(fileName: 'brick.png', spirteSize: calcedSize);

    return body;
  }

  void addSprite(
      {required String fileName, required Vector2 spirteSize}) async {
    Vector2 componentPosition = Vector2(0, 0)..sub(spirteSize / 2);
    SpriteComponent brickComponent = SpriteComponent();
    brickComponent.sprite = await Sprite.load('brick.png');

    brickComponent.size = spirteSize;
    brickComponent.position = componentPosition;
    brickComponent.anchor = Anchor.topLeft;

    add(brickComponent);
  }

  void collision() {
    EventBus().publish(brickCollisionEvent, position);
    removeFromParent();
  }
}
