import 'package:brick_breaker/component/event_bus.dart';
import 'package:brick_breaker/component/paint_text_component.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class TitlePage extends PositionComponent {
  SpriteComponent? titleSprite;

  @override
  Future<void> onLoad() async {
    titleSprite = SpriteComponent(
      sprite: await Sprite.load('title.png'),
      position: Vector2(0, 0),
      anchor: Anchor.center,
      size: Vector2(1080, 1920),
    );
    add(titleSprite!);
    PaintTextComponent titleText = await makeTitleText();
    titleText.position = Vector2(0, -340);

    titleText.opacity = 0;
    titleSprite!.opacity = 0;
    setFadeEffect(titleSprite!, true);
    setFadeEffect(titleText, false);

    add(titleText);
  }

  Future<PaintTextComponent> makeTitleText() async {
    return PaintTextComponent(
      position: Vector2(0, 230),
      text: '벽돌 깨기 게임',
      style: const TextStyle(
        color: Colors.white,
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

  void setFadeEffect(PositionComponent component, bool removeAfterFadeOut) {
    OpacityEffect fadeIn = OpacityEffect.to(
      1.0,
      EffectController(duration: 0.3),
    );

    OpacityEffect fadeOut = OpacityEffect.to(
      0.0,
      DelayedEffectController(
        delay: 0.1,
        EffectController(duration: 0.3),
      ),
    );
    SequenceEffect fadeInOutSequence = SequenceEffect([fadeIn, fadeOut]);
    component.add(fadeInOutSequence);
    fadeOut.onComplete = () {
      if (removeAfterFadeOut) {
        removeFromParent();
        EventBus().publish(mainMenuEvent, null);
      }
    };
  }
}
