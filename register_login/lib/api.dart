import 'dart:convert'; // Import the dart:convert library to use JSON encoding and decoding
import 'package:http/http.dart' as http; // Import the http package with a prefix `http` to avoid conflicts
// import 'package:register_login/userid.dart';
import 'package:register_login/validate.dart'; // Import the validation functions from another file



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
}
