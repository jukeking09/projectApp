import 'dart:convert';

import 'package:register_login/model/language.dart';
import 'package:register_login/model/lessondetails.dart';
import 'package:http/http.dart' as http;
import 'package:register_login/model/quizscore.dart';
class UserApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';
  static Future<List<Language>> fetchLanguagesByUserId(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/languages'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => Language.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load languages');
    }
  }

  static Future<List<LessonDetails>> fetchLessonDetails(int userId, int languageId) async {
  final response = await http.get(Uri.parse('$baseUrl/user/$userId/lessons?language_id=$languageId'));
  print(response.body);
  if (response.statusCode == 200) {
    print('inside');
    List<dynamic> data = json.decode(response.body);
    List<LessonDetails> lessons = data.map((json) => LessonDetails.fromJson(json)).toList();
    lessons.take(3).forEach((lesson) => print(lesson.toString()));
    return lessons;
  } else {
    throw Exception('Failed to load lesson details');
  }
}

  static Future<List<QuizScore>> fetchQuizScores(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/user/$userId/quiz-scores'));
    // print(response.body);
    if (response.statusCode == 200) {
      // print('inside');
      List<dynamic> data = json.decode(response.body);
      List<QuizScore> quizScores = data.map((json) => QuizScore.fromJson(json)).toList();
      print(quizScores.toString());
      return quizScores;
    } else {
      throw Exception('Failed to load quiz scores');
    }
  }
}