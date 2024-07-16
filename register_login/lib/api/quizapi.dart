import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:register_login/homepage2.dart';
// import 'package:register_login/home.dart';
import 'package:register_login/model/quiz.dart';
import 'package:register_login/model/question.dart';
import 'package:register_login/userid.dart';

class QuizApi {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Replace with your actual API base URL
  late int userId;

  // Constructor to initialize userId
  QuizApi() {
    _initializeUserId();
  }

  // Method to initialize userId from SharedPreferences
  Future<void> _initializeUserId() async {
    userId = await UserIdStorage.getUserId() ?? 0;
  }
  Future<List<Quiz>> fetchQuizById(int quiz_id) async {
    final response = await http.get(Uri.parse('$baseUrl/quizzes/$quiz_id'));

    if (response.statusCode == 200) {
      Iterable data = jsonDecode(response.body);
      return List<Quiz>.from(data.map((model) => Quiz.fromJson(model)));
    } else {
      throw Exception('Failed to fetch quizzes');
    }
  }

   Future<List<Question>> fetchQuestions(int quizId) async {
    final response = await http.get(Uri.parse('$baseUrl/questions/$quizId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> questionsData = data['questions'];

      List<Question> questions = questionsData.map((questionJson) {
        return Question.fromJson(questionJson);
      }).toList();

      return questions;
    } else {
      throw Exception('Failed to fetch questions for quiz $quizId');
    }
  }

   Future<void> sendQuizScore(int quizId, int score) async {
    String apiUrl = '$baseUrl/quizzes/submitScore';
    // print(userId);
    try {
      Map<String, dynamic> payload = {
        'userId': userId,
        'quizId': quizId,
        'score': score,
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        body: jsonEncode(payload),
        headers: {
          'Content-Type': 'application/json',
          // Add any additional headers as needed
        },
      );

      if (response.statusCode == 200) {
        print('Quiz score sent successfully');
        await markQuizAsCompleted(quizId); // Call method to mark quiz as completed
        // Handle success if needed
      } else {
        throw Exception('Failed to send quiz score. Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Error sending quiz score: $e');
    }
  }
  Future<void> markQuizAsCompleted(int quizId) async {
  String apiUrl = '$baseUrl/quizzes/markCompleted';

  try {
    print(userId);
    print(quizId);
    Map<String, dynamic> payload = {
      'userId': userId,
      'quizId': quizId,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(payload),
      headers: {
        'Content-Type': 'application/json',
        // Add any additional headers as needed
      },
    );

    if (response.statusCode == 200) {
      print('Quiz marked as completed successfully');
      // Handle success if needed
    } else {
      throw Exception('Failed to mark quiz as completed. Error: ${response.body}');
    }
  } catch (e) {
    throw Exception('Error marking quiz as completed: $e');
  }
}

  fetchLessonContent(int i) {}
}
