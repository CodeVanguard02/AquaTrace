import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting timestamps

class PostAdvicePage extends StatefulWidget {
  @override
  _PostAdvicePageState createState() => _PostAdvicePageState();
}

class _PostAdvicePageState extends State<PostAdvicePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _adviceController = TextEditingController();
  final _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Advice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Advice Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _adviceController,
                decoration: InputDecoration(
                  labelText: 'Advice',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an advice';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category (e.g. Environment, Health, Finance)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitAdvice,
                child: Text('Post Advice'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitAdvice() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final advice = Advice(
        title: _titleController.text,
        advice: _adviceController.text,
        category: _categoryController.text,
        timestamp: DateTime.now(),
      );
      // Add the advice to the database or API here
      print('Advice posted: $advice');
      _titleController.clear();
      _adviceController.clear();
      _categoryController.clear();
    }
  }
}

class Advice {
  final String title;
  final String advice;
  final String category;
  final DateTime timestamp;

  Advice({required this.title, required this.advice, required this.category, required this.timestamp});
}

// Example advices
List<Advice> _advices = [
  Advice(
    title: 'Save Water',
    advice: 'Turn off the tap while brushing your teeth to save up to 4 gallons of water per day.',
    category: 'Environment',
    timestamp: DateTime.parse('2023-03-01 14:30:00'),
  ),
  Advice(
    title: 'Reduce Electricity Bill',
    advice: 'Turn off lights, electronics, and appliances when not in use to reduce your electricity bill.',
    category: 'Finance',
    timestamp: DateTime.parse('2023-04-10 10:00:00'),
  ),
];