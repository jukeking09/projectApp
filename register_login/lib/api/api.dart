import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:register_login/model/language.dart';
import 'package:register_login/model/lesson.dart';
import 'package:register_login/validate.dart'; 



class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Define the base URL of the API
  // int userId = UserIdStorage.getUserId() as int;
  // Function to register a user
  static Future<Map<String, dynamic>> registerUser(String email, String password,
      {required String route}) async {
    final url = Uri.parse('$baseUrl/register'); // Construct the URL for registration endpoint

    // Validation for email and password
    // Validate email and password using the imported functions
    final emailError = Validator.validateEmail(email);
    if (emailError != null) { // If there's an error with the email, return a response with an error message
      return {'status': 400, 'message': emailError};
    }
    final passwordError = Validator.validatePassword(password);
    if (passwordError != null) { // If there's an error with the password, return a response with an error message
      return {'status': 400, 'message': passwordError};
    }

    // Make a POST request to the registration endpoint with the provided email and password
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );

    // Decode the response body from JSON format
    return json.decode(response.body);
  }

  // Function to login a user
  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final url = Uri.parse('$baseUrl/login'); // Construct the URL for login endpoint

  try {
    // Validate email and password using the imported functions
    final emailError = Validator.validateEmail(email);
    if (emailError != null) { // If there's an error with the email, return a response with an error message
      return {'status': 400, 'message': emailError};
    }
    final passwordError = Validator.validatePassword(password);
    if (passwordError != null) { // If there's an error with the password, return a response with an error message
      return {'status': 400, 'message': passwordError};
    }

    // Make a POST request to the login endpoint with the provided email and password
    final response = await http.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    return jsonDecode(response.body);
  } catch (e) {
    // Catch any errors and return a response with the error message
    return {'status': 500, 'message': 'Failed to login: $e'};
  }
}

   static Future<Map<String, dynamic>> getUserDetail(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/details/$userId')); // Send a GET request to the API endpoint with the provided user ID

    if (response.statusCode == 200) { // Check if the response status code is 200 (OK)
      return jsonDecode(response.body); // If successful, return the JSON response
    } else {
      throw Exception('Failed to load user detail'); // If unsuccessful, throw an exception with an error message
    }
  }
   static Future<List<Language>> fetchAvailableLanguages() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api/language'));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((language) => Language.fromJson(language)).toList();
    } else {
      throw Exception('Failed to load languages');
    }
  }

  static Future<void> saveUserLanguage(int userId, int languageId) async {


  // Method to save the user's selected language
    final response = await http.post(
      Uri.parse('$baseUrl/savelanguage'),  // Make sure the URL is correct
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'userId': userId,
        'languageId': languageId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to save user language');
    }
  }
  static Future<List<Lesson>> fetchLessons(int languageId) async {
    final response = await http.get(Uri.parse('$baseUrl/getlessonsbylanguage/$languageId'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((lesson) => Lesson.fromJson(lesson)).toList();
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}

