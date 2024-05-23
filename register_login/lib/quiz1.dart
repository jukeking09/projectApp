// lib/screens/question_list_screen.dart
import 'package:flutter/material.dart';

class QuestionListScreen extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {
    // Hardcoded questions and choices
    final questions = [
      {
        'question_text': 'What is the capital of France?',
        'choices': [
          {'choice_text': 'Paris'},
          {'choice_text': 'London'},
          {'choice_text': 'Berlin'},
          {'choice_text': 'Madrid'},
        ]
      },
      {
        'question_text': 'Which planet is known as the Red Planet?',
        'choices': [
          {'choice_text': 'Earth'},
          {'choice_text': 'Mars'},
          {'choice_text': 'Jupiter'},
          {'choice_text': 'Venus'},
        ]
      },
      // Add more questions as needed
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Questions'),
      ),
      body: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  questions[index]['question_text'] as String,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: (questions[index]['choices'] as List<dynamic>).map((choice) {
                      return ElevatedButton(
                      onPressed: () {
                      // Handle button press for this choice
                        print('User selected: ${choice['choice_text']}');
                      },
                      child: Text(choice['choice_text'] as String),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
