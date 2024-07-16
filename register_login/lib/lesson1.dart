import 'package:flutter/material.dart';
import 'package:register_login/api/lessonapi.dart';
import 'package:register_login/model/quiz.dart';

class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final LessonPageApi _api = LessonPageApi();
  String _lessonContent = '';
  bool _isLoading = true;
  int? _lessonId;
  Quiz? _quiz;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _lessonId = args != null ? args['lessonId'] : null;
    if (_lessonId != null) {
      _fetchLessonContent();
      _fetchQuiz();
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

  void _navigateToPronunciationPage() {
    if (_lessonId == 3) {
      Navigator.pushNamed(context, '/pronunciation1');
    } else {
      Navigator.pushNamed(context, '/pronunciation2');
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
                    if (_quiz != null)
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/questions', arguments: {'quizId': _quiz!.id});
                        },
                        child: Text('Start Quiz: ${_quiz!.title}'),
                      )
                    else
                      Text('No quiz available for this lesson'),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: _navigateToPronunciationPage,
                      child: Text('Pronunciation'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
