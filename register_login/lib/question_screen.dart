import 'package:flutter/material.dart';
import 'package:register_login/api/quizapi.dart';
import 'package:register_login/model/question.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final QuizApi _api = QuizApi();
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _isLoading = true;
  late int _quizId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    _quizId = args != null ? args['quizId'] ?? -1 : -1;
    if (_quizId != -1) {
      _fetchQuizQuestions();
    } else {
      setState(() {
        _isLoading = false;
        _questions = [];
      });
    }
  }

  Future<void> _fetchQuizQuestions() async {
    try {
      List<Question> questions = await _api.fetchQuestions(_quizId);
      setState(() {
        _questions = questions;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _questions = [];
      });
      print('Error fetching quiz questions: $e');
    }
  }

  void _submitAnswer(String choice) {
    if (choice == _questions[_currentQuestionIndex].correctAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      _sendQuizScore();
    }
  }

  Future<void> _sendQuizScore() async {
    try {
      await _api.sendQuizScore(_quizId,_score);
      _showQuizResult();
    } catch (e) {
      print('Failed to send quiz score: $e');
      _showErrorDialog();
    }
  }

  void _showQuizResult() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Quiz Result'),
          content: Text('Your score is $_score/${_questions.length}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to send quiz score. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); 
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Questions'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _questions.isEmpty
              ? Center(child: Text('No questions found for this quiz.'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Question ${_currentQuestionIndex + 1}/${_questions.length}',
                          style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              _questions[_currentQuestionIndex].questionText,
                              style: TextStyle(fontSize: 18.0),
                            ),
                            SizedBox(height: 20.0),
                            ..._questions[_currentQuestionIndex].choices.map((choice) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 8.0),
                                child: ElevatedButton(
                                  onPressed: () => _submitAnswer(choice),
                                  child: Text(choice),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }
}
