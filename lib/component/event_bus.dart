const String mainMenuEvent = 'MainMenu';
const String gamePageEvent = 'gamePage';
const String paddleMoveEvent = 'paddleMove';
const String ballOutEvent = 'ballOut';
const String brickCollisionEvent = 'brickCollision';
const String gameClearEvent = 'gameClear';
const String cameraZoomEvent = 'cameraZoom';

class EventBus {
  static final EventBus _instance = EventBus._internal();

  factory EventBus() {
    return _instance;
  }

  EventBus._internal();

  final Map<String, List<Function>> _listeners = {};

  void subscribe(String eventName, Function callback) {
    if (_listeners.containsKey(eventName) == false) {
      _listeners[eventName] = [];
    }
    _listeners[eventName]!.add(callback);
  }

  void publish(String eventName, [dynamic data]) {
    if (_listeners.containsKey(eventName)) {
      for (var callback in _listeners[eventName]!) {
        callback(data); // 데이터를 전달하여 호출
      }
    }
  }

  void unsubscribe(String eventName, Function callback) {
    if (_listeners.containsKey(eventName)) {
      _listeners[eventName]!.remove(callback);
    }
  }
}
