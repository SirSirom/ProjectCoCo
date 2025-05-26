import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:project_coco/api/models/CalendarModel.dart';

import 'api/util/ApiHelper.dart';

class EnableCalendarsScreen extends StatefulWidget {
  const EnableCalendarsScreen({super.key});

  @override
  State<EnableCalendarsScreen> createState() => _EnableCalendarsScreenState();
}

class _EnableCalendarsScreenState extends State<EnableCalendarsScreen> {
  // Sample data for calendars
  List<CalendarModel> _calendars = [];
  @override
  void initState(){
    super.initState();
    _loadCalendars().then((_) {
    });
  }



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
                          value: _calendars[index].registered,
                          onChanged: (bool newValue) {
                              _sendNewRegisteredState(newValue,_calendars[index]);
                          },
                          activeColor: Colors.green,
                          inactiveTrackColor: Colors.brown[100],
                          inactiveThumbColor: Colors.brown[400],
                          //TODO: grauen ränder der inaktiven auf brown[100] setzen
                        ),
                        title: Text(
                          _calendars[index].name,
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

  Future<void> _loadCalendars() async {
    List<CalendarModel> calendars = await ApiHelper.loadCalendars();
    setState(() {
      _calendars = calendars;
    });
  }
  Future<void> _sendNewRegisteredState(bool newValue, CalendarModel calendar) async {
    setState(() {
      calendar.registered = newValue;
    });
    if (newValue) {
      print((await ApiHelper.enableCalendar(calendar.id)).body);
    }else{
      await ApiHelper.disableCalendar(calendar.id);
    }
    _loadCalendars();
  }
}

