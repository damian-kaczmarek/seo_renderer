import 'package:flutter/material.dart';



class SeoRenderer {
  /// [RouteObserver] created to remove Element in case pop in [RouteAware]
  static final RouteObserver<ModalRoute<void>> routeObserver =
  RouteObserver<ModalRoute<void>>();

  ///Regex to detect Crawler for Search Engines
  static final RegExp regExpBots = RegExp(r'/bot|google|baidu|bing|msn|teoma|slurp|yandex/i');

  ///use to force adding html divs for developing purposes
  static bool show = false;
}

/// A [GlobalKey] Extension to get Rect from the RenderObject from a GlobalKey
extension GlobalKeyExtension on GlobalKey {
  Rect? get globalPaintBounds {
    final renderObject = currentContext?.findRenderObject();
    var translation = renderObject?.getTransformTo(null).getTranslation();
    if (translation != null && renderObject?.paintBounds != null) {
      return renderObject!.paintBounds
          .shift(Offset(translation.x, translation.y));
    } else {
      return null;
    }
  }
}

///Controller class to refresh the position in case of Scrolling
///[refresh] method to reposition the html tags in case widget is displaced somewhere.
class RenderController {
  late VoidCallback refresh;
  late VoidCallback clear;
}
