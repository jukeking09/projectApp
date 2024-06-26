import 'package:register_login/model/question.dart';


class Quiz {
  final int id;
  final String title;
  final List<Question> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    List<Question> questions = (json['questions'] as List<dynamic>)
        .map((question) => Question.fromJson(question))
        .toList();

    return Quiz(
      id: json['id'],
      title: json['title'],
      questions: questions,
    );
  }
}

