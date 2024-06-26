import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:register_login/model/quiz.dart';
import 'package:register_login/model/question.dart';

class QuizApi {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Replace with your actual API base URL

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

  Future<void> submitAnswer(int quizId, int questionId, int optionId, bool isCorrect) async {
    // Implement your logic to submit answers to the backend
    // Example: POST request to save quiz response
    // You'll need to adjust this based on your API endpoint and structure
    final response = await http.post(
      Uri.parse('$baseUrl/quizzes/$quizId/questions/$questionId/answer'),
      body: jsonEncode({'optionId': optionId, 'isCorrect': isCorrect}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit answer');
    }
  }

  fetchLessonContent(int i) {}
}
