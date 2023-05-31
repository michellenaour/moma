import 'package:flutter/material.dart';
import 'package:plantilla_ca/app/pages/principal/PersonalFinance.dart';


class SignInPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromRGBO(1, 139, 73, 1),
        title: Text('Login Page'),
         leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
      ),
      ),
      
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Regístrate',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
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
               style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(0,151,178,1)), // Set the desired background color here
          ),
             
              onPressed: () {
                final username = usernameController.text;
                final password = passwordController.text;
                },
              child: Text('Registrarse'),
            ),
           
          ],

        ),
      ),
    );
  }

}


