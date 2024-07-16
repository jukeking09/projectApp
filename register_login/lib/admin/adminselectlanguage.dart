import 'package:flutter/material.dart';
import 'package:register_login/api/api.dart';
import 'package:register_login/model/language.dart';

class SelectLanguagePage extends StatefulWidget {
  @override
  _SelectLanguagePageState createState() => _SelectLanguagePageState();
}

class _SelectLanguagePageState extends State<SelectLanguagePage> {
  List<Language> _languages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLanguages();
  }

  Future<void> _fetchLanguages() async {
    try {
      List<Language> languages = await ApiService.fetchAvailableLanguages();
      setState(() {
        _languages = languages;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching languages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Language'),
        backgroundColor: Colors.blueAccent,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final language = _languages[index];
                return ListTile(
                  title: Text(language.name),
                  onTap: () {
                    Navigator.pushNamed(context, '/managelanguage', arguments: {'languageId': language.id,'languageName' : language.name});

                  },
                );
              },
            ),
    );
  }
}
