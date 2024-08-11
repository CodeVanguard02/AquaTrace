import 'package:flutter/material.dart';

class MoreAnnouncementsPage extends StatelessWidget {
  const MoreAnnouncementsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More Announcements'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/backgroundimg.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            _buildAnnouncement(
              context,
              'Water at Doornfontein is contaminated. Citizens in Doornfontein should not drink the water until further notice.',
              '08:30 14/07/2024',
            ),
            const SizedBox(height: 10),
            _buildAnnouncement(
              context,
              'Water rationing will be implemented in the downtown area starting from next week. Residents are advised to conserve water.',
              '09:00 14/07/2024',
            ),
            const SizedBox(height: 10),
            _buildAnnouncement(
              context,
              'The city is conducting a survey on water usage. Please participate to help improve water management.',
              '10:45 14/07/2024',
            ),
            const SizedBox(height: 10),
            _buildAnnouncement(
              context,
              'Maintenance work on the main water pipeline will cause low water pressure in the eastern suburbs tomorrow from 7 AM to 5 PM.',
              '11:30 14/07/2024',
            ),
            const SizedBox(height: 10),
            _buildAnnouncement(
              context,
              'A new water-saving initiative is being introduced by the city council. Details will be shared soon.',
              '12:15 14/07/2024',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnnouncement(BuildContext context, String text, String dateTime) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          const CircleAvatar(
            child: Icon(Icons.announcement),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  dateTime,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
