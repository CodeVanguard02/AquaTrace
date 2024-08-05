import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:io';

class ReportLeakagePage extends StatefulWidget {
  const ReportLeakagePage({Key? key}) : super(key: key);

  @override
  _ReportLeakagePageState createState() => _ReportLeakagePageState();
}

class _ReportLeakagePageState extends State<ReportLeakagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _image;
  LatLng? _currentPosition;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedImage;
    });
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _submitReport() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Implement the submission logic here, e.g., send the data to the backend
      print('Description: ${_descriptionController.text}');
      print('Image path: ${_image?.path}');
      print('Location: ${_currentPosition?.latitude}, ${_currentPosition?.longitude}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Water Leakage'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Describe the leak',
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description of the leak';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: const Text('Attach Picture'),
                  ),
                  const SizedBox(width: 10),
                  _image == null
                      ? const Text('No image selected')
                      : Image.file(
                    File(_image!.path),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _currentPosition == null
                  ? ElevatedButton(
                onPressed: _getCurrentLocation,
                child: const Text('Select Location'),
              )
                  : Column(
                children: [
                  Text('Location: ${_currentPosition!.latitude}, ${_currentPosition!.longitude}'),
                  SizedBox(
                    height: 200,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: _currentPosition!,
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: MarkerId('currentLocation'),
                          position: _currentPosition!,
                        ),
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitReport,
                child: const Text('Submit Report'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
