import 'package:flutter/material.dart';
import 'package:register_login/api/adminapi.dart';


class AddLanguagePage extends StatefulWidget {
  @override
  _AddLanguagePageState createState() => _AddLanguagePageState();
}

class _AddLanguagePageState extends State<AddLanguagePage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await AdminApiService.addLanguage(_name);
      if (response['status'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Language added successfully')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to add language')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Language'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Language Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Save Language'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
