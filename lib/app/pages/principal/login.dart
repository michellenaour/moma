import 'package:flutter/material.dart';
import 'package:plantilla_ca/app/pages/principal/PersonalFinance.dart';
import 'package:plantilla_ca/app/pages/principal/signin.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                final username = usernameController.text;
                final password = passwordController.text;
                _login(context, username, password);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                 final username = usernameController.text;
                final password = passwordController.text;
                _signin(context, username, password);
               
              },
              child: Text('SignIn'),
            ),
          ],

        ),
      ),
    );
  }

  void _login(BuildContext context, String username, String password) {
    // Perform your login logic here

    // Assuming login is successful, navigate to the main page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalFinancePage(),
      ),
    );
  }
    void _signin(BuildContext context, String username, String password) {
    // Perform your login logic here

    // Assuming login is successful, navigate to the main page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignInPage(),
      ),
    );
  }
}


