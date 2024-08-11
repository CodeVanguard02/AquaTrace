import 'package:flutter/material.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';

class WaterIssueReportPage extends StatefulWidget {
  @override
  _WaterIssueReportPageState createState() => _WaterIssueReportPageState();
}

class _WaterIssueReportPageState extends State<WaterIssueReportPage> {
  final _formKey = GlobalKey<FormState>();
  String? _issueDescription;
  String? _contactName;
  String? _contactPhone;
  String? _address;
  double? _latitude;
  double? _longitude;

  void _pickLocation() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Pick Location')),
          body: OpenStreetMapSearchAndPick(
            onPicked: (pickedData) {
              setState(() {
                _latitude = pickedData.latLong.latitude;
                _longitude = pickedData.latLong.longitude;
                _address = _formatAddress(pickedData.address);
              });
              Navigator.pop(context);
            },
            buttonText: 'Pick this location',
          ),
        ),
      ),
    );
  }

  String _formatAddress(Map<String, dynamic> addressMap) {
    String? road = addressMap['road'];
    String? suburb = addressMap['suburb'];
    String? city = addressMap['city'];
    String? country = addressMap['country'];
    return [road, suburb, city, country].where((part) => part != null && part.isNotEmpty).join(', ');
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Submit report logic here (e.g., sending data to a backend)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Report submitted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Issue Report'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgroundimg.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Issue Description Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Issue Description',
                      labelStyle: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter a description of the issue';
                      }
                      return null;
                    },
                    onSaved: (value) => _issueDescription = value,
                  ),
                  const SizedBox(height: 16),
                  // Contact Name Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Name',
                      labelStyle: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) => _contactName = value,
                  ),
                  const SizedBox(height: 16),
                  // Contact Phone Number Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Contact Phone Number',
                      labelStyle: TextStyle(color: Colors.teal[700], fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                    onSaved: (value) => _contactPhone = value,
                  ),
                  const SizedBox(height: 16),
                  // Location Picker Button
                  ElevatedButton(
                    onPressed: _pickLocation,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text('Select Location on Map'),
                  ),
                  if (_latitude != null && _longitude != null)
                    Column(
                      children: [
                        const SizedBox(height: 10),
                        Text(
                          'Selected Location: $_latitude, $_longitude',
                          style: TextStyle(color: Colors.teal[900], fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Address: $_address',
                          style: TextStyle(color: Colors.teal[900], fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  const SizedBox(height: 16),
                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: _submitReport,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50), // Button height
                        backgroundColor: Colors.blue, // Button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      child: const Text(
                        'Submit Report',
                        style: TextStyle(fontSize: 18),
                      ),
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
}
