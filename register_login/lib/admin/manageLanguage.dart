import 'package:flutter/material.dart';

class ManageLanguagePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final languageId = args != null ? args['languageId']as int : null;
    final languageName = args != null? args['languageName']as String: null;
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Language'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Manage Content for Language $languageName',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            _buildButton(context, 'Add New Lesson', '/addlesson', languageId),
            SizedBox(height: 10),
            _buildButton(context, 'Add New Quiz', '/addquizzes', languageId),
            SizedBox(height: 10),
            // _buildButton(context, 'Add New Questions', '/addquestions', languageId),
            
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, String route, int? languageId) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route, arguments: {'languageId': languageId});
      },
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        textStyle: TextStyle(fontSize: 18),
        primary: const Color.fromARGB(255, 203, 216, 237),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: Text(text),
    );
  }
}
