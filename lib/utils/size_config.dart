import 'package:flutter/widgets.dart';

class SizeConfig {
  static var _screenWidth;
  static var _screenHeight;
  static var safeAreaHeight;
  static var _safeAreaPadding;
  static var safeAreaVertical;

  static var _blockWidth;
  static var _blockHeight;

  static var textMultiplier;
  static var imageSizeMultiplier;
  static var heightMultiplier;
  static var widthMultiplier;
  static var cardContainerWidth;


  void init(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    _safeAreaPadding = MediaQuery.of(context).padding;
    safeAreaVertical = _safeAreaPadding.top + _safeAreaPadding.bottom;

    safeAreaHeight = _screenHeight - safeAreaVertical;
    safeAreaHeight = _screenHeight;

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;

    textMultiplier = _blockHeight;
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}