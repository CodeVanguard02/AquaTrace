import 'dart:async';
import 'dart:convert';

import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.passengerName});

  @override
  _ChatScreenState createState() => _ChatScreenState();
  final String passengerName;
}

class _ChatScreenState extends State<ChatScreen> {
  final List<String> _messages = [];
  List<Map<String, dynamic>> messages = [];
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  Future<void> sendMessage() async {
    try {
      var response = await http.post(
        Uri.parse(''),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "content": _controller.text,
          "time_stamp": " ", // current time or date
          "receiver_id": 1,
          "sender_id": 2
        }),
      );

      var data = json.decode(response.body);
    } catch (e) {
      throw e;
    }
  }

  Future<void> getMessages() async {
    try {
      var response = await http.get(Uri.parse(''));

      var data = json.decode(response.body);

      if (data != null && data.isNotEmpty) {
        if (data['success'] == true) {
          setState(() {
            messages = List<Map<String, dynamic>>.from(data['info']);

            _scrollToBottom();
          });
        }
      }
    } catch (e) {}
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(microseconds: 2),
      curve: Curves.easeOut,
    );
  }

  @override
  void initState() {
    super.initState();
    getMessages();

    Timer.periodic(Duration(milliseconds: 2), (Timer t) => getMessages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Center(
                    child: Icon(
                      CupertinoIcons.person_alt,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Text(
                  ' ', // put the name of the person you are sending message to
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.phone,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: () {},
                ),
                const SizedBox(
                  width: 1.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_vert,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.grey[600],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                var message = messages[index];
                return Column(
                  children: [
                    if (message['sender_id'] != 2)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipPath(
                                clipper: LowerNipMessageClipper(MessageType.receive),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    '${message['content']}',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                        ),
                      ),
                    if (message['sender_id'] == 2)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipPath(
                                clipper: LowerNipMessageClipper(MessageType.send),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[600],
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Text(
                                    '${message['content']}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[600],
                                borderRadius: BorderRadius.circular(6.0)),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.photo, color: Colors.grey[800]),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.grey[800]),
                  onPressed: () {
                    sendMessage();
                    _controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}