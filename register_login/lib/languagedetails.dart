import 'package:flutter/material.dart';
import 'package:register_login/api/userapi.dart';
import 'package:register_login/model/language.dart';
import 'package:register_login/model/lessondetails.dart';
import 'package:register_login/model/quizscore.dart';

class LanguageDetailsPage extends StatelessWidget {
  final int userId;
  final int languageId;

  const LanguageDetailsPage({Key? key, required this.userId, required this.languageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Details'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder<List<LessonDetails>>(
            future: UserApiService.fetchLessonDetails(userId, languageId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No lesson details available'));
              } else {
                List<LessonDetails> lessons = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Completed Lessons:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: lessons.length,
                      itemBuilder: (context, index) {
                        LessonDetails lesson = lessons[index];
                        return ListTile(
                          title: Text(lesson.lessonTitle),
                          subtitle: Text('Completed: ${lesson?.isCompleted == 0 ? "No" : "Yes"}'),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
          SizedBox(height: 16),
          FutureBuilder<List<QuizScore>>(
            future: UserApiService.fetchQuizScores(userId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No quiz scores available'));
              } else {
                List<QuizScore> quizScores = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quiz Scores:',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: quizScores.length,
                      itemBuilder: (context, index) {
                        QuizScore score = quizScores[index];
                        return ListTile(
                          title: Text('Quiz ${score.quizId.toString()}'),
                          subtitle: Text('Score: ${score.score}'),
                        );
                      },
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
