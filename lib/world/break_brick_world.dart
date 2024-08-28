import 'package:brick_breaker/component/event_bus.dart';
import 'package:brick_breaker/game/game_page.dart';
import 'package:brick_breaker/game/main_menu_page.dart';
import 'package:brick_breaker/game/title_page.dart';
import 'package:flame/camera.dart';
import 'package:flame/components.dart';

class BreakBrickWorld extends World {
  @override
  void onLoad() async {
    TitlePage titlePage = TitlePage();
    add(titlePage);
    EventBus().subscribe('mainMenuEvent', (_) {
      CameraComponent.currentCamera?.viewfinder.zoom = 1;
      MainMenuPage mainMenuPage = MainMenuPage();
      add(mainMenuPage);
    });
    //gamePageEvent
    EventBus().subscribe('gamePageEvent', (_) {
      CameraComponent.currentCamera?.viewfinder.zoom = 100;
      GamePage gamePage = GamePage();

      add(gamePage);
    });
    super.onLoad();
  }
}
