import 'package:flutter/material.dart';
import 'logingooglescreen.dart';
import 'enablecalendarsscreen.dart';
import 'eventpickerscreen.dart';

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
        '/eventpickerscreen': (context) => EventPickerScreen(),
        //'/home': (context) => const HomeScreen(),
        //... Weitere Routen hinzufügen ...
      }
    );
  }
}



