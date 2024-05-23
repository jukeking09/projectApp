// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class QuizApi{
//   static const String baseUrl = 'http://10.0.2.2:8000/api';
//   Future<String> fetchQuizContent(int id) async {
//     final response = await http.get(Uri.parse('http://$baseUrl/api/quizzes'));
//     if (response.statusCode == 200) {
//         return jsonDecode(response);
//     else{ 
//       throw Exception('Failed to load quizzes');
//     }
// }