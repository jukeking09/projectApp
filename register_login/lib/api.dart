import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:8000/api'; // e.g., 'http://localhost:8000'
  
  static Future<Map<String, dynamic>> registerUser(String email, String password, {required String route}) async {
    final url = Uri.parse('$baseUrl/register'); // Adjust endpoint accordingly
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
    final url = Uri.parse('$baseUrl/login'); // Adjust endpoint accordingly
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    return json.decode(response.body);
  }
}
