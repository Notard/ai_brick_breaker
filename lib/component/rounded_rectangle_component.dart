import 'dart:ui';
import 'package:flame/components.dart';

class RoundedRectangleComponent extends RectangleComponent {
  RoundedRectangleComponent({
    required this.borderRadius,
    required this.color,
    super.position,
    super.anchor,
    super.size,
  });

  final double borderRadius;
  final Color color;

  Color? paintColor;

  void setTransparentColor(double opacity) {
    paintColor = color.withOpacity(opacity);
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0, 0, size.x, size.y);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
    final paint = Paint()..color = paintColor != null ? paintColor! : color;
    canvas.drawRRect(rrect, paint);
  }
}
