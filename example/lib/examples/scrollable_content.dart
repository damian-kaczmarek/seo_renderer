import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';

class ScrollableContent extends StatefulWidget {
  const ScrollableContent({Key? key}) : super(key: key);

  @override
  _ScrollableContentState createState() => _ScrollableContentState();
}

class _ScrollableContentState extends State<ScrollableContent> {
  static const loremIpsumCount = 10;
  static const loremIpsum =
      '''Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.''';

  ScrollController scrollController = ScrollController();
  final List<RenderController> renderControllers = [];

  @override
  void initState() {
    super.initState();
    if(!SeoRenderer.isShowingSeoRenders()){
      return;
    }
    for (int i = 0; i < loremIpsumCount; i++) {
      final rc = RenderController();
      renderControllers.add(rc);
      WidgetsBinding.instance?.addPostFrameCallback((_) {
        scrollController.addListener(rc.refresh);
      });
    }
  }

  @override
  void dispose() {
    for (final rc in renderControllers) {
      scrollController.removeListener(rc.refresh);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SEO HTML Tag Creator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: renderControllers
                .map(
                  (renderController) => TextRenderer(
                    controller: renderController,
                    text: Text(loremIpsum),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
