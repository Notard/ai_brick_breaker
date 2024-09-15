import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'brick.dart'; // 벽돌 클래스를 import

class BrickManager extends PositionComponent {
  final Forge2DGame game;
  final int rows;
  final int columns;
  final Vector2 brickSize;
  final Vector2 startPosition;

  BrickManager({
    required this.game,
    required this.rows,
    required this.columns,
    required this.brickSize,
    required this.startPosition,
  });

  @override
  Future<void> onLoad() async {
    // 그리드 형태로 벽돌을 배치
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        // 각 벽돌의 위치 계산
        final position = Vector2(
          startPosition.x + col * brickSize.x + 0.5,
          startPosition.y + row * brickSize.y + 0.5,
        );

        // 각 위치에 벽돌 생성
        final brick = Brick(
          centerPosition: position,
          brickSize: brickSize,
        );

        // 벽돌을 게임에 추가
        game.add(brick);
      }
    }
  }
}
