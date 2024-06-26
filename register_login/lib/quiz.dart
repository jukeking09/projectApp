// // lib/screens/quiz_list_screen.dart
// import 'package:flutter/material.dart';


// class QuizListScreen extends StatefulWidget {
//   @override
//   _QuizListScreenState createState() => _QuizListScreenState();
// }

// class _QuizListScreenState extends State<QuizListScreen> {
//   List quizzes = [];

//   @override
//   // void initState() {
//   //   super.initState();
//   //   fetchQuizzes();
//   // }

//   // Future<void> fetchQuizzes() async {
    
//   // }
  
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Quizzes'),
//       ),
//       body: GridView.count(
//         crossAxisCount: 1, // Number of columns in the grid
//         children: const [
//           QuizCard(title: 'Quiz 1', subtitle: 'Basic Quiz'),
//           QuizCard(title: 'Quiz 2', subtitle: 'Intermediate Quiz'),
//           // Add more LessonCard widgets for additional lessons
//         ],
//       ),
//     );
//   }
  
//   // Widget build(BuildContext context) {
//   //   return Scaffold(
//   //     appBar: AppBar(
//   //       title: Text('Quizzes'),
//   //     ),
//   //     body: quizzes.isEmpty
//   //         ? Center(child: CircularProgressIndicator())
//   //         : ListView.builder(
//   //             itemCount: quizzes.length,
//   //             itemBuilder: (context, index) {
//   //               return ListTile(
//   //                 title: Text(quizzes[index]['quiz_title']),
//   //               );
//   //             },
//   //           ),
//   //   );
//   // }
// }
// class QuizCard extends StatelessWidget {
//   final String title;
//   final String subtitle;

//   const QuizCard({
//     super.key,
//     required this.title,
//     required this.subtitle,
//   });
  
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.all(10),
//       child: InkWell(
//         onTap: () {
//           Navigator.pushNamed(context, '/quiz1');
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(40),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 subtitle,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }