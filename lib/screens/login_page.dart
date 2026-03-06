import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'signup_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(BuildContext context) {
    if (usernameController.text == "user" &&
        passwordController.text == "1234") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DashboardPage(username: usernameController.text,)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Invalid login")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("MesraPlant", style: TextStyle(fontSize: 28)),
            SizedBox(height: 20),
            TextField(controller: usernameController, decoration: InputDecoration(labelText: "Username")),
            TextField(controller: passwordController, obscureText: true, decoration: InputDecoration(labelText: "Password")),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => SignUpPage()));
              },
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}
