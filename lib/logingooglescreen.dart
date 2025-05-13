import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

//Init google sign in Scopes für Google Auth
const List<String> scopes = <String>[
  'email',
  'https://www.googleapis.com/auth/calendar'
];//alle scopes: https://developers.google.com/identity/protocols/oauth2/scopes

GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId: 'your-client_id.apps.googleusercontent.com',
  scopes: scopes,
);

class LoginGoogleScreen extends StatelessWidget {
  const LoginGoogleScreen({super.key});

  @override
  Widget build(BuildContext context) {

    Future<void> _handleSignIn() async {
      try {
        await _googleSignIn.signIn();
      } catch (error) {
        print(error);
      }
    }

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
                'CoCo ist ein Projekt, bei den man yappa yappa yappa yip yap yop',
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
                //await _handleSignIn();    erstmal ausgesetzt
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