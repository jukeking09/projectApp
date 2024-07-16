// import 'package:flutter/material.dart';
// import 'package:register_login/api/adminapi.dart';


// class AddQuestionPage extends StatefulWidget {
//   @override
//   _AddQuestionPageState createState() => _AddQuestionPageState();
// }

// class _AddQuestionPageState extends State<AddQuestionPage> {
//   final _formKey = GlobalKey<FormState>();
//   String _questionText = '';
//   List<String> _choices = ['', '', '', ''];
//   String _correctAnswer = '';
//   int? _selectedQuizId;
//   List<dynamic> _quizzes = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchQuizzes();
//   }

//   void _fetchQuizzes() async {
//     try {
//       final quizzes = await AdminApiService.getQuizzes();
//       setState(() {
//         _quizzes = quizzes;
//       });
//     } catch (e) {
//       print('Failed to load quizzes: $e');
//     }
//   }

//   void _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       if (_selectedQuizId == null) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please select a quiz')));
//         return;
//       }
//       final response = await AdminApiService.addQuestion(_selectedQuizId!, _questionText, _choices, _correctAnswer);
//       if (response['status'] == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Question added successfully')));
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add question')));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Question'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               if (_quizzes.isNotEmpty)
//                 DropdownButtonFormField<int>(
//                   decoration: InputDecoration(labelText: 'Select Quiz'),
//                   items: _quizzes.map((quiz) {
//                     return DropdownMenuItem<int>(
//                       value: quiz['id'],
//                       child: Text(quiz['title']),
//                     );
//                   }).toList(),
//                   onChanged: (value) {
//                     setState(() {
//                       _selectedQuizId = value;
//                     });
//                   },
//                   validator: (value) => value == null ? 'Please select a quiz' : null,
//                 ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Question Text'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the question text';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _questionText = value!;
//                 },
//               ),
//               for (int i = 0; i < _choices.length; i++)
//                 TextFormField(
//                   decoration: InputDecoration(labelText: 'Choice ${i + 1}'),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter choice ${i + 1}';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _choices[i] = value!;
//                   },
//                 ),
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Correct Answer'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the correct answer';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _correctAnswer = value!;
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _submitForm,
//                 child: Text('Save Question'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
