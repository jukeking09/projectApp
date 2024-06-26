class Lesson {
  final String title;
  final String description;
  final int id;

  Lesson({required this.title, required this.description, required this.id});

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      description: json['description'],
      id:json['id']
    );
  }
}
