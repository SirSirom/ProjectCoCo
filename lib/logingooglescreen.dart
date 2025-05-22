import 'package:flutter/material.dart';
import 'package:project_coco/signin/GoogleLogin.dart';

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
                'assets/images/logo.png', // Replace with your logo asset path
                width: 300,
                height: 300,
                fit: BoxFit.cover,
              ),

            ),

            //SPACING
            const SizedBox(height: 0),

            //ÜBERSCHIFT
            const Text(
              'CoCo',
              style: TextStyle(
                fontSize: 52,
                color: Colors.white,
                fontFamily: 'NewComputerModern',
              ),
            ),

            //SPACING
            const SizedBox(height: 40),

            //TEXT
            Container(
              width: 300, // Adjust width as needed
              padding: const EdgeInsets.all(25), //Platz zw. Text & Border
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
                border: Border.all(color: Colors.brown.shade100, width: 4),
              ),
              child: const Text(
                'CoCo ist ein Projekt, welches verschiedene Events aus deinen Google-Kalendern so einfärbt oder ausblendet, wie du es möchtest.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontFamily: 'NewComputerModern',
                ),
                textAlign: TextAlign.center,
              ),
            ),


            //SPACING
            const SizedBox(height: 30),

            //GOOGLE SIGN IN BUTTON
            ElevatedButton.icon(
              onPressed: () async {
                await GoogleLogin.handleSignIn();
                Navigator.pushNamed(context, '/enablecalendarsscreen');
              },
              icon: Image.asset(
                'assets/images/google_logo.png',
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