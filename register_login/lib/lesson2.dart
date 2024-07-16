import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:register_login/api/lessonapi.dart';
import 'package:register_login/model/audio.dart';
import 'package:register_login/model/quiz.dart';

class Lesson2Page extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<Lesson2Page> {
  final LessonPageApi _api = LessonPageApi();
  String _lessonContent = '';
  bool _isLoading = true;
  int? _lessonId;
  List<Quiz>? _quizzes;
  List<Audio>? _audios;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _lessonId = args != null ? args['lessonId'] : null;
    if (_lessonId != null) {
      _fetchLessonContent();
      _fetchQuizzes();
      _fetchLessonAudios();
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

  Future<void> _fetchQuizzes() async {
    try {
      List<Quiz> quizzes = await _api.fetchQuizzesByLessonId(_lessonId!);
      setState(() {
        _quizzes = quizzes;
      });
    } catch (e) {
      setState(() {
        _quizzes = null;
        print('Error fetching quizzes: $e');
      });
    }
  }
  Future<void> _fetchLessonAudios() async {
    try {
      List<Audio> audios = await _api.fetchLessonAudios(_lessonId!);
      setState(() {
        _audios = audios;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        print('Error fetching audios: $e');
      });
    }
  }

   void _playAudio(String url) async {
  AudioPlayer audioPlayer = AudioPlayer();
  try {
    await audioPlayer.play(AssetSource(url));
  } catch (e) {
    print('Error playing audio: $e');
  }
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
                    _quizzes != null && _quizzes!.isNotEmpty
                        ? Column(
                            children: _quizzes!.map((quiz) {
                              return ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, '/questions', arguments: {'quizId': quiz.id});
                                },
                                child: Text('Start Quiz: ${quiz.title}'),
                              );
                            }).toList(),
                          )
                        : Text('No quizzes available for this lesson'),
                    SizedBox(height: 20.0),
                    if (_audios != null && _audios!.isNotEmpty) ...[
                      Text(
                        'Pronunciation:',
                        style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                      ),
                      Column(
                        children: _audios!.map((audio) {
                          return ListTile(
                            title: Text(audio.word, style: TextStyle(fontSize: 18.0)),
                            trailing: IconButton(
                              icon: Icon(Icons.volume_up),
                              onPressed: () {
                                _playAudio(audio.audioUrl);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ] else ...[
                      Text('No audios available for this lesson'),
                    ],
                  ],
                ),
              ),
            ),
    );
  }
}
