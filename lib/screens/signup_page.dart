import 'package:flutter/material.dart';
import '../models/dummy_user_db.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void signUp() {

    String username = usernameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill all fields")),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    if (DummyUserDB.userExists(username)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Username already exists")),
      );
      return;
    }

    DummyUserDB.addUser(username, password);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Account created successfully")),
    );

    Navigator.pop(context); // go back to login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create Account", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),

            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Username"),
            ),

            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),

            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "Confirm Password"),
            ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: signUp,
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}