import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:register_login/validate.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // e.g., 'http://localhost:8000'
  
  static Future<Map<String, dynamic>> registerUser(String email, String password, {required String route}) async {
    final url = Uri.parse('$baseUrl/register'); // Adjust endpoint accordingly
    // Validation for email and password
    // Validate email and password
    final emailError = Validator.validateEmail(email);
    if (emailError != null) {
      return {'status': 400, 'message': emailError};
    }
    final passwordError = Validator.validatePassword(password);
    if (passwordError != null) {
      return {'status': 400, 'message': passwordError};
    }
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
  try {
    // Validate email and password
    final emailError = Validator.validateEmail(email);
    if (emailError != null) {
      return {'status': 400, 'message': emailError};
    }
    final passwordError = Validator.validatePassword(password);
    if (passwordError != null) {
      return {'status': 400, 'message': passwordError};
    }
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  } catch (e) {
    throw Exception('Failed to login: $e');
  }
}
}
