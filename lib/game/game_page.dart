import 'dart:async';
import 'package:brick_breaker/game/ball.dart';
import 'package:brick_breaker/game/wall.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/forge2d_game.dart';

class GamePage extends Forge2DGame with TapCallbacks {
  Ball? _ball;
  bool isStarted = false;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    SpriteComponent background = SpriteComponent(
      sprite: await Sprite.load('game_background.png'),
      size: Vector2(10.8, 19.2),
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    add(background);

    world.gravity = Vector2(0, 0);

    _ball = Ball(initialPosition: Vector2(0, -1.5));
    add(_ball!);

    Wall rightWall = Wall(
      startPosition: Vector2(4.5, 7.4),
      endPosition: Vector2(4.5, -7.4),
    );
    add(rightWall);

    Wall leftWall = Wall(
      startPosition: Vector2(-4.5, 7.4),
      endPosition: Vector2(-4.5, -7.4),
    );

    add(leftWall);

    Wall bottomWall = Wall(
      startPosition: Vector2(-4.5, 7.4),
      endPosition: Vector2(4.5, 7.4),
    );

    add(bottomWall);

    Wall topWall = Wall(
      startPosition: Vector2(-4.5, -7.4),
      endPosition: Vector2(4.5, -7.4),
    );

    add(topWall);
  }

  @override
  void onTapDown(_) {
    if (isStarted == false) {
      Vector2 normalized = Vector2(1, 1).normalized();
      _ball?.body.applyLinearImpulse(normalized * 2);
      isStarted = true;
    }
  }
}
