import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class PronunciationPage1 extends StatelessWidget {
  final AudioPlayer _player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pronunciation For Lesson 3'),
        backgroundColor: const Color.fromARGB(255, 224, 3, 102),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Allows horizontal scrolling
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await _player.play(AssetSource('sounds/Phi.m4a'));
                  },
                  child: Text('Phi'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _player.play(AssetSource('sounds/Dang.m4a'));
                  },
                  child: Text('Dang'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _player.play(AssetSource('sounds/Leh.m4a'));
                  },
                  child: Text('Leh'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await _player.play(AssetSource('sounds/Aiu.m4a'));
                  },
                  child: Text('Aiu'),
                ),
                // Add more buttons for other sounds as needed
              ],
            ),
          ),
          // Add other widgets below if needed
        ],
      ),
    );
  }
}
