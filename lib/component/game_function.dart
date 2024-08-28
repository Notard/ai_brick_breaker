import 'package:flutter/material.dart';

class GameFunction {
  static final GameFunction _singleton = GameFunction._internal();
  factory GameFunction() {
    return _singleton;
  }
  GameFunction._internal();

  TextStyle getTextStyle({
    required double fontSize,
    required Color color,
  }) {
    return TextStyle(
      fontFamily: '온글잎 은별',
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: color,
      shadows: const <Shadow>[
        Shadow(
          blurRadius: 2.0,
          color: Colors.black,
          offset: Offset(3.0, 3.0),
        ),
      ],
    );
  }
}
