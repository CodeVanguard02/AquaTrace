// internet_issues_page.dart
import 'package:flutter/material.dart';

class InternetIssuesPage extends StatefulWidget {
  @override
  _InternetIssuesPageState createState() => _InternetIssuesPageState();
}

class _InternetIssuesPageState extends State<InternetIssuesPage> {
  final _postController = TextEditingController();
  final _commentController = TextEditingController();

  List<Post> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Internet Issues'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _postController,
              decoration: InputDecoration(
                labelText: 'Post about an internet issue',
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
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  return PostCard(
                    post: _posts[index],
                    onComment: _submitComment,
                    onDelete: _deletePost,
                    commentController: _commentController,
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
    final post = Post(
      id: _posts.length + 1,
      message: _postController.text,
      timestamp: DateTime.now(),
      comments: [],
    );
    setState(() {
      _posts.add(post);
      _postController.clear();
    });
  }

  void _submitComment(Post post, String comment) {
    final newComment = Comment(
      id: post.comments.length + 1,
      message: comment,
      timestamp: DateTime.now(),
    );
    setState(() {
      post.comments.add(newComment);
      _commentController.clear();
    });
  }

  void _deletePost(Post post) {
    setState(() {
      _posts.remove(post);
    });
  }
}

class Post {
  final int id;
  final String message;
  final DateTime timestamp;
  final List<Comment> comments;

  Post({required this.id, required this.message, required this.timestamp, required this.comments});
}

class Comment {
  final int id;
  final String message;
  final DateTime timestamp;

  Comment({required this.id, required this.message, required this.timestamp});
}

class PostCard extends StatelessWidget {
  final Post post;
  final Function(Post, String) onComment;
  final Function(Post) onDelete;
  final TextEditingController commentController;

  PostCard({required this.post, required this.onComment, required this.onDelete, required this.commentController});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.message,
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Posted at ${post.timestamp.toString()}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: commentController,
              decoration: InputDecoration(
                labelText: 'Comment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onComment(post, commentController.text);
              },
              child: Text('Comment'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onDelete(post);
              },
              child: Text('Delete Post'),
            ),
            SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              itemCount: post.comments.length,
              itemBuilder: (context, index) {
                return CommentCard(
                  comment: post.comments[index],
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
              comment.message,
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Commented at ${comment.timestamp.toString()}',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
