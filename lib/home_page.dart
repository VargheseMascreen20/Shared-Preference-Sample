import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _favouriteNumberController = TextEditingController();
  String username = "";
  String name = "";
  bool likesCoffee = false;
  int favouritenumber = 0;

  @override
  void initState() {
    // TODO: implement initState
    loadUserData();

    super.initState();
  }

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
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
        title: Text('Registration Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                  // labelText: username ?? "Enter Username",
                  label: Text("Username")),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'email'),
            ),
            TextField(
              controller: _favouriteNumberController,
              decoration: InputDecoration(labelText: 'Favourite number'),
            ),
            Row(
              children: [
                Text("Likes Coffee ?"),
                Switch(
                    value: likesCoffee,
                    onChanged: ((value) {
                      setState(() {
                        likesCoffee = !likesCoffee;
                      });
                    })),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                saveUserData();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green[400],
                    content: Text('User data saved'),
                  ),
                );
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('email', _emailController.text);
    await prefs.setBool('likesCoffee', likesCoffee);
    await prefs.setInt(
        'favouriteNumber', int.parse(_favouriteNumberController.text));
  }
}
