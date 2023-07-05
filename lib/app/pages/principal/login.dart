import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:MOMO/app/pages/principal/PersonalFinance.dart';
import 'package:MOMO/app/pages/principal/signup.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio de Sesión'),
        elevation: 0,
        backgroundColor: Color.fromRGBO(1, 139, 73, 1),
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
                labelText: 'Nombre de Usuario',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: !isPasswordVisible,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(0, 151, 178, 1)),
              ),
              onPressed: () {
                final username = usernameController.text;
                final password = passwordController.text;
                _login(context, username, password);
              },
              child: Text('Ingresar'),
            ),
            SizedBox(height: 24.0),
            GestureDetector(
              onTap: () {
                _signin(context);
              },
              child: Text(
                'Registrarse',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color.fromRGBO(0, 151, 178, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login(
      BuildContext context, String username, String password) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/MOMA/loginSign.json');

      // Verificar si el archivo existe
      if (await file.exists()) {
        final jsonData = await file.readAsString();
        final user = json.decode(jsonData);

        if (user['username'] == username && user['password'] == password) {
          // Inicio de sesión exitoso
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => PersonalFinancePage(),
            ),
          );
          return;
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error de inicio de sesión'),
              content: Text('El archivo de inicio de sesión no existe.'),
              actions: [
                ElevatedButton(
                  child: Text('Aceptar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }

      // Si no se encuentra una coincidencia o el archivo no existe, mostrar mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de inicio de sesión'),
            content: Text('Credenciales incorrectas. Inténtelo nuevamente.'),
            actions: [
              ElevatedButton(
                child: Text('Aceptar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error de inicio de sesión: $e');
      // Manejo de errores de inicio de sesión
    }
  }

  void _signin(BuildContext context) {
    // Perform your login logic here

    // Assuming login is successful, navigate to the main page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUpPage(),
      ),
    );
  }
}
