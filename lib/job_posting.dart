import 'package:flutter/material.dart';

class JobPostingPage extends StatefulWidget {
  @override
  _JobPostingPageState createState() => _JobPostingPageState();
}

class _JobPostingPageState extends State<JobPostingPage> {
  final _formKey = GlobalKey<FormState>();
  late String _jobTitle;
  late String _jobDescription;
  late String _skills;
  late String _contact;
  late String _location;

  // List of job posts
  List<JobPost> jobPosts = [
    JobPost(
      title: 'Software Engineer',
      description: 'Experienced software engineer needed for a startup',
      skills: 'Java, Python, JavaScript',
      contact: 'twarisani@gmail.com',
      location: 'Johannesburg',
    ),
    JobPost(
      title: 'Job Seeker',
      description: 'Looking for a job as a software engineer',
      skills: 'Java, Python, JavaScript',
      contact: 'masibonge@gmail.com',
      location: 'Limehill',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Postings'),
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
                    decoration: InputDecoration(
                      labelText: 'Job Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a job title';
                      }
                      return null;
                    },
                    onSaved: (value) => _jobTitle = value!,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Job Description',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a job description';
                      }
                      return null;
                    },
                    onSaved: (value) => _jobDescription = value!,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Skills',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your skills';
                      }
                      return null;
                    },
                    onSaved: (value) => _skills = value!,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Information',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your contact information';
                      }
                      return null;
                    },
                    onSaved: (value) => _contact = value!,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the location';
                      }
                      return null;
                    },
                    onSaved: (value) => _location = value!,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        setState(() {
                          jobPosts.add(
                            JobPost(
                              title: _jobTitle,
                              description: _jobDescription,
                              skills: _skills,
                              contact: _contact,
                              location: _location,
                            ),
                          );
                        });
                        print('Job posted successfully!');
                      }
                    },
                    child: Text('Post Job'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Note: These job postings are not verified. Please exercise caution when applying for jobs.',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: jobPosts.length,
                itemBuilder: (context, index) {
                  return JobPostCard(jobPost: jobPosts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JobPost {
  final String title;
  final String description;
  final String skills;
  final String contact;
  final String location;

  JobPost({
    required this.title,
    required this.description,
    required this.skills,
    required this.contact,
    required this.location,
  });
}

class JobPostCard extends StatelessWidget {
  final JobPost jobPost;

  const JobPostCard({required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobPost.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(jobPost.description),
            SizedBox(height: 8),
            Text('Skills: ${jobPost.skills}'),
            SizedBox(height: 8),
            Text('Contact: ${jobPost.contact}'),
            SizedBox(height: 8),
            Text('Location: ${jobPost.location}'),
          ],
        ),
      ),
    );
  }
}