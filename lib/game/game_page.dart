import 'dart:async';
import 'package:brick_breaker/component/event_bus.dart';
import 'package:brick_breaker/game/ball.dart';
import 'package:brick_breaker/game/brick_manager.dart';
import 'package:brick_breaker/game/game_contact_listener.dart';
import 'package:brick_breaker/game/paddle.dart';
import 'package:brick_breaker/game/particle_manager.dart';
import 'package:brick_breaker/game/wall.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class GamePage extends Forge2DGame with TapCallbacks {
  GamePage() : super(contactListener: GameContactListener());
  Ball? _ball;
  Paddle? _paddle;
  bool isStarted = false;
  int ballCount = 3;
  int brickCount = 0;

  final int rows = 5;
  final int columns = 10;
  final Vector2 brickSize = Vector2(0.8, 0.3);
  final Vector2 startPosition = Vector2(-4.1, -6.0);

  ParticleManager? _particleManager;

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

    Wall topWall = Wall(
      startPosition: Vector2(-4.5, -7.4),
      endPosition: Vector2(4.5, -7.4),
    );

    add(topWall);

    _paddle = Paddle();
    add(_paddle!);

    BrickManager brickManager = BrickManager(
      game: this,
      rows: rows,
      columns: columns,
      brickSize: brickSize,
      startPosition: startPosition,
    );
    add(brickManager);
    brickCount = rows * columns;

    _particleManager = ParticleManager();
    add(_particleManager!);

    EventBus().subscribe(ballOutEvent, (_) {
      ballCount--;
      if (ballCount == 0) {
        //게임 오버
        EventBus().publish(gameClearEvent, false);
        removeFromParent();
      } else {
        _ball = Ball(initialPosition: Vector2(0, -1.5));
        add(_ball!);
        isStarted = false;
      }
    });

    EventBus().subscribe(brickCollisionEvent, (Vector2 position) {
      brickCount--;
      _particleManager?.createParticleEffect(
        position: position,
        particleSize: 0.05,
        lifespan: 1,
      );
      if (brickCount == 0) {
        // 모든 벽돌이 파괴됨 - 게임 클리어
        EventBus().publish(gameClearEvent, true);
        removeFromParent();
      }
    });
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (isStarted == false) {
      Vector2 normalized = Vector2(1, 1).normalized();
      _ball?.body.applyLinearImpulse(normalized);
      isStarted = true;
    } else {
      _paddle?.update(0);
    }
  }
}
