import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PronunciationPage2 extends StatelessWidget {
  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pronunciation Page 2'),
        backgroundColor: const Color.fromARGB(255, 224, 3, 102),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await _player.play(AssetSource('sounds/b b.m4a'));
              },
              child: Text('Play B B'),
            ),
            // Add more buttons for other sounds as needed
          ],
        ),
      ),
    );
  }
}
