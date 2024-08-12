import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mysql1/mysql1.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  final _picker = ImagePicker();

  void _logSupportTicket(BuildContext context) {
    final String email = 'shabalalamasibonge@gmail.com';
    print('Support ticket logged for email: $email');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chat Support'),
          content: const Text('A support ticket has been logged. You will be connected with an assistant shortly.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _updatePin() async {
    final conn = await MySqlConnection.connect(ConnectionSettings(
      host: 'your_host', // Replace with your MySQL host
      port: 3306,
      user: 'your_username', // Replace with your MySQL username
      db: 'your_database', // Replace with your MySQL database name
      password: 'your_password', // Replace with your MySQL password
    ));

    await conn.query(
        'UPDATE users SET pin = ? WHERE email = ?',
        ['new_pin', 'shabalalamasibonge@gmail.com'] // Replace with the actual new PIN and user's email
    );

    await conn.close();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _imageFile != null
                        ? FileImage(_imageFile!)
                        : AssetImage('assets/profileplaceholder.png') as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: _pickImage,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Masibonge', // Replace with logged-in user's name
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Update PIN'),
              onTap: () async {
                // Update PIN logic
                print('Update PIN');
                await _updatePin();
                print('PIN updated');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                _launchURL('https://aquatraceprivacypolicy.vercel.app/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Terms and Conditions'),
              onTap: () {
                _launchURL('https://aquatrace-ts-cs.vercel.app/');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Profile Management'),
              onTap: () {
                print('Navigate to Profile Management');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Account'),
              onTap: () {
                print('Delete account');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignInPage()),
                      (route) => false,
                );
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.feedback),
              title: Text('Feedback'),
              onTap: () {
                print('Navigate to Feedback');
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('Chat Support'),
              onTap: () {
                _logSupportTicket(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
