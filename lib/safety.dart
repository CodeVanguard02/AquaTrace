import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CrimeWarningPage extends StatefulWidget {
  @override
  _CrimeWarningPageState createState() => _CrimeWarningPageState();
}

class _CrimeWarningPageState extends State<CrimeWarningPage> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();
  List<Comment> _comments = [
    Comment(
      text: "Be careful walking alone at night on Main St, I saw a suspicious person lurking around.",
      location: '123 Main St',
      timestamp: DateTime.parse('2024-02-15 22:45:00'),
    ),
    Comment(
      text: "There was a burglary on Elm St last night, make sure to lock your doors and windows.",
      location: '456 Elm St',
      timestamp: DateTime.parse('2024-02-16 08:00:00'),
    ),
    Comment(
      text: "I saw a group of teenagers vandalizing cars on Oak St, be careful parking in that area.",
      location: '789 Oak St',
      timestamp: DateTime.parse('2024-02-17 15:30:00'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crime Warnings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _commentController,
                    decoration: InputDecoration(
                      labelText: 'Leave a warning',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a warning';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _submitComment,
                    child: Text('Post Warning'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            _comments.isEmpty
                ? Text('No warnings posted yet.')
                : ListView.builder(
              shrinkWrap: true,
              itemCount: _comments.length,
              itemBuilder: (context, index) {
                return CommentCard(
                  comment: _comments[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _submitComment() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final comment = Comment(
        text: _commentController.text,
        location: '123 Main St', // get current location
        timestamp: DateTime.now(),
      );
      setState(() {
        _comments.add(comment);
      });
      _commentController.clear();
    }
  }
}

class Comment {
  final String text;
  final String location;
  final DateTime timestamp;

  Comment(
      {required this.text, required this.location, required this.timestamp});
}

class CommentCard extends StatelessWidget {
  final Comment comment;

  CommentCard({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.text,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Location: ${comment.location}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Posted: ${DateFormat.yMMMd().add_Hms().format(
                  comment.timestamp)}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}