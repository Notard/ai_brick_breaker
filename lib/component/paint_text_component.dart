import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class PaintTextComponent extends PositionComponent with HasPaint {
  TextStyle style;
  String text;
  TextPainter? _painter;
  PaintTextComponent({
    required this.text,
    super.anchor,
    super.position,
    required this.style,
  }) {
    _painter = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: text,
        style: style,
      ),
    );
    _painter!.layout();

    size = Vector2(_painter!.width, _painter!.height);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    var bounds = Rect.fromLTWH(position.x, position.y, size.x, size.y);
    canvas.saveLayer(bounds, Paint()..blendMode = BlendMode.srcOver);
    _painter?.paint(canvas, position.toOffset());
    canvas.drawPaint(Paint()
      ..blendMode = BlendMode.modulate
      ..color = Colors.white.withOpacity(opacity));
    canvas.restore();
  }
}
