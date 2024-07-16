class LessonDetails {
  final int lessonId;
  final String lessonTitle;
  final int isCompleted;

  LessonDetails({
    required this.lessonId,
    required this.lessonTitle,
    required this.isCompleted,
  });

  factory LessonDetails.fromJson(Map<String, dynamic> json) {
    return LessonDetails(
      lessonId: json['lesson_id'],
      lessonTitle: json['lesson_title'],
      isCompleted: json['is_completed'],
    );
  }
}