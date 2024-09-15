import 'package:brick_breaker/world/break_brick_camera.dart';
import 'package:brick_breaker/world/break_brick_frame.dart';
import 'package:brick_breaker/world/break_brick_world.dart';
import 'package:flame/camera.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';

void main() {
  Viewfinder viewport = Viewfinder();

  runApp(
    GameWidget(
      game: BreakBrickFrame(
        world: BreakBrickWorld(),
        camera: BreakBrickCamera(
          viewport: FixedResolutionViewport(
            resolution: Vector2(1080, 1920),
          ),
          viewfinder: viewport,
        ),
      ),
    ),
  );
}
