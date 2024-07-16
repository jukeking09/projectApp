import 'package:flutter/material.dart';
// import 'package:register_login/addLanguage.dart';
// import 'package:register_login/addLesson.dart';
// import 'package:register_login/addQuestion.dart';
// import 'package:register_login/addQuiz.dart';
import 'package:register_login/admin/addLanguage.dart';
import 'package:register_login/admin/addLesson.dart';
import 'package:register_login/admin/addQuestion.dart';
import 'package:register_login/admin/addQuiz.dart';
import 'package:register_login/admin/admindashboard.dart';
import 'package:register_login/admin/adminselectlanguage.dart';
import 'package:register_login/admin/manageLanguage.dart';
import 'package:register_login/admin/manageusers.dart';
// import 'package:register_login/admindashboard.dart';
// import 'package:register_login/adminselectlanguage.dart';
import 'package:register_login/homepage2.dart';
import 'package:register_login/homepage3.dart';
import 'package:register_login/language_select_page.dart';
import 'package:register_login/lesson1.dart';
import 'package:register_login/lesson2.dart';
import 'package:register_login/lessonwithaudio.dart';
import 'package:register_login/login_page.dart';
// import 'package:register_login/manageLanguage.dart';
import 'package:register_login/pronunciation2.dart';
import 'package:register_login/pronuncitiation1.dart';
import 'package:register_login/question_screen.dart';
// import 'package:register_login/quiz.dart';
// import 'package:register_login/quiz1.dart';
//import 'package:register_login/api/api.dart';
import 'package:register_login/splash.dart';
// import 'package:register_login/home.dart';
import 'package:register_login/register.dart';
import 'package:register_login/tokens.dart';



Future<void> main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.red,
      scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255), // Change scaffold background color to red
    ),
    // initialRoute: await AuthTokenStorage.hasToken() ? '/home1' : '/login',
    // home: const HomePage(),
    routes: {
      '/': (context) => const SplashScreen(),
      '/register': (context) => const Register(),
      '/login': (context) => const Login(),
      '/lspage':(context) => LanguageSelectionPage(),
      '/home1': (context) => HomePage2(
          languageId: ModalRoute.of(context)!.settings.arguments as int,
        ),
      // '/home': (context) => const HomePage(),
      '/lesson1':(context) => Lesson2Page(),
      // '/quiz':(context) => QuizListScreen(),
      // '/quiz1':(context) => QuizPage(),
      '/admindashboard':(context) => AdminDashboard(),
      '/selectlanguage':(context) => SelectLanguagePage(),
      '/addlanguage':(context) => AddLanguagePage(),
      '/managelanguage':(context) => ManageLanguagePage(),
      '/questions':(context) => QuestionScreen(),
      '/addlesson': (context) => AddLessonPage(),
      '/addquizzes': (context) => AddQuizPage(),
      // '/addquestions': (context) => AddQuestionPage(),
      '/pronunciation1': (context) => PronunciationPage1(),
      '/pronunciation2': (context) => PronunciationPage2(),
      '/manageuser':(context)=> ManageUsersPage(),
    },
  ));
}
