

class Question {
  final int id;
  final String questionText;
  final String correctAnswer;
  final List<String> choices;

  Question({
    required this.id,
    required this.questionText,
    required this.correctAnswer,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      questionText: json['question_text'],
      correctAnswer: json['correct_answer'],
      choices: List<String>.from(json['choices']),
    );
  }
}
