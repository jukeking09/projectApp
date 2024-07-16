// class LessonWithCompletion {
//   final int id;
//   final String title;
//   final String description;
//   final bool isCompleted;
//   final List<QuizWithCompletion> quizzes;

//   LessonWithCompletion({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.isCompleted,
//     required this.quizzes,
//   });

//   factory LessonWithCompletion.fromJson(Map<String, dynamic> json) {
//     var quizzesFromJson = json['quizzes'] as List;
//     List<QuizWithCompletion> quizList = quizzesFromJson.map((quizJson) => QuizWithCompletion.fromJson(quizJson)).toList();

//     return LessonWithCompletion(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       isCompleted: json['is_completed'],
//       quizzes: quizList,
//     );
//   }
// }

// class QuizWithCompletion {
//   final int id;
//   final bool isCompleted;

//   QuizWithCompletion({
//     required this.id,
//     required this.isCompleted,
//   });

//   factory QuizWithCompletion.fromJson(Map<String, dynamic> json) {
//     return QuizWithCompletion(
//       id: json['id'],
//       isCompleted: json['is_completed'],
//     );
//   }
// }

class LessonWithCompletion {
  final int id;
  final String title;
  final String description;
  final bool isCompleted;

  LessonWithCompletion({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  // Factory constructor to create an instance from JSON
  factory LessonWithCompletion.fromJson(Map<String, dynamic> json) {
    return LessonWithCompletion(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  // Optional: Method to print the object nicely
  @override
  String toString() {
    return 'LessonWithCompletion{id: $id, title: $title, description: $description, isCompleted: $isCompleted}';
  }
}
