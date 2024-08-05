import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mysql1/mysql1.dart';
import 'dart:async';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  Completer<GoogleMapController> _mapController = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 300, // Set a fixed height for the map
        child: GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController.complete(controller);
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(0, 0),
            zoom: 15,
          ),
          onTap: (LatLng latLng) {
            setState(() {
              // _location = latLng;
            });
          },
        ),
      ),
    );
  }
}

class WaterIssueReportPage extends StatefulWidget {
  @override
  _WaterIssueReportPageState createState() => _WaterIssueReportPageState();
}

class _WaterIssueReportPageState extends State<WaterIssueReportPage> {
  final _formKey = GlobalKey<FormState>();
  String? _issueDescription;
  String? _contactName;
  String? _contactPhone;
  LatLng? _location;
  final Completer<GoogleMapController> _mapController = Completer();

  Future<void> _getLocation() async {
    final GoogleMapController? controller = await _mapController.future;
    if (controller != null) {
      controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: _location ?? LatLng(0, 0),
          zoom: 15,
        ),
      ));
    }
  }

  Future<void> _submitReport() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final conn = await MySqlConnection.connect(
        ConnectionSettings(
          host: 'your_host', // Replace with your host
          port: 3306, // Replace with your port
          user: 'your_user', // Replace with your user
          password: 'your_password', // Replace with your password
          db: 'your_database', // Replace with your database
        ),
      );

      await conn.query(
        'INSERT INTO water_issue_reports (issue_description, contact_name, contact_phone, latitude, longitude) VALUES (?,?,?,?,?)',
        [
          _issueDescription,
          _contactName,
          _contactPhone,
          _location?.latitude,
          _location?.longitude,
        ],
      );

      await conn.close();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Report submitted successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Water Issue Report'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Issue Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a description of the issue';
                    }
                    return null;
                  },
                  onSaved: (value) => _issueDescription = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _contactName = value,
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Contact Phone Number',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter your phone number';
                    }
                    return null;
                  },
                  onSaved: (value) => _contactPhone = value,
                ),
                SizedBox(height: 16),
                Container(
                  height: 300, // Fixed height for the map
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      _mapController.complete(controller);
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(0, 0),
                      zoom: 15,
                    ),
                    onTap: (LatLng latLng) {
                      setState(() {
                        _location = latLng;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitReport,
                  child: Text('Submit Report'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
