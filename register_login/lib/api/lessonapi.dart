import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
