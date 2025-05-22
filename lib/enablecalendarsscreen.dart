import 'package:flutter/material.dart';

class EnableCalendarsScreen extends StatefulWidget {
  const EnableCalendarsScreen({super.key});

  @override
  State<EnableCalendarsScreen> createState() => _EnableCalendarsScreenState();
}

class _EnableCalendarsScreenState extends State<EnableCalendarsScreen> {
  // viele beispieleinträge, um scrollbarkeit zu testen
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

      //die appbar am oberen rand
      appBar: AppBar(
        title: const Text('Enable Calendars', style: TextStyle(fontFamily: 'NewComputerModern', fontSize: 24,)),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
      ),


      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), //padding vom ganzen inhalt zum rand, sieht besser aus
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //.center sah auf größeren screens nicht so gut aus wie .start(links)
              children: [

                //TEXT
                const Text(
                  "Wähle die Kalender aus, welche CoCo bearbeiten soll",
                  style: TextStyle(color: Colors.white, fontSize: 21, fontFamily: 'NewComputerModern'),
                ),

                //SPACING
                const SizedBox(height: 20),

                //SCROLLABLE LIST
                Expanded( //Expanded macht es, dass das ListView.builder() den ganzen Platz des Containers einnimmt
                  child: ListView.builder( //macht die eigentliche scrollable list
                    itemCount: _calendars.length,
                    itemBuilder: (context, index) { //wird für jeden eintrag gecalled
                      return ListTile(

                        //AN/AUS SWITCH
                        leading: Switch(
                          value: _calendars[index]['enabled'],
                          onChanged: (bool newValue) {
                            setState(() {
                              _calendars[index]['enabled'] = newValue;
                            });
                          },
                          activeColor: Colors.green,
                          inactiveTrackColor: Colors.brown[100],
                          inactiveThumbColor: Colors.brown[400],
                          //TODO: grauen ränder der inaktiven auf brown[100] setzen, sind gerade grau
                        ),

                        //TITEL/TEXT DES EINTRAGS
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

          //CONTINUE/SKIP BUTTONS
          Positioned( //sollen unabhängig von den anderen Inhalten immer unten rechts positioniert werden, deswegen dieser container
            bottom: 16,
            right: 16,
            child: Row(
              children: [
                TextButton(onPressed: (){ Navigator.pushNamed(context, '/eventpickerscreen'); },
                    child: const Text("skip", style: TextStyle(color: Colors.white, fontSize: 18, fontFamily: 'NewComputerModern'))),
                ElevatedButton(onPressed: (){ Navigator.pushNamed(context, '/eventpickerscreen'); }, style: ElevatedButton.styleFrom(backgroundColor: Colors.brown[100]),
                    child: const Text("continue", style: TextStyle(color: Colors.black, fontSize: 18, fontFamily: 'NewComputerModern')))
              ],
            ),
          ),
        ],
      ),
    );
  }
}