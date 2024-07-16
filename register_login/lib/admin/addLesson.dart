import 'package:flutter/material.dart';
import 'package:register_login/api/adminapi.dart';

class AddLessonPage extends StatefulWidget {
  @override
  _AddLessonPageState createState() => _AddLessonPageState();
}

class _AddLessonPageState extends State<AddLessonPage> {
  final TextEditingController _lessonTitleController = TextEditingController();
  final TextEditingController _lessonDescriptionController = TextEditingController();
  final TextEditingController _lessonContentController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _addLesson(int languageId) async {
    if (_lessonTitleController.text.isEmpty &&
        _lessonDescriptionController.text.isEmpty &&
        _lessonContentController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please fill in all fields')));
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final response = await AdminApiService.addLesson(
      languageId,
      _lessonTitleController.text,
      _lessonDescriptionController.text,
      _lessonContentController.text,
    );

    setState(() {
      _isSubmitting = false;
    });

    if (response['status'] == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lesson added successfully')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response['message'] ?? 'Failed to add lesson')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final languageId = args != null ? args['languageId'] as int : null;

    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Lesson'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Add Lesson for Language $languageId',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _lessonTitleController,
                decoration: InputDecoration(
                  labelText: 'Lesson Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _lessonDescriptionController,
                decoration: InputDecoration(
                  labelText: 'Lesson Description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _lessonContentController,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'Lesson Content',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSubmitting ? null : () => _addLesson(languageId!),
                child: _isSubmitting ? CircularProgressIndicator() : Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
