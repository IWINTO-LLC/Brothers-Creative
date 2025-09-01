import 'package:flutter/material.dart';

class AudioRecorder extends StatelessWidget {
  const AudioRecorder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(onPressed: () {}, child: Icon(Icons.mic)),
    );
  }
}
