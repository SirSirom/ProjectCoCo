import 'package:flutter/material.dart';

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
        title: const Text('Enable Calendars', style: TextStyle(fontFamily: 'NewComputerModern', fontSize: 24,)),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
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
                          inactiveThumbColor: Colors.brown[400],
                          //TODO: grauen ränder der inaktiven auf brown[100] setzen
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