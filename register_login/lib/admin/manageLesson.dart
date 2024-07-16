// import 'package:flutter/material.dart';

// class ManageLessonsPage extends StatelessWidget {
//   final int languageId;
//   final int lessonId;

//   ManageLessonsPage({required this.languageId, required this.lessonId});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Manage Lessons'),
//         backgroundColor: Colors.blueAccent,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Text(
//               'Manage Lesson $lessonId for Language $languageId',
//               style: TextStyle(
//                 fontSize: 24.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.blueAccent,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
           
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/addQuiz', arguments: {'lessonId': lessonId});
//               },
//               child: Text('Add New Quiz'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
