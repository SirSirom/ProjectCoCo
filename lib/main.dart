import 'package:flutter/material.dart';
import 'logingooglescreen.dart';
import 'enablecalendarsscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/googleloginscreen',
      routes: {
        '/googleloginscreen': (context) => const LoginGoogleScreen(),
        '/enablecalendarsscreen': (context) => const EnableCalendarsScreen(),
        //'/home': (context) => const HomeScreen(),
        //... Weitere Routen hinzufügen ...
      }
    );
  }
}



