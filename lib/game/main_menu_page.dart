import 'package:brick_breaker/component/event_bus.dart';
import 'package:brick_breaker/component/game_function.dart';
import 'package:brick_breaker/component/game_rect_button.dart';
import 'package:brick_breaker/component/paint_text_component.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class MainMenuPage extends PositionComponent {
  SpriteComponent? titleSprite;

  @override
  Future<void> onLoad() async {
    titleSprite = SpriteComponent(
      sprite: await Sprite.load('main_menu.png'),
      position: Vector2(0, 0),
      anchor: Anchor.center,
      size: Vector2(1080, 1920),
    );
    add(titleSprite!);
    PaintTextComponent titleText = await makeMainText();
    titleText.position = Vector2(0, -240);

    add(titleText);

    GameRectButton startButton = GameRectButton(
      spriteFileName: 'brick_button.png',
      buttonSize: Vector2(400, 200),
      textComponent: TextComponent(
        text: '게임 시작',
        anchor: Anchor.center,
        textRenderer: TextPaint(
          style: GameFunction().getTextStyle(
            fontSize: 70,
            color: Colors.indigo,
          ),
        ),
      ),
      onTapUpEvent: () {
        removeFromParent();
        EventBus().publish('gamePageEvent', null);
        // EventBus를 통해 게임 페이지로 이동
      },
    );
    startButton.position = Vector2(0, 200);
    add(startButton);
  }

  Future<PaintTextComponent> makeMainText() async {
    return PaintTextComponent(
      position: Vector2(0, 230),
      text: '벽돌 깨기 게임',
      style: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
        fontSize: 126,
        fontFamily: '온글잎 은별',
        shadows: [
          Shadow(
            color: Colors.black,
            offset: Offset(2, 2),
            blurRadius: 10,
          ),
        ],
      ),
      anchor: Anchor.center,
    );
  }
}
