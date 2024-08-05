import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String inputText;

  const CustomTextWidget({super.key, required this.inputText});

  @override
  Widget build(BuildContext context) {
    List<InlineSpan> spans = [];

    List<String> words = inputText.split(' ');

    for (String word in words) {
      if (word.startsWith('@')) {
        spans.add(WidgetSpan(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              transform: Matrix4.rotationZ(-0.03),
              child: Text(
                word,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ));
      } else if (word.startsWith('*') && word.endsWith('*')) {
        // If the word is surrounded by *, display it in blue
        spans.add(TextSpan(
          text: '${word.substring(1, word.length - 1)} ',
          style: const TextStyle(
              color: Colors.purpleAccent,
              fontWeight: FontWeight.bold,
              fontSize: 16),
        ));
      } else {
        // Otherwise, display the word in black
        spans.add(TextSpan(
          text: '$word ',
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16),
        ));
      }
    }

    return RichText(
      text: TextSpan(children: spans, style: const TextStyle(height: 1.5)),
      textAlign: TextAlign.center,
    );
  }
}
