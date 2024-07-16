import 'package:flutter/material.dart';
import 'package:register_login/api/api.dart';
import 'package:register_login/model/language.dart';
import 'package:register_login/userid.dart';

class LanguageSelectionPage extends StatefulWidget {
  @override
  _LanguageSelectionPageState createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  late Future<List<Language>> futureLanguages;

  @override
  void initState() {
    super.initState();
    futureLanguages = ApiService.fetchAvailableLanguages();
  }

  void selectLanguage(Language language) async {
  int? userId = await UserIdStorage.getUserId();
  await ApiService.saveUserLanguage(userId!, language.id);
  // ignore: use_build_context_synchronously
  Navigator.pushNamed(
    context,
    '/home1',
    arguments: language.id, // Pass the language ID directly
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome To ByeLingual'),
      ),
      body: FutureBuilder<List<Language>>(
        future: futureLanguages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No languages available'));
          } else {
            List<Language> languages = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Select a language to start learning:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: languages.length,
                      itemBuilder: (context, index) {
                        Language language = languages[index];
                        return ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blueAccent,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () => selectLanguage(language),
                          child: Text(
                            language.name,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
