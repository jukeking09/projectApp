import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:register_login/model/language.dart';
import 'package:register_login/model/lesson.dart';
import 'package:register_login/validate.dart'; 



class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Define the base URL of the API
  // int userId = UserIdStorage.getUserId() as int;
  static Future<Map<String, dynamic>> registerUser(String email, String password,
      {required String route}) async {
    final url = Uri.parse('$baseUrl/register'); 

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
      return {'status': 200, 'message': 'User registered successfully'};
    } else if(response.statusCode == 400){
      return {'status': 400, 'message': 'Account with email already exists'};
    } else {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return {'status': response.statusCode, 'message': responseData['message'] ?? 'Registration failed'};
    }
    //return json.decode(response.body);
  }

  static Future<Map<String, dynamic>> loginUser(String email, String password) async {
  final url = Uri.parse('$baseUrl/login'); // Construct the URL for login endpoint

  try {
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
    return jsonDecode(response.body);
  } catch (e) {
    return {'status': 500, 'message': 'Failed to login: $e'};
  }
}

   static Future<Map<String, dynamic>> getUserDetail(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/details/$userId')); 

    if (response.statusCode == 200) { 
      return jsonDecode(response.body); 
    } else {
      throw Exception('Failed to load user detail'); 
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


 
    final response = await http.post(
      Uri.parse('$baseUrl/savelanguage'),  
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

