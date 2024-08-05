import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting timestamps
import 'package:image_picker/image_picker.dart'; // for image picking
import 'dart:io'; // for file handling

class PostGoodVibesPage extends StatefulWidget {
  @override
  _PostGoodVibesPageState createState() => _PostGoodVibesPageState();
}

class _PostGoodVibesPageState extends State<PostGoodVibesPage> {
  final _formKey = GlobalKey<FormState>();
  final _messageController = TextEditingController();
  File? _image; // for storing the image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Good Vibes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    labelText: 'Share your good vibes...',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a message';
                    }
                    return null;
                  },
                  maxLines: 5,
                ),
                SizedBox(height: 16),
                // Add a button to upload an image
                ElevatedButton(
                  onPressed: _selectImage,
                  child: Text('Add an image'),
                ),
                SizedBox(height: 16),
                // Display the uploaded image
                _image != null
                    ? Image.file(_image!)
                    : Text('No image uploaded'),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitPost,
                  child: Text('Post Good Vibes'),
                ),
                SizedBox(height: 32),
                // Displaying the list of good vibes posts
                Text('Good Vibes Posts', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
                _buildGoodVibesPostsList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  void _submitPost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final post = GoodVibesPost(
        message: _messageController.text,
        image: _image,
        timestamp: DateTime.now(),
      );
      // Add the post to the database or API here
      print('Good vibes posted: $post');
      _messageController.clear();
      setState(() {
        _image = null;
        _goodVibesPosts.add(post); // Adding the post to the list
      });
    }
  }

  Widget _buildGoodVibesPostsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _goodVibesPosts.length,
      itemBuilder: (context, index) {
        final post = _goodVibesPosts[index];
        return Card(
          child: ListTile(
            title: Text(post.message),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Posted on: ${DateFormat.yMMMd().add_jm().format(post.timestamp)}'),
                if (post.image != null)
                  Image.file(post.image!),
              ],
            ),
          ),
        );
      },
    );
  }
}

class GoodVibesPost {
  final String message;
  final File? image;
  final DateTime timestamp;

  GoodVibesPost({
    required this.message,
    this.image,
    required this.timestamp,
  });
}

// Example good vibes posts
List<GoodVibesPost> _goodVibesPosts = [
  GoodVibesPost(
    message: 'You got this!',
    image: null,
    timestamp: DateTime.parse('2023-03-01 14:30:00'),
  ),
  GoodVibesPost(
    message: 'Believe in yourself!',
    image: null,
    timestamp: DateTime.parse('2023-04-10 10:00:00'),
  ),
];
