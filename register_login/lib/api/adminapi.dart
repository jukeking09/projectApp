import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:register_login/model/user.dart';

class AdminApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api';

  static Future<Map<String, dynamic>> addLanguage(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/addLanguage'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name}),
    );
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print(response.body);
        return {'status': 'error', 'message': 'Sumting wing'};
      }
    } else {
      return {'status': response.statusCode, 'message': 'Server returned an error'};
    }
  }

  static Future<Map<String, dynamic>> addLesson(int languageId, String title, String description, String content) async {
    //print(description);
    final response = await http.post(
      Uri.parse('$baseUrl/addLesson'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'language_id': languageId,
        'title': title,
        'description': description,
        'content': content,
      }),
    );

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print(response.body);
        return {'status': 'error', 'message': 'Failed to parse JSON response'};
      }
    } else {
      print(response.body);
      return {'status': response.statusCode, 'message': 'Server returned an error'};
    }
  }



  static Future<List<dynamic>> getLessons() async {
    final response = await http.get(Uri.parse('$baseUrl/getlessons'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['lessons'];
    } else {
      throw Exception('Failed to load lessons');
    }
  }

  static Future<Map<String, dynamic>> addQuiz({
    required int lessonId,
    required String title,
    required String description,
    required List<Map<String, dynamic>> questions,
  }) async {
    print(questions);
    final response = await http.post(
      Uri.parse('$baseUrl/addQuiz'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'lesson_id': lessonId,
        'title': title,
        'description': description,
        'questions': questions,
      }),
    );
    print(response);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to add quiz');
    }
  }

   static Future<List<dynamic>> getQuizzes() async {
    final response = await http.get(Uri.parse('$baseUrl/quizzes'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['quizzes'];
    } else {
      throw Exception('Failed to load quizzes');
    }
  }

  // static Future<Map<String, dynamic>> addQuestion(int quizId, String questionText, List<String> choices, String correctAnswer) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/questions'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'quiz_id': quizId,
  //       'question_text': questionText,
  //       'choices': choices,
  //       'correct_answer': correctAnswer,
  //     }),
  //   );
  //   return jsonDecode(response.body);
  // }
  
  static Future<List<User>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/admin/users'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((dynamic item) => User.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  static Future<void> deleteUser(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/admin/users/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete user');
    }
  }
}


