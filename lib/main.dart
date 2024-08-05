import 'package:flutter/material.dart';
import 'SeeReport.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mysql1/mysql1.dart';
import 'chat.dart';
import 'report_page.dart';
void main() => runApp(const AquaTraceApp());

class AquaTraceApp extends StatelessWidget {
  const AquaTraceApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaTrace2',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const SignInCitizenPage(),
    );
  }
}
class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final String imagePath;

  const BackgroundWidget({Key? key, required this.child, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
//start of the signinascitizen page
class SignInCitizenPage extends StatelessWidget {
  const SignInCitizenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In as Citizen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SignInForm(
            title: 'Citizen',
            onSignUp: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignUpPage()),
              );
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInAdminPage()),
                  );
                },
                child: const Text('Sign In as Admin'),
              ),
              const SizedBox(width: 10),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInPlumberPage()),
                  );
                },
                child: const Text('Sign In as Plumber'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
//start of the signinasadmin page
class SignInAdminPage extends StatelessWidget {
  const SignInAdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In as Admin'),
      ),
      body: SignInForm(
        title: 'Admin',
        onSignUp: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpPage()),
          );
        },
      ),
    );
  }
}
//start of the signinasplumber page
class SignInPlumberPage extends StatelessWidget {
  const SignInPlumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In as Plumber'),
      ),
      body: SignInForm(
        title: 'Plumber',
        onSignUp: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignUpPage()),
          );
        },
      ),
    );
  }
}
//Register page
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: const SignUpForm(),
    );
  }
}

class SignInForm extends StatefulWidget {
  final String title;
  final VoidCallback onSignUp;

  const SignInForm({Key? key, required this.title, required this.onSignUp}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  String _meterno = '';
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Implement your sign-in logic here (e.g., call Firebase Auth)
      print('${widget.title} Email: $_email');
      print('Meter number: $_meterno');
      print('Password: $_password');

      // Navigate to the main page (assuming it exists)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Meter number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your meter number';
                }
                return null;
              },
              onSaved: (value) {
                _meterno = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Sign In as ${widget.title}'),
            ),
            TextButton(
              onPressed: widget.onSignUp,
              child: const Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _surname = '';
  String _cellno = '';
  String _meterno = '';
  String _email = '';
  String _confirmEmail = '';
  String _password = '';
  String _confirmPassword = '';
  String _selectedGender = 'Male';
  final List<String> _genders = ['Male', 'Female', 'Other'];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Implement your sign-up logic here (e.g., call Firebase Auth)
      print('Name: $_name');
      print('Surname: $_surname');
      print('Meter number: $_meterno');
      print('Cellphone number: $_cellno');
      print('Sign Up Email: $_email');
      print('Confirm email: $_confirmEmail');
      print('Sign Up Password: $_password');
      print('Confirm password: $_confirmPassword');
      print('Selected Gender: $_selectedGender');
      // Navigate to the main page (assuming it exists)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _name = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Surname'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your surname';
                }
                return null;
              },
              onSaved: (value) {
                _surname = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Meter number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your home water meter number';
                }
                return null;
              },
              onSaved: (value) {
                _meterno = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'CellPhone Number'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your cellphone number';
                }
                return null;
              },
              onSaved: (value) {
                _cellno = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) {
                _email = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Email'),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value != _email || value == null) {
                  return 'Emails do not match';
                }
                return null;
              },
              onSaved: (value) {
                _confirmEmail = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) {
                _password = value!;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
              validator: (value) {
                if (value != _password || value == null) {
                  return 'Passwords do not match';
                }
                return null;
              },
              onSaved: (value) {
                _confirmPassword = value!;
              },
            ),
            DropdownButtonFormField(
              decoration: const InputDecoration(labelText: 'Gender'),
              value: _selectedGender,
              items: _genders.map((String gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedGender = value as String;
                });
              },
              onSaved: (value) {
                _selectedGender = value as String;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
//Start of the home page
class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            // Add more ListTile widgets here for additional menu items
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
              ),
              child: Column(
                children: [
                  const Text(
                    'Water Credit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Text(
                      '110L/300L',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SeeReportPage()),
                      );
                    }, // Implement see report logic
                    child: const Text('See Report'),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Text(
                    'Recent Water Updates',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildWaterUpdate(
                    context,
                    'Due to a burst pipe, water service is currently disrupted in the Oakwood neighborhood. Repair crews are on-site, and the issue is expected to be resolved by 6 PM today.',
                    '18:09 13/07/2024',
                  ),
                  const SizedBox(height: 10),
                  _buildWaterUpdate(
                    context,
                    'The city has announced that water will be shut off on Main Street from 9 AM to 2 PM tomorrow for maintenance work; residents are advised to store enough water in advance.',
                    '18:09 13/07/2024',
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Implement see more logic
                    },
                    child: const Text('See more...'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.credit_card),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          if (index == 3) {
            // Navigate to ProfilePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
          if (index == 2) {
            // Navigate to ProfilePage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatScreen(passengerName: 'Sinesipho')),
            );
          }
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportPage()),
            );
          }
        },
      ),
    );
  }
}

Widget _buildWaterUpdate(BuildContext context, String text, String dateTime) {
  return Row(
    children: [
      const CircleAvatar(
        child: Icon(Icons.admin_panel_settings),
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
  );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

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
            GestureDetector(
              onTap: () {
                print('Upload profile picture');
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_placeholder.png'),
              ),
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
                  MaterialPageRoute(builder: (context) => const SignInCitizenPage()),
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

