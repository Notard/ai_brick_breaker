import 'package:brick_breaker/component/event_bus.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class BreakBrickCamera extends CameraComponent {
  BreakBrickCamera({
    Viewport? viewport,
    Viewfinder? viewfinder,
    Component? backdrop,
    List<Component>? hudComponents,
  }) : super(
          viewport: viewport ??
              FixedResolutionViewport(resolution: Vector2(1080, 1920)),
          viewfinder: viewfinder ?? Viewfinder(),
          backdrop: backdrop ?? Component(),
          hudComponents: hudComponents ?? [],
        );

  @override
  void onLoad() {
    super.onLoad();
    EventBus().subscribe(cameraZoomEvent, (double zoom) {
      viewfinder.zoom = zoom;
    });
  }
}
