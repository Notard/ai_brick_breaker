import 'package:brick_breaker/component/event_bus.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

class BreakBrickFrame extends FlameGame
    with PanDetector, HasCollisionDetection {
  BreakBrickFrame({required super.world, required super.camera});

  Vector2 startPos = Vector2(0, 0);

  @override
  void onPanUpdate(DragUpdateInfo info) {
    // 스와이프 중
    Vector2 nowPos = info.eventPosition.global;
    Vector2 diff = nowPos - startPos;

    Vector2 windowSize = camera.viewport.size;
    diff.x = diff.x * (1080 / windowSize.x);

    EventBus().publish(paddleMoveEvent, diff.x);
  }

  @override
  void onPanStart(DragStartInfo info) {
    // 스와이프 시작
    startPos = info.eventPosition.global;
  }
}
