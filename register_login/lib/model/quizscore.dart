class QuizScore {
  final int quizId;
  final int score;

  QuizScore({
    required this.quizId,
    required this.score,
  });

  factory QuizScore.fromJson(Map<String, dynamic> json) {
    return QuizScore(
      quizId: json['quiz_id'],
      score: json['score'],
    );
  }
}
