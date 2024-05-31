class Lesson {
  final String title;
  final String description;

  Lesson({required this.title, required this.description});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      description: json['description'],
    );
  }
}
