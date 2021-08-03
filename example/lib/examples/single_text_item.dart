import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seo_renderer/seo_renderer.dart';

class SingleTextItem extends StatelessWidget {
  const SingleTextItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextRenderer(
              text: Text('Hello World'),
            ),
            TextRenderer(
              text: RichText(
                text: TextSpan(
                  text: 'Hello ',
                  children: const <TextSpan>[
                    TextSpan(
                        text: 'bold',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' world!'),
                  ],
                ),
              ),
            ),
            TextRenderer(
              text: SelectableText('Selectable Hello World'),
            ),
          ],
        ),
      ),
    );
  }
}
