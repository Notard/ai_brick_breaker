import 'package:brick_breaker/game/brick.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class GameContactListener extends ContactListener {
  @override
  void beginContact(Contact contact) {
    // 충돌한 두 Fixture를 가져옵니다.
    final fixtureA = contact.fixtureA;
    final fixtureB = contact.fixtureB;

    // 각각의 Body의 userData를 가져옵니다.
    final bodyA = fixtureA.body;
    final bodyB = fixtureB.body;

    final brickA = bodyA.userData as Brick?;
    final brickB = bodyB.userData as Brick?;

    if (brickA != null || brickB != null) {
      // Brick과의 충돌이 발생했을 때 처리할 로직을 여기에 작성
      brickA?.collision();
      brickB?.collision();
    }
  }
}
