import 'package:brick_breaker/component/event_bus.dart';
import 'package:brick_breaker/component/game_function.dart';
import 'package:brick_breaker/component/game_rect_button.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class GameClear extends PositionComponent {
  final bool isSuccess;
  GameClear({
    required this.isSuccess,
  }) : super(size: Vector2(1080, 1920));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    SpriteComponent background = SpriteComponent(
      sprite: await Sprite.load(isSuccess
          ? 'game_success_background.png'
          : 'game_over_background.png'),
      size: size,
      position: Vector2(0, 0),
      anchor: Anchor.center,
    );
    add(background);

    GameRectButton confirmButton = GameRectButton(
      spriteFileName: 'brick_button.png',
      buttonSize: Vector2(400, 140),
      textComponent: TextComponent(
        text: isSuccess ? '확인' : '다시하기',
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: GameFunction().getTextStyle(
            fontSize: 70,
            color: Colors.indigo,
          ),
        ),
      ),
      onTapDownEvent: () {
        EventBus().publish(
          isSuccess ? mainMenuEvent : gamePageEvent,
        );
      },
    );
    confirmButton.position = Vector2(0, 200);
    add(confirmButton);
  }
}
