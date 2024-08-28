import 'package:brick_breaker/component/rounded_rectangle_component.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class GameRectButton extends PositionComponent with TapCallbacks {
  GameRectButton({
    required this.spriteFileName,
    required this.buttonSize,
    required this.textComponent,
    this.onTapDownEvent,
    this.onTapUpEvent,
  });

  NineTileBoxComponent? nineTileBoxComponent;
  final String spriteFileName;
  final Vector2 buttonSize;
  final TextComponent textComponent;
  final Function? onTapDownEvent;
  final Function? onTapUpEvent;
  RoundedRectangleComponent? overlay;

  @override
  Future<void> onLoad() async {
    Sprite sprite = await Sprite.load(spriteFileName);
    NineTileBox nineTileBox = NineTileBox(
      sprite,
    );
    nineTileBoxComponent = NineTileBoxComponent(
      nineTileBox: nineTileBox,
      size: buttonSize,
      anchor: Anchor.center,
    );
    nineTileBoxComponent!.position = Vector2(
      buttonSize.x / 2,
      buttonSize.y / 2,
    );

    add(nineTileBoxComponent!);

    overlay = RoundedRectangleComponent(
      borderRadius: 80,
      color: Colors.grey,
      size: buttonSize,
      anchor: Anchor.center,
    );
    overlay?.position = Vector2(
      buttonSize.x / 2,
      buttonSize.y / 2,
    );
    overlay?.setTransparentColor(0);

    add(overlay!);

    textComponent.position = Vector2(
      buttonSize.x / 2,
      buttonSize.y / 2,
    );
    add(textComponent);
    size = buttonSize;
    anchor = Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) {
    super.onTapDown(event);
    if (onTapDownEvent != null) {
      onTapDownEvent!();
    }
    overlay?.setTransparentColor(0.7);

    event.handled = true;
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    overlay?.setTransparentColor(0);
    if (onTapUpEvent != null) {
      onTapUpEvent!();
    }
    event.handled = true;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    super.onTapCancel(event);
    overlay?.setTransparentColor(0);
  }
}
