import 'dart:html';

import 'package:seo_renderer/helpers/utils.dart';

class SeoRendererPlatform {
  static bool? botFlag;

  bool isBot() {
    if (botFlag == null) {
      botFlag = SeoRenderer.regExpBots
          .hasMatch(window.navigator.userAgent.toString());
    }
    return botFlag!;
  }
}
