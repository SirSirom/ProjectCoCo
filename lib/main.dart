import 'package:flutter/material.dart';

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

class LoginGoogleScreen extends StatelessWidget {
  const LoginGoogleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( //scaffold für die App
      backgroundColor: Colors.brown,
      body: Center( //body für die App
        child: Column( //basically ist die ganze Page eine einspaltige Tabelle
          mainAxisAlignment: MainAxisAlignment.center, //eine zentriete tabelle
          children: [

            //BILD
            ClipRRect( //für die Rounded Corners
              borderRadius: BorderRadius.circular(20.0),

              child: Image.asset(
                'assets/logo.jpg', // Replace with your logo asset path
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),

            ),

            //SPACING
            const SizedBox(height: 50),

            //ÜBERSCHIFT
            const Text(
              'CoCo',
              style: TextStyle(
                fontSize: 52,
                color: Colors.white,
                fontFamily: 'Times New Roman',
                fontWeight: FontWeight.bold,
              ),
            ),

            //SPACING
            const SizedBox(height: 20),

            //TEXT
            Container(
              width: 300, // Adjust width as needed
              padding: const EdgeInsets.all(25), //Platz zw. Text & Border
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.white, width: 4),
              ),
              child: const Text(
                'CoCo ist ein Projekt, bei den man yappa yappa yappa yip yap yop',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'Times New Roman',
                ),
                textAlign: TextAlign.center,
              ),
            ),


            //SPACING
            const SizedBox(height: 30),

            //GOOGLE SIGN IN BUTTON
            ElevatedButton.icon(
              onPressed: () {
                //TODO
                // Handle Google Sign-in logic here
                print('Sign in with Google pressed');
                //if(google authenticated){}
                Navigator.pushNamed(context, '/enablecalendarsscreen');
              },
              icon: Image.asset(
                'assets/google_logo.png',
                width: 24,
                height: 24,
              ),
              label: const Text('Sign in with Google'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class EnableCalendarsScreen extends StatelessWidget {
  const EnableCalendarsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enable Calendars'),
      ),
      body: Center(

        //TEXT
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Please enable Calendars you want to be colored by CoCo"
          ),
        ),

      )
    );
  }
}
