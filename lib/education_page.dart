import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HygieneAwarenessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water and Sanitation Awareness'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundimg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset('assets/sdg6banner.jpg'),
                  SizedBox(height: 16.0, width: 20000),
                  Text(
                    'Hygiene Issues in Our Community',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Maintaining proper hygiene is crucial for health and well-being. '
                        'However, many communities face challenges in accessing clean water and sanitation facilities. '
                        'Here are some tips to help improve hygiene in our community:',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  _buildTipCard(
                      'Tip', 'Always wash your hands with soap and water.'),
                  _buildTipCard('Tip',
                      'Ensure that drinking water is boiled or filtered.'),
                  _buildTipCard('Tip',
                      'Dispose of waste properly to prevent contamination.'),
                  SizedBox(height: 24.0),
                  Text(
                    'About SDG 6: Clean Water and Sanitation',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'SDG 6 aims to ensure availability and sustainable management of water and sanitation for all. '
                        'Achieving this goal requires everyone’s effort, including yours!',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    icon: Icon(Icons.link),
                    label: Text('Learn More About SDG 6'),
                    onPressed: () => _launchURL(
                        'https://sdgs.un.org/goals/goal6'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'How You Can Help',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  _buildTipCard('Action',
                      'Reduce water wastage by fixing leaks promptly.'),
                  _buildTipCard('Action',
                      'Promote awareness about hygiene in your community.'),
                  _buildTipCard('Action',
                      'Participate in community clean-up campaigns.'),
                  SizedBox(height: 24.0),
                  ElevatedButton.icon(
                    icon: Icon(Icons.public),
                    label: Text('More Resources on Hygiene'),
                    onPressed: () => _launchURL(
                        'https://www.who.int/topics/hygiene/en/'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipCard(String title, String content) {
    return Card(
      color: Colors.white.withOpacity(0.8), // Make cards slightly transparent
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(content, style: TextStyle(fontSize: 16, color: Colors.black)),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
