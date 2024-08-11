import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting timestamps
import 'package:geolocator/geolocator.dart'; // for getting user location
import 'package:geocoding/geocoding.dart'; // for reverse geocoding

class WeatherIssuePage extends StatefulWidget {
  @override
  _WeatherIssuePageState createState() => _WeatherIssuePageState();
}

class _WeatherIssuePageState extends State<WeatherIssuePage> {
  final _postController = TextEditingController();
  String _currentCity = '';

  List<WeatherIssuePost> _weatherIssuePosts = [
    WeatherIssuePost(
      id: 1,
      message: 'Heavy rain in New York City',
      location: 'New York City',
      timestamp: DateTime.parse('2023-03-01 14:30:00'),
      comments: [
        WeatherIssueComment(
          id: 1,
          message: 'I\'m stuck in traffic!',
          location: 'Manhattan',
          timestamp: DateTime.parse('2023-03-01 14:45:00'),
        ),
        WeatherIssueComment(
          id: 2,
          message: 'Be careful out there!',
          location: 'Brooklyn',
          timestamp: DateTime.parse('2023-03-01 15:00:00'),
        ),
      ],
    ),
    WeatherIssuePost(
      id: 2,
      message: 'Heatwave in Los Angeles',
      location: 'Los Angeles',
      timestamp: DateTime.parse('2023-04-10 10:00:00'),
      comments: [
        WeatherIssueComment(
          id: 1,
          message: 'Stay hydrated!',
          location: 'Santa Monica',
          timestamp: DateTime.parse('2023-04-10 10:30:00'),
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentCity();
  }

  Future<void> _getCurrentCity() async {
    try {
      final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        setState(() {
          _currentCity = placemarks.first.locality ?? '';
        });
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Issues'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _postController,
              decoration: InputDecoration(
                labelText: 'Post about a weather issue',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submitPost,
              child: Text('Post'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _weatherIssuePosts.length,
                itemBuilder: (context, index) {
                  return WeatherIssuePostCard(
                    post: _weatherIssuePosts[index],
                    onComment: _submitComment,
                    onDelete: _deletePost,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPost() {
    final post = WeatherIssuePost(
      id: _weatherIssuePosts.length + 1,
      message: _postController.text,
      location: _currentCity,
      timestamp: DateTime.now(),
      comments: [],
    );
    setState(() {
      _weatherIssuePosts.add(post);
      _postController.clear();
    });
  }

  void _submitComment(WeatherIssuePost post, String comment) {
    final commentTimestamp = DateTime.now();
    final newComment = WeatherIssueComment(
      id: post.comments.length + 1,
      message: comment,
      location: _currentCity,
      timestamp: commentTimestamp,
    );
    setState(() {
      post.comments.add(newComment);
    });
  }

  void _deletePost(int postId) {
    setState(() {
      _weatherIssuePosts.removeWhere((post) => post.id == postId);
    });
  }
}

class WeatherIssuePost {
  final int id;
  final String message;
  final String location;
  final DateTime timestamp;
  final List<WeatherIssueComment> comments;

  WeatherIssuePost({required this.id, required this.message, required this.location, required this.timestamp, required this.comments});
}

class WeatherIssueComment {
  final int id;
  final String message;
  final String location;
  final DateTime timestamp;

  WeatherIssueComment({required this.id, required this.message, required this.location, required this.timestamp});
}

class WeatherIssuePostCard extends StatefulWidget {
  final WeatherIssuePost post;
  final Function(WeatherIssuePost, String) onComment;
  final Function(int) onDelete;

  WeatherIssuePostCard({required this.post, required this.onComment, required this.onDelete});

  @override
  _WeatherIssuePostCardState createState() => _WeatherIssuePostCardState();
}

class _WeatherIssuePostCardState extends State<WeatherIssuePostCard> {
  final _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.message,
              style: TextStyle(fontSize: 18),
            ),
            Text('Location: ${widget.post.location}'),
            Text('Posted on: ${DateFormat.yMMMd().add_jm().format(widget.post.timestamp)}'),
            SizedBox(height: 8),
            ...widget.post.comments.map((comment) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    comment.message,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text('Location: ${comment.location}'),
                  Text('Commented on: ${DateFormat.yMMMd().add_jm().format(comment.timestamp)}'),
                ],
              ),
            )),
            TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add a comment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                widget.onComment(widget.post, _commentController.text);
                _commentController.clear();
              },
              child: Text('Comment'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                widget.onDelete(widget.post.id);
              },
              child: Text('Delete Post'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red color for delete button
              ),
            ),
          ],
        ),
      ),
    );
  }
}
