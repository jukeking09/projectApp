import 'package:flutter/material.dart';
import 'package:register_login/api/adminapi.dart';
import 'package:register_login/api/api.dart';
import 'package:register_login/model/lesson.dart';
import 'package:http/http.dart' as http;

class AddQuizPage extends StatefulWidget {
  @override
  _AddQuizPageState createState() => _AddQuizPageState();
}

class _AddQuizPageState extends State<AddQuizPage> {
  late Future<List<Lesson>>? _lessonsFuture;
  Lesson? _selectedLesson;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<Question> _questions = [];

  @override
  void initState() {
    super.initState();
    // Defer the initialization to the end of the frame
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _initializeLessons();
    });
  }

  void _initializeLessons() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final languageId = args != null ? args['languageId'] as int : null;

    if (languageId != null) {
      setState(() {
        _lessonsFuture = ApiService.fetchLessons(languageId);
      });
    } else {
      // Handle error or fallback behavior if languageId is null
      print('Language ID is null');
    }
  }

  void _addQuestion() {
    setState(() {
      _questions.add(Question());
    });
  }

  Future<void> _submitQuiz() async {
    if (_selectedLesson != null &&
        _titleController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _questions.isNotEmpty) {
      // Collect data for the quiz
      final quizData = {
        'lesson_id': _selectedLesson!.id,
        'title': _titleController.text,
        'description': _descriptionController.text,
        'questions': _questions.map((q) => q.toJson()).toList(),
      };

      // Send data to the backend
      final response = await AdminApiService.addQuiz(
        lessonId: _selectedLesson!.id,
        title: _titleController.text,
        description: _descriptionController.text,
        questions: _questions.map((q) => q.toJson()).toList(),
      );

      if (response['status'] == 200) {
      // Handle success
      Navigator.pop(context, true); // Navigate back to previous screen with success flag
    } else {
      // Handle failure
      print('Failed to add quiz');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add quiz. Please try again later.')),
      );
    }
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields and add at least one question')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Quiz'),
      ),
      body: FutureBuilder<List<Lesson>>(
        future: _lessonsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No lessons available'));
          } else {
            return _buildQuizForm(snapshot.data!);
          }
        },
      ),
    );
  }

  Widget _buildQuizForm(List<Lesson> lessons) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<Lesson>(
              value: _selectedLesson,
              onChanged: (value) {
                setState(() {
                  _selectedLesson = value;
                });
              },
              items: lessons.map((lesson) {
                return DropdownMenuItem<Lesson>(
                  value: lesson,
                  child: Text(lesson.title),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Select Lesson',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Quiz Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Quiz Description',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ..._questions.map((question) => _buildQuestionForm(question)).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuestion,
              child: Text('Add Question'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitQuiz,
              child: Text('Submit Quiz'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionForm(Question question) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Column(
      children: [
        TextField(
          controller: question.questionController,
          decoration: InputDecoration(
            labelText: 'Question',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        ...question.choices.asMap().entries.map((entry) {
          int idx = entry.key;
          TextEditingController controller = entry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: 'Choice ${idx + 1}',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Checkbox(
                  value: question.correctAnswerController.text == controller.text,
                  onChanged: (isChecked) {
                    setState(() {
                      if (isChecked!) {
                        // Update correct answer only if checked
                        question.correctAnswerController.text = controller.text;
                      } else if (question.correctAnswerController.text == controller.text) {
                        // Clear correct answer if unchecked
                        question.correctAnswerController.text = '';
                      }
                    });
                  },
                ),
              ],
            ),
          );
        }).toList(),
      ],
    ),
  );
}
}
class Question {
  final TextEditingController questionController = TextEditingController();
  final List<TextEditingController> choices = List.generate(4, (_) => TextEditingController());
  TextEditingController correctAnswerController = TextEditingController();

  Map<String, dynamic> toJson() {
    return {
      'question': questionController.text,
      'choices': choices.map((c) => c.text).toList(),
      'correct_answer': correctAnswerController.text,
    };
  }
}
