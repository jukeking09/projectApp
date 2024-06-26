// import 'package:flutter/material.dart';
// import 'package:register_login/api/quizapi.dart';
// import 'package:register_login/model/quiz.dart';
// import 'package:register_login/question_screen.dart';


// class QuizPage extends StatefulWidget {
//   @override
//   _QuizPageState createState() => _QuizPageState();
// }

// class _QuizPageState extends State<QuizPage> {
//   final QuizApi _api = QuizApi();
//   List<Quiz> _quizzes = [];
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchQuizzes();
//   }

//   Future<void> _fetchQuizzes() async {
//     try {
//       List<Quiz> quizzes = await _api.fetchQuizById();
//       setState(() {
//         _quizzes = quizzes;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _quizzes = [];
//       });
//       print('Error fetching quizzes: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quizzes'),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : _quizzes.isEmpty
//               ? Center(child: Text('No quizzes available'))
//               : ListView.builder(
//                   itemCount: _quizzes.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(_quizzes[index].title),
//                       subtitle: Text(_quizzes[index].description),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => QuestionScreen(quiz: _quizzes[index]),
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//     );
//   }
// }
