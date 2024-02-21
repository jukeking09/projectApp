import 'package:flutter/material.dart';
import 'dart:async';
import 'package:register_login/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulating a delay using Future.delayed
    // You can replace this with your initialization logic
    Timer(const Duration(seconds: 3), () {
      // Navigating to the next screen after 3 seconds
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const Register(), // Replace HomeScreen with your desired screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 246, 241, 236), // Customize splash screen background color
      body: Center(
        child: 
        Image.asset(
          'images/logo.png',
          width: 200,
          height: 200,
        ), // Customize splash screen content
      ),
    );
  }
}
