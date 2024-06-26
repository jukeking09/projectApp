class Choice {
  final int choiceId; // ID of the choice (if needed)
  final String choiceText;
  final bool isCorrect;

  Choice({
    required this.choiceId,
    required this.choiceText,
    required this.isCorrect,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
      choiceId: json['id'], // Adjust according to your API response
      choiceText: json['choiceText'],
      isCorrect: json['isCorrect'],
    );
  }
}
