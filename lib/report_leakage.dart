import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'dart:io';

class ReportLeakagePage extends StatefulWidget {
  const ReportLeakagePage({Key? key}) : super(key: key);

  @override
  _ReportLeakagePageState createState() => _ReportLeakagePageState();
}

class _ReportLeakagePageState extends State<ReportLeakagePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  List<XFile?> _images = [];
  String? _address;
  double? _latitude;
  double? _longitude;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    if (_images.length < 3) {
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        setState(() {
          _images.add(pickedImage);
        });
      }
    } else {
      // Show a message that only 3 images are allowed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You can only attach up to 3 images.')),
      );
    }
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
                _address = _formatAddress(pickedData.address);  // Format the address correctly
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report Water Leakage'),
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
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Description TextFormField with styling
                        TextFormField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            labelText: 'Describe the leak',
                            labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
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
                        // Image Attachment Section
                        Text(
                          'Attach Leakage Pictures (up to 3):',
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            for (var i = 0; i < 3; i++)
                              Container(
                                margin: const EdgeInsets.only(right: 10),
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: _images.length > i
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.file(
                                    File(_images[i]!.path),
                                    fit: BoxFit.cover,
                                  ),
                                )
                                    : IconButton(
                                  icon: const Icon(Icons.add_a_photo, color: Colors.blueAccent),
                                  onPressed: _pickImage,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Location Picker Button
                        ElevatedButton(
                          onPressed: _pickLocation,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
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
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Address: $_address',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              // Submit Button
              Padding(
                padding: const EdgeInsets.all(16.0),
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
        ],
      ),
    );
  }
}
