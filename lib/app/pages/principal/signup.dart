import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:plantilla_ca/app/pages/principal/PersonalFinance.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
        elevation: 0,
        backgroundColor: Color.fromRGBO(1, 139, 73, 1),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Correo Electrónico',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.email),
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
            SizedBox(height: 16.0),
            TextField(
              controller: confirmPasswordController,
              decoration: InputDecoration(
                labelText: 'Confirmar Contraseña',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                  child: Icon(
                    isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
              ),
              obscureText: !isConfirmPasswordVisible,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(0, 151, 178, 1)),
              ),
              onPressed: () {
                final username = usernameController.text;
                final email = emailController.text;
                final password = passwordController.text;
                final confirmPassword = confirmPasswordController.text;
                _register(context, username, email, password, confirmPassword);
              },
              child: Text('Registrarse'),
            ),
          ],
        ),
      ),
    );
  }

  void _register(BuildContext context, String username, String email,
      String password, String confirmPassword) async {
    // Verificar si las contraseñas coinciden
    if (password != confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error de registro'),
            content: Text('Las contraseñas no coinciden.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    // Obtener el directorio de documentos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path;
    String filename = 'loginSign.json';
    File file = File('$path/MOMA/$filename');

    // Verificar si el archivo y el directorio existen, si no, crearlos
    if (!await file.exists()) {
      file.createSync(recursive: true);
    }

    // Crear un mapa con los datos de registro
    Map<String, dynamic> registrationData = {
      'username': username,
      'email': email,
      'password': password,
    };

    // Convertir el mapa a una cadena JSON
    String jsonData = jsonEncode(registrationData);

    // Escribir la cadena JSON en el archivo
    file.writeAsStringSync(jsonData);

    // Registro exitoso, navegar a la página de finanzas personales
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonalFinancePage(),
      ),
    );
  }
}
