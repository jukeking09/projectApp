import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addLesson');
              },
              child: Text('Add Lesson'),
            ),
            SizedBox(height: 10), // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addQuiz');
              },
              child: Text('Add Quiz'),
            ),
            SizedBox(height: 10), // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addQuestion');
              },
              child: Text('Add Question'),
            ),
            SizedBox(height: 10), // Spacing between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addChoice');
              },
              child: Text('Add Choice'),
            ),
          ],
        ),
      ),
    );
  }
}

// AddLessonPage, AddQuizPage, AddQuestionPage, AddChoicePage are defined the same way as before.
