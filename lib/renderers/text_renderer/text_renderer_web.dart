import 'dart:html';

import 'package:flutter/material.dart';
import 'package:seo_renderer/helpers/seo_object.dart';
import 'package:seo_renderer/helpers/utils.dart';

/// A Widget to create the HTML Tags from the TEXT widget.
class TextRenderer extends StatefulWidget {
  /// Default [TextRenderer] const constructor.
  const TextRenderer({
    Key? key,
    required this.text,
    this.controller,
  }) : super(key: key);

  /// Provide with [Widget] widget to get data from it.
  final Widget text;

  /// Controller to refresh position in any case you want.
  final RenderController? controller;

  @override
  _TextRendererState createState() => _TextRendererState();
}

class _TextRendererState extends State<TextRenderer> with RouteAware {
  final DivElement div = new DivElement();
  final key = GlobalKey();

  @override
  void didChangeDependencies() {
    if (SeoRenderer.isShowingSeoRenders()) {
      SeoRenderer.routeObserver.subscribe(this, ModalRoute.of(context)!);
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    if (SeoRenderer.isShowingSeoRenders()) {
      clear();
      SeoRenderer.routeObserver.unsubscribe(this);
    }
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    widget.controller?.rendererRefresh = refresh;
    widget.controller?.rendererClear = clear;
  }

  @override
  void didPop() {
    clear();
    super.didPop();
  }

  @override
  void didPush() {
    addDivElement();
    super.didPush();
  }

  @override
  void didPopNext() {
    addDivElement();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    clear();
    super.didPushNext();
  }

  void refresh() {
    if (!SeoRenderer.isShowingSeoRenders()) {
      return;
    }
    div.style.position = 'absolute';
    div.style.top = '${key.globalPaintBounds?.top ?? 0}px';
    div.style.left = '${key.globalPaintBounds?.left ?? 0}px';
    div.style.width = '${key.globalPaintBounds?.width ?? 100}px';
    div.text = _getTextFromWidget().toString();
    div.style.color = '#ff0000';
    div.style.pointerEvents = 'none';
  }

  @override
  Widget build(BuildContext context) {
    if (!SeoRenderer.isShowingSeoRenders()) {
      return widget.text;
    }
    return SizedBox(
      key: key,
      child: widget.text,
    );
  }

  addDivElement() {
    if (!SeoRenderer.isShowingSeoRenders()) {
      return;
    }
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      refresh();
      if (!document.body!.contains(div)) document.body?.append(div);
    });
  }

  void clear() {
    if (!SeoRenderer.isShowingSeoRenders()) {
      return;
    }
    div.remove();
  }

  String? _getTextFromWidget() {
    final text = widget.text;
    if (text is Text) {
      String? data;
      data = text.data;
      if (data != null) {
        return data;
      }
      if (text.textSpan != null) {
        data = text.textSpan!.toPlainText();
      }
      if (data != null) {
        return data;
      }
    }

    if (text is RichText) {
      return text.text.toPlainText();
    }

    if (text is SelectableText) {
      return text.data ?? text.textSpan?.toPlainText() ?? '';
    }

    if (text is SeoTextObject) {
      return (text as SeoTextObject).getSeoText();
    }

    throw FlutterError(
        'Provided Widget is of Type ${text.runtimeType}. Only supported widget is Text, RichText, SelectableText and classes that implement SeoObject');
  }
}
