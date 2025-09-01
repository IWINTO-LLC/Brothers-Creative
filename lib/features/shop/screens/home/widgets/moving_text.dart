import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class TMovingText extends StatelessWidget {
  const TMovingText({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        RotateAnimatedText('AWESOME',
            textStyle: const TextStyle(
                fontSize: 30,
                color: Colors.white,
                backgroundColor: Colors.blue)),
        RotateAnimatedText('OPTIMISTIC',
            textStyle: const TextStyle(
                letterSpacing: 3,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orange)),
        RotateAnimatedText(
          'DIFFERENT',
          textStyle: const TextStyle(
            fontSize: 30,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
      isRepeatingAnimation: true,
      totalRepeatCount: 10,
      pause: const Duration(milliseconds: 100),
    );
  }
}
