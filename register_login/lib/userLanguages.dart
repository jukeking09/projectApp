import 'package:flutter/material.dart';
import 'package:register_login/api/userapi.dart';
import 'package:register_login/languagedetails.dart';
import 'package:register_login/model/language.dart';

class UserLanguagesPage extends StatelessWidget {
  final int userId;

  const UserLanguagesPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Languages'),
      ),
      body: FutureBuilder<List<Language>>(
        future: UserApiService.fetchLanguagesByUserId(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No languages available'));
          } else {
            List<Language> languages = snapshot.data!;
            return ListView.builder(
              itemCount: languages.length,
              itemBuilder: (context, index) {
                Language language = languages[index];
                return ListTile(
                  title: Text(language.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageDetailsPage(userId: userId, languageId: language.id),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}