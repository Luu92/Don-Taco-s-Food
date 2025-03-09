import 'package:demo_app/presentation/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.black),
        debugShowCheckedModeBanner: false,
        home: Login());
  }
}
