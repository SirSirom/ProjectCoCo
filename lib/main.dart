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
                'assets/images/logo.png', // Replace with your logo asset path
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),

            ),

            //SPACING
            const SizedBox(height: 30),

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

class EnableCalendarsScreen extends StatefulWidget {
  const EnableCalendarsScreen({super.key});

  @override
  State<EnableCalendarsScreen> createState() => _EnableCalendarsScreenState();
}

class _EnableCalendarsScreenState extends State<EnableCalendarsScreen> {
  // Sample data for calendars
  final List<Map<String, dynamic>> _calendars = [
    {'name': 'Calendar 1', 'enabled': false},
    {'name': 'Calendar 2', 'enabled': true},
    {'name': 'Calendar 3', 'enabled': false},
    {'name': 'Calendar 4', 'enabled': true},
    {'name': 'Calendar 5', 'enabled': false},
    {'name': 'Calendar 6', 'enabled': false},
    {'name': 'Calendar 7', 'enabled': true},
    {'name': 'Calendar 8', 'enabled': false},
    {'name': 'Calendar 9', 'enabled': true},
    {'name': 'Calendar 10', 'enabled': false},
    {'name': 'Calendar 11', 'enabled': true},
    {'name': 'Calendar 12', 'enabled': false},
    {'name': 'Calendar 13', 'enabled': true},
    {'name': 'Calendar 14', 'enabled': false},
    {'name': 'Calendar 15', 'enabled': true},
    {'name': 'Calendar 16', 'enabled': false},
    {'name': 'Calendar 17', 'enabled': true},
    {'name': 'Calendar 18', 'enabled': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,

      appBar: AppBar(
        title: const Text('Enable Calendars',
            style: TextStyle(color: Colors.black, fontSize: 24, fontFamily: 'NewComputerModern')),
        backgroundColor: Colors.brown[100],
      ),

      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                //TEXT
                const Text(
                  "Please enable calendars you want to be colored by CoCo",
                  style: TextStyle(color: Colors.white, fontSize: 21, fontFamily: 'NewComputerModern'),
                ),

                //SPACING
                const SizedBox(height: 20),

                //SCROLLABLE LIST
                Expanded(
                  child: ListView.builder(
                    itemCount: _calendars.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Switch(
                          value: _calendars[index]['enabled'],
                          onChanged: (bool newValue) {
                            setState(() {
                              _calendars[index]['enabled'] = newValue;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveTrackColor: Colors.brown[100],

                        ),
                        title: Text(
                          _calendars[index]['name'],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18, fontFamily: 'NewComputerModern'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: Row(
              children: [
                TextButton(onPressed: (){},
                    child: const Text("skip", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'NewComputerModern'))),
                ElevatedButton(onPressed: (){}, child: const Text("continue", style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'NewComputerModern')), style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[100]))
              ],
            ),
          ),
        ],
      ),
    );
  }
}