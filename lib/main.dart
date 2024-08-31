import 'package:flutter/material.dart';
import 'SeeReport.dart';
import 'report_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'announcements.dart';
import 'education_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mysql1/mysql1.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'trading.dart';
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
      home: SignInPage(),
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
class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _usernameController = TextEditingController();
  final _meterNumberController = TextEditingController();
  final _passwordController = TextEditingController();

  String _errorMessage = '';

  void _login() {
    setState(() {
      _errorMessage = '';
      String username = _usernameController.text;
      String meterNumber = _meterNumberController.text;
      String password = _passwordController.text;

      if (username.isEmpty || meterNumber.isEmpty || password.isEmpty) {
        _errorMessage = 'Username, Meter Number, and Password cannot be empty.';
      } else if (meterNumber.length != 7 || !RegExp(r'^[0-9]+$').hasMatch(meterNumber)) {
        _errorMessage = 'Meter Number must be a 7-digit number.';
      } else {
        // Navigate to Home Page
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    });
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/backgroundimg.jpeg',
              fit: BoxFit.cover,
            ),
          ),


          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or Icon
                  Container(
                    height: 200,
                    child: Image.asset('assets/logo.png'),
                  ),
                  SizedBox(height: 30),

                  // Username TextField
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Meter Number TextField
                  TextField(
                    controller: _meterNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Meter Number',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Password TextField
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),

                  // Error Message
                  if (_errorMessage.isNotEmpty)
                    Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),

                  SizedBox(height: 20),

                  // Login Button
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Log In'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Button color
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Signup and Forgot Password
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: _navigateToSignUp,
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle forgotten password action
                    },
                    child: Text(
                      'Forgotten Password',
                      style: TextStyle(color: Colors.blue),
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

      print('${widget.title} Email: $_email');
      print('Meter number: $_meterno');
      print('Password: $_password');

      // Navigate to the main page
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

  // TextEditingControllers to handle the input values for comparison
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _confirmEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Pop-up message for successful registration
      Fluttertoast.showToast(
        msg: "Account created successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      // Navigate to the Sign-In page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignInPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/backgroundimg.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          // Dark overlay to enhance text visibility
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.3), // Adjust opacity as needed
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                      const SizedBox(height: 16.0),

                      // Surname Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Surname',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                      const SizedBox(height: 16.0),

                      // Cell Phone Number Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Cell Phone Number',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                      const SizedBox(height: 16.0),

                      // Meter Number Field
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Meter Number',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your home water meter number';
                          } else if (value.length != 7 || !RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Meter Number must be a 7-digit number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _meterno = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                      const SizedBox(height: 16.0),

                      // Confirm Email Field
                      TextFormField(
                        controller: _confirmEmailController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Email',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your email';
                          }
                          if (value != _emailController.text) {
                            return 'Emails do not match';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _confirmEmail = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                      const SizedBox(height: 16.0),

                      // Confirm Password Field
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _confirmPassword = value!;
                        },
                      ),
                      const SizedBox(height: 16.0),

                      // Gender Dropdown Field
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Gender',
                          labelStyle: const TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
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
                      const SizedBox(height: 20.0),

                      // Register Button
                      ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Register'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: Colors.blue, // Match the register button style
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Sign-In Navigation Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.white),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigate to the Sign-In page
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => SignInPage()),
                              );
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                color: Colors.blue, // Match the sign-in button style
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


//Start of the home page


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  File? _imageFile;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Account'),
        backgroundColor: Colors.blue,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : AssetImage('assets/profileplaceholder.png') as ImageProvider,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Masibonge', // Replace with the logged-in user's name
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ],
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Update PIN'),
              onTap: () async {
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
                  MaterialPageRoute(builder: (context) => SignInPage()),
                      (route) => false,
                );
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Support',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
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
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/backgroundimg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              // Row containing the text and CircleAvatar
              Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Welcome Text
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: const Text(
                          'Welcome to AquaTrace',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // CircleAvatar
                    Container(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/background.jpeg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: CircleAvatar(
                            radius: 95,
                            backgroundColor: Colors.transparent,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Water Credit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                const Text(
                                  '110L/330L',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const SeeReportPage()),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue[900],
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                  ),
                                  child: const Text(
                                    'See Report',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: const Text(
                            'Recent Announcements',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildWaterUpdate(
                          context,
                          'The city has announced that water will be shut off on Main Street from 9 AM to 2 PM tomorrow for maintenance work; residents are advised to store enough water in advance.',
                          '18:09 13/07/2024',
                        ),
                        const SizedBox(height: 10),
                        _buildWaterUpdate(
                          context,
                          'Due to a burst pipe, water service is currently disrupted in the Oakwood neighborhood. Repair crews are on-site, and the issue is expected to be resolved by 6 PM today.',
                          '18:59 13/07/2024',
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const MoreAnnouncementsPage()),
                            );
                          },
                          child: const Text(
                            'See more...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blueAccent,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.blue[900],
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'House',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Report',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Transactions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.public),
            label: 'Awareness',
          ),
        ],
        onTap: (int index) {
          if (index == 0) {
            // Navigate to home page
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WaterTradingPage()),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HygieneAwarenessPage()),
            );
          }
        },
      ),
    );
  }

  Widget _buildWaterUpdate(BuildContext context, String text, String dateTime) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
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
                  style: const TextStyle(fontSize: 16, color: Colors.white),
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