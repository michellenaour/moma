import 'package:flutter/material.dart';
import 'package:plantilla_ca/app/pages/example/example_view.dart';
import 'package:plantilla_ca/app/pages/principal/PersonalFinance.dart';
import 'package:plantilla_ca/app/pages/principal/login.dart';
import 'package:plantilla_ca/app/pages/my_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), //const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
