import 'package:flutter/material.dart';
import 'package:register_login/api/lessonapi.dart';


class LessonPage extends StatefulWidget {
  @override
  _LessonPageState createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  final LessonPageApi _api = LessonPageApi();
  String _lessonContent = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLessonContent();
  }

  Future<void> _fetchLessonContent() async {
    try {
      String content = await _api.fetchLessonContent();
      setState(() {
        _lessonContent = content;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle error (e.g., show error message to user)
      print('Error fetching lesson content: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Lesson'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Text(
                  _lessonContent,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
    );
  }
}
