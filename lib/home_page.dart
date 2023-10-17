// Import necessary libraries
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // For storing user data locally

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create controllers for input fields
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _favouriteNumberController = TextEditingController();

  // Declare variables to store user data
  String username = "";
  String name = "";
  bool likesCoffee = false;
  int favouritenumber = 0;

  @override
  void initState() {
    // This method is called when the widget is first created
    loadUserData(); // Load user data from SharedPreferences when the widget is initialized
    super.initState(); // Call the parent class's initState method
  }

  // Asynchronous method to load user data from SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // Update the state with the data retrieved from SharedPreferences
      _usernameController.text = prefs.getString('username').toString();
      _emailController.text = prefs.getString('email').toString();
      likesCoffee = prefs.getBool('likesCoffee') ?? false;
      _favouriteNumberController.text =
          prefs.getInt('favouriteNumber').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(label: Text("Username")),
            ),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'email'),
            ),
            TextField(
              controller: _favouriteNumberController,
              decoration: const InputDecoration(labelText: 'Favourite number'),
            ),
            Row(
              children: [
                const Text("Likes Coffee ?"),
                Switch(
                  value: likesCoffee,
                  onChanged: ((value) {
                    setState(() {
                      likesCoffee = !likesCoffee;
                    });
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveUserData(); // Call the method to save user data
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green[400],
                    content: const Text('User data saved'),
                  ),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  // Asynchronous method to save user data to SharedPreferences
  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setBool('likesCoffee', likesCoffee);
    await prefs.setInt(
        'favouriteNumber', int.parse(_favouriteNumberController.text));
  }
}
