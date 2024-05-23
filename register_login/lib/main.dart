// import 'package:flutter/gestures.dart';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:register_login/admindashboard.dart';
import 'package:register_login/dashboard.dart';
import 'package:register_login/lesson1.dart';
import 'package:register_login/login_page.dart';
import 'package:register_login/quiz.dart';
import 'package:register_login/quiz1.dart';
// import 'package:register_login/api/api.dart';
import 'package:register_login/splash.dart';
import 'package:register_login/home.dart';
import 'package:register_login/register.dart';



void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255), // Change scaffold background color to red
    ),
    // initialRoute: '/splashscreen',
    // home: const HomePage(),
    routes: {
      '/': (context) => SplashScreen(),
      '/register': (context) => const Register(),
      '/login': (context) => const Login(),
      '/home': (context) => HomePage(),
      '/dashboard': (context) => Dashboard(),
      '/lesson1':(context) => LessonPage(),
      '/quiz':(context) => QuizListScreen(),
      '/quiz1':(context) => QuestionListScreen(),
      '/admindashboard':(context) => AdminDashboard()
    },
  ));
}

// class Register extends StatefulWidget {
//   const Register({Key? key}) : super(key: key);

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   void registerUser() async {
//     final email = _emailController.text;
//     final password = _passwordController.text;
//     final response = await ApiService.registerUser(email, password, route: '');
//     if (response['status'] == 200) {
//       // ignore: use_build_context_synchronously
//       Navigator.pushNamed(context, '/login');
//     } else {
//       // ignore: use_build_context_synchronously
//       showDialog(
//         context: context,
//         builder: (context) {
//           return AlertDialog(
//             title: const Text('Registration Failed'),
//             content: Text(response['message']),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Register'),
//         backgroundColor: Color.fromARGB(255, 224, 3, 102),
//         elevation: 0, // Remove app bar elevation
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               'Register',
//               style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               style: const TextStyle(color: Colors.white),
//               controller: _emailController,
//               decoration: InputDecoration(
//                 hintText: 'Email',
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 prefixIcon: const Icon(Icons.email, color: Colors.white),
//                 filled: true,
//                 fillColor: Color.fromARGB(219, 106, 103, 103), // Change input field color
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             TextField(
//               style: const TextStyle(color: Colors.white),
//               controller: _passwordController,
//               obscureText: true,
//               decoration: InputDecoration(
//                 hintText: 'Password',
//                 hintStyle: const TextStyle(color: Colors.grey),
//                 prefixIcon: const Icon(Icons.lock, color: Colors.white),
//                 filled: true,
//                 fillColor: Color.fromARGB(219, 106, 103, 103), // Change input field color
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: registerUser,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.white, // Change button color
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//               ),
//               child: const Text(
//                 'Register',
//                 style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 84, 44, 228)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             RichText(
//               text: TextSpan(
//                 text: 'Already have an account? Click here to login',
//                 style: const TextStyle(color: Colors.grey),
//                 recognizer: TapGestureRecognizer()
//                   ..onTap = () {
//                     Navigator.pushNamed(context, '/login');
//                   },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
