import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:register_login/model/audio.dart';
import 'package:register_login/model/quiz.dart';

class LessonPageApi {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  Future<String> fetchLessonContent(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/lessons/$id'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body)['content'];
    } else {
      throw Exception('Failed to load lesson content: ${response.statusCode}');
    }
  }

  Future<Quiz> fetchQuizByLessonId(int lessonId) async {
    final response = await http.get(Uri.parse('$baseUrl/quizzes/$lessonId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print('API Response: $responseData'); // Debugging print
      return Quiz.fromJson(responseData['quiz']);
    } else {
      print('Failed to load quiz: ${response.body}'); // Debugging print
      throw Exception('Failed to load quiz');
    }
  }

   Future<List<Quiz>> fetchQuizzesByLessonId(int lessonId) async {
    final response = await http.get(Uri.parse('$baseUrl/lessons/$lessonId/quizzes'));
    if (response.statusCode == 200) {
      Iterable json = jsonDecode(response.body);
      return json.map((quiz) => Quiz.fromJson(quiz)).toList();
    } else {
      throw Exception('Failed to load quizzes');
    }
  }
  Future<List<Audio>> fetchLessonAudios(int lessonId) async {
    final response = await http.get(Uri.parse('$baseUrl/lessons/$lessonId/audios'));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body) as List;
      return jsonResponse.map((audioJson) => Audio.fromJson(audioJson)).toList();
    } else {
      throw Exception('Failed to load audios');
    }
  }
}

