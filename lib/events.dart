import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting timestamps
import 'package:image_picker/image_picker.dart'; // for image picking
import 'dart:io'; // for file handling

class PostEventPage extends StatefulWidget {
  @override
  _PostEventPageState createState() => _PostEventPageState();
}

class _PostEventPageState extends State<PostEventPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _datetimeController = TextEditingController();
  File? _eventPosterImage; // for storing the event poster image

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post an Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        labelText: 'Event Title',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an event title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Event Description',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an event description';
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Event Location',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an event location';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      controller: _datetimeController,
                      decoration: InputDecoration(
                        labelText: 'Event Date and Time',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an event date and time';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    // Add a button to upload an event poster image
                    ElevatedButton(
                      onPressed: _selectImage,
                      child: Text('Upload Event Poster'),
                    ),
                    SizedBox(height: 16),
                    // Display the uploaded image
                    _eventPosterImage != null
                        ? Image.file(_eventPosterImage!)
                        : Text('No image uploaded'),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submitEvent,
                      child: Text('Post Event'),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              // Displaying the list of posted events
              Text('Posted Events', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 16),
              _buildPostedEventsList(),
            ],
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
        _eventPosterImage = File(pickedFile.path);
      } else {
        _eventPosterImage = null;
      }
    });
  }

  void _submitEvent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final event = Event(
        title: _titleController.text,
        description: _descriptionController.text,
        location: _locationController.text,
        datetime: DateTime.parse(_datetimeController.text),
        posterImage: _eventPosterImage,
      );
      // Add the event to the database or API here
      print('Event posted: $event');
      _titleController.clear();
      _descriptionController.clear();
      _locationController.clear();
      _datetimeController.clear();
      setState(() {
        _eventPosterImage = null;
        _postedEvents.add(event); // Adding the event to the list
      });
    }
  }

  Widget _buildPostedEventsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _postedEvents.length,
      itemBuilder: (context, index) {
        final event = _postedEvents[index];
        return Card(
          child: ListTile(
            title: Text(event.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.description),
                Text('Location: ${event.location}'),
                Text('Date and Time: ${DateFormat.yMMMd().add_jm().format(event.datetime)}'),
                if (event.posterImage != null)
                  Image.file(event.posterImage!),
              ],
            ),
          ),
        );
      },
    );
  }
}

class Event {
  final String title;
  final String description;
  final String location;
  final DateTime datetime;
  final File? posterImage;

  Event({
    required this.title,
    required this.description,
    required this.location,
    required this.datetime,
    this.posterImage,
  });
}

// Example events already posted
List<Event> _postedEvents = [
  Event(
    title: 'Music Festival',
    description: 'Join us for a day of music and fun!',
    location: 'Central Park',
    datetime: DateTime.parse('2023-06-01 12:00:00'),
    posterImage: null,
  ),
  Event(
    title: 'Food Festival',
    description: 'Come and try delicious food from around the world!',
    location: 'Downtown Area',
    datetime: DateTime.parse('2023-07-15 10:00:00'),
    posterImage: null,
  ),
];
