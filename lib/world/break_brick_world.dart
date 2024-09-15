import 'package:brick_breaker/component/event_bus.dart';
import 'package:brick_breaker/game/game_clear.dart';
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
    EventBus().subscribe(mainMenuEvent, (_) {
      EventBus().publish(cameraZoomEvent, 1.0);
      MainMenuPage mainMenuPage = MainMenuPage();
      add(mainMenuPage);
    });
    //gamePageEvent
    EventBus().subscribe(gamePageEvent, (_) {
      EventBus().publish(cameraZoomEvent, 100.0);
      GamePage gamePage = GamePage();

      add(gamePage);
    });
    EventBus().subscribe(gameClearEvent, (bool isSuccess) {
      EventBus().publish(cameraZoomEvent, 1.0);
      GameClear gameClear = GameClear(isSuccess: isSuccess);

      add(gameClear);
    });
    super.onLoad();
  }
}
