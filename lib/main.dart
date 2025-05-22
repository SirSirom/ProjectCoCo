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

      //setzt die inition route, also der screen, welcher zuerst angezeigt wird
      initialRoute: '/googleloginscreen',
      //alle weiteren möglichen routen
      routes: {
        '/googleloginscreen': (context) => const LoginGoogleScreen(),
        '/enablecalendarsscreen': (context) => const EnableCalendarsScreen(),
        '/eventpickerscreen': (context) => EventPickerScreen(),
        //'/irgendeinscreen': (context) => const IrgendeinScreen(),
        //... routen dann hier hinzufügen ...
      }
    );
  }
}



