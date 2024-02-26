import 'dart:convert'; // Import the dart:convert library to use JSON encoding and decoding
import 'package:http/http.dart' as http; // Import the http package with a prefix `http` to avoid conflicts
import 'package:register_login/validate.dart'; // Import the validation functions from another file

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8000/api'; // Define the base URL of the API

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

      // If the request is successful (status code 200), extract user ID and email from the response
      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final int userId = responseData['user']['id']; // Extract user ID
        final String userEmail = responseData['user']['email']; // Extract user email

        // Add user ID and email to the response data
        responseData['userId'] = userId;
        responseData['email'] = userEmail;

        // Return the modified response data
        return responseData;
      } else {
        // If the request is not successful, throw an exception with the reason
        throw Exception('Failed to login: ${response.reasonPhrase}');
      }
    } catch (e) {
      // Catch any errors and throw an exception
      throw Exception('Failed to login: $e');
    }
  }

  // Function to get user details by user ID
  static Future<Map<String, dynamic>> getUserDetails(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/details/$userId')); // Make a GET request to get user details

    // Check if the response status code is 200 (OK)
    if (response.statusCode == 200) {
      // If the response is successful, parse the JSON response body
      return json.decode(response.body);
    } else {
      // If the response is not successful, throw an exception with a failure message
      throw Exception('Failed to load user details');
    }
  }
}
