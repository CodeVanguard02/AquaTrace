import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting timestamps
import 'package:geolocator/geolocator.dart'; // for getting user location

class ElectricityIssuePage extends StatefulWidget {
  @override
  _ElectricityIssuePageState createState() => _ElectricityIssuePageState();
}

class _ElectricityIssuePageState extends State<ElectricityIssuePage> {
  final _postController = TextEditingController();

  List<ElectricityIssuePost> _electricityIssuePosts = [
    ElectricityIssuePost(
      id: 1,
      message: 'Power outage in San Francisco',
      location: 'San Francisco',
      timestamp: DateTime.parse('2023-03-01 14:30:00'),
      comments: [
        ElectricityIssueComment(
          id: 1,
          message: 'I\'m stuck in the dark!',
          location: 'Fisherman\'s Wharf',
          timestamp: DateTime.parse('2023-03-01 14:45:00'),
        ),
        ElectricityIssueComment(
          id: 2,
          message: 'Check your circuit breakers!',
          location: 'Haight-Ashbury',
          timestamp: DateTime.parse('2023-03-01 15:00:00'),
        ),
      ],
    ),
    ElectricityIssuePost(
      id: 2,
      message: 'High voltage in Chicago',
      location: 'Chicago',
      timestamp: DateTime.parse('2023-04-10 10:00:00'),
      comments: [
        ElectricityIssueComment(
          id: 1,
          message: 'Be careful with your appliances!',
          location: 'The Loop',
          timestamp: DateTime.parse('2023-04-10 10:30:00'),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Electricity Issues'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _postController,
              decoration: InputDecoration(
                labelText: 'Post about an electricity issue',
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
                itemCount: _electricityIssuePosts.length,
                itemBuilder: (context, index) {
                  return ElectricityIssuePostCard(
                    post: _electricityIssuePosts[index],
                    onComment: _submitComment,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitPost() async {
    final post = ElectricityIssuePost(
      id: _electricityIssuePosts.length + 1,
      message: _postController.text,
      location: await _getCurrentLocation(),
      timestamp: DateTime.now(),
      comments: [],
    );
    setState(() {
      _electricityIssuePosts.add(post);
      _postController.clear();
    });
  }

  void _submitComment(ElectricityIssuePost post, String comment) async {
    final commentLocation = await _getCurrentLocation();
    final commentTimestamp = DateTime.now();
    final newComment = ElectricityIssueComment(
      id: post.comments.length + 1,
      message: comment,
      location: commentLocation,
      timestamp: commentTimestamp,
    );
    setState(() {
      post.comments.add(newComment);
    });
  }

  Future<String> _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return '${position.latitude}, ${position.longitude}';
  }
}

class ElectricityIssuePost {
  final int id;
  final String message;
  final String location;
  final DateTime timestamp;
  final List<ElectricityIssueComment> comments;

  ElectricityIssuePost({required this.id, required this.message, required this.location, required this.timestamp, required this.comments});
}

class ElectricityIssueComment {
  final int id;
  final String message;
  final String location;
  final DateTime timestamp;

  ElectricityIssueComment({required this.id, required this.message, required this.location, required this.timestamp});
}

class ElectricityIssuePostCard extends StatefulWidget {
  final ElectricityIssuePost post;
  final Function(ElectricityIssuePost, String) onComment;

  ElectricityIssuePostCard({required this.post, required this.onComment});

  @override
  _ElectricityIssuePostCardState createState() => _ElectricityIssuePostCardState();
}

class _ElectricityIssuePostCardState extends State<ElectricityIssuePostCard> {
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
            Text(
              'Location: ${widget.post.location}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Timestamp: ${DateFormat.yMMMd().add_Hms().format(widget.post.timestamp)}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Comment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onComment(widget.post, _commentController.text);
                _commentController.clear();
              },
              child: Text('Comment'),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.post.comments.length,
              itemBuilder: (context, index) {
                return CommentCard(
                  comment: widget.post.comments[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  final ElectricityIssueComment comment;

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
              comment.message,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Location: ${comment.location}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              'Timestamp: ${DateFormat.yMMMd().add_Hms().format(comment.timestamp)}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
