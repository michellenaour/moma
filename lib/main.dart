import 'package:flutter/material.dart';
import 'package:plantilla_ca/app/pages/example/example_view.dart';
import 'package:plantilla_ca/app/pages/principal/PersonalFinance.dart';
import 'package:plantilla_ca/app/pages/principal/login.dart';
import 'package:plantilla_ca/app/pages/my_app.dart';
import 'package:flutter/material.dart';
import 'package:plantilla_ca/app/pages/example/example_view.dart';
import 'package:plantilla_ca/app/pages/principal/PersonalFinance.dart';
import 'package:plantilla_ca/app/pages/principal/login.dart';
import 'package:plantilla_ca/app/pages/my_app.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadingPage(), // Mostrar pantalla de carga al inicio
      // ...
    );
  }
}

// ...

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    _loadApp();
  }

  void _loadApp() async {
    // Simular una carga de la aplicación
    await Future.delayed(Duration(seconds: 3));

    // Navegar a la página de inicio de sesión después de cargar la aplicación
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
            ),
            SizedBox(height: 16.0),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
