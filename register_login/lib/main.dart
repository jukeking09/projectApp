// import 'package:flutter/gestures.dart';
// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:register_login/admindashboard.dart';
import 'package:register_login/homepage2.dart';
import 'package:register_login/language_select_page.dart';
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
      '/': (context) => const SplashScreen(),
      '/register': (context) => const Register(),
      '/login': (context) => const Login(),
      '/lspage':(context) => LanguageSelectionPage(),
      '/home1': (context) => HomePage1(
          languageId: ModalRoute.of(context)!.settings.arguments as int,
        ),
      '/home': (context) => const HomePage(),
      '/lesson1':(context) => LessonPage(),
      '/quiz':(context) => QuizListScreen(),
      '/quiz1':(context) => QuestionListScreen(),
      '/admindashboard':(context) => AdminDashboard()
    },
  ));
}
