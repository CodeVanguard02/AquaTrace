import 'package:flutter/material.dart';

class PlumberAdPage extends StatefulWidget {
  @override
  _PlumberAdPageState createState() => _PlumberAdPageState();
}

class _PlumberAdPageState extends State<PlumberAdPage> {
  final _formKey = GlobalKey<FormState>();
  late String _plumberName;
  late String _services;
  late String _price;
  late String _contact;
  late String _location;

  // List of plumber ads
  List<PlumberAd> plumberAds = [
    PlumberAd(
      name: 'John Doe Plumbing',
      services: 'Leak Repair, Pipe Installation',
      price: 'From \R50', //
      contact: 'john.doe@gmail.com',
      location: 'Johannesburg',
    ),
    PlumberAd(
      name: 'Jane Smith Plumbing',
      services: 'Drain Cleaning, Water Heater Repair',
      price: 'From \R70', // Escape dollar sign
      contact: 'jane.smith@gmail.com',
      location: 'Cape Town',
    ),
  ];

  // Search filters
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plumber Ads'),
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
                      labelText: 'Plumber Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the plumber\'s name';
                      }
                      return null;
                    },
                    onSaved: (value) => _plumberName = value!,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Services',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the services provided';
                      }
                      return null;
                    },
                    onSaved: (value) => _services = value!,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the price range';
                      }
                      return null;
                    },
                    onSaved: (value) => _price = value!,
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
                          plumberAds.add(
                            PlumberAd(
                              name: _plumberName,
                              services: _services,
                              price: _price,
                              contact: _contact,
                              location: _location,
                            ),
                          );
                        });
                        print('Plumber ad posted successfully!');
                      }
                    },
                    child: Text('Post Ad'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Search by name or location',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Note: These plumber ads are not verified. Please exercise caution when contacting or hiring plumbers.',
              style: TextStyle(color: Colors.red),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: plumberAds
                    .where((ad) =>
                ad.name.toLowerCase().contains(_searchQuery) ||
                    ad.location.toLowerCase().contains(_searchQuery))
                    .length,
                itemBuilder: (context, index) {
                  final ad = plumberAds
                      .where((ad) =>
                  ad.name.toLowerCase().contains(_searchQuery) ||
                      ad.location.toLowerCase().contains(_searchQuery))
                      .toList()[index];
                  return PlumberAdCard(plumberAd: ad);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlumberAd {
  final String name;
  final String services;
  final String price;
  final String contact;
  final String location;

  PlumberAd({
    required this.name,
    required this.services,
    required this.price,
    required this.contact,
    required this.location,
  });
}

class PlumberAdCard extends StatelessWidget {
  final PlumberAd plumberAd;

  const PlumberAdCard({required this.plumberAd});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              plumberAd.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Services: ${plumberAd.services}'),
            SizedBox(height: 8),
            Text('Price: ${plumberAd.price}'),
            SizedBox(height: 8),
            Text('Contact: ${plumberAd.contact}'),
            SizedBox(height: 8),
            Text('Location: ${plumberAd.location}'),
          ],
        ),
      ),
    );
  }
}
