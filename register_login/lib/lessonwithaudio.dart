import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:register_login/api/lessonapi.dart';
import 'package:register_login/model/audio.dart';
import 'dart:convert';

import 'package:register_login/model/quiz.dart';

class Lesson1Page extends StatefulWidget {
  @override
  _Lesson1PageState createState() => _Lesson1PageState();
}

class _Lesson1PageState extends State<Lesson1Page> {
  final AudioPlayer _player = AudioPlayer();
  final LessonPageApi _api = LessonPageApi();
  String _lessonContent = '';
  bool _isLoading = true;
  int? _lessonId;
  Quiz? _quiz;
  List<Map<String, dynamic>> _audios = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _lessonId = args != null ? args['lessonId'] : null;
    if (_lessonId != null) {
      _fetchLessonContent();
      _fetchQuiz();
      _fetchLessonAudios(); // Fetch audio URLs for words in the lesson content
    } else {
      setState(() {
        _isLoading = false;
        _lessonContent = 'Error: No lesson ID provided';
      });
    }
  }

  Future<void> _fetchLessonContent() async {
    try {
      String content = await _api.fetchLessonContent(_lessonId!);
      setState(() {
        _lessonContent = content;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _lessonContent = 'Error fetching lesson content';
      });
      print('Error fetching lesson content: $e');
    }
  }

  Future<void> _fetchQuiz() async {
    try {
      Quiz quiz = await _api.fetchQuizByLessonId(_lessonId!);
      setState(() {
        _quiz = quiz;
      });
    } catch (e) {
      setState(() {
        _quiz = null;
        print('Error fetching quiz: $e');
      });
    }
  }

  Future<void> _fetchLessonAudios() async {
  try {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/lessonswithaudio/$_lessonId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('audios')) {
        // Check if "audios" is a list
        if (data['audios'] is List) {
          final List<dynamic> audiosData = data['audios'];
          setState(() {
            _audios = List<Map<String, dynamic>>.from(audiosData);
          });
        } else {
          print('Invalid audio data format: "audios" is not a list');
        }
      } else {
        print('Invalid audio data format: Missing or invalid "audios" key');
      }
    } else {
      print('Failed to load audio data: Status code ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching audio data: $e');
  }
}

  Future<void> _playAudio(String audioUrl) async {
    await _player.play(AssetSource('$audioUrl'));
    print('Playing audio: $audioUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Lesson'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 224, 3, 102),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _lessonContent,
                      style: TextStyle(fontSize: 18.0),
                      softWrap: true,
                    ),
                    SizedBox(height: 20.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _audios.length,
                      itemBuilder: (context, index) {
                        var audio = _audios[index];
                        return ElevatedButton(
                          onPressed: () => _playAudio(audio['audio_url']),
                          child: Text(audio['word']),
                        );
                      },
                    ),
                    SizedBox(height: 20.0),
                    if (_quiz != null)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/questions', arguments: {'quizId': _quiz!.id});
                        },
                        child: Text('Start Quiz: ${_quiz!.title}'),
                      )
                    else
                      Text('No quiz available for this lesson'),
                  ],
                ),
              ),
            ),
    );
  }
}
