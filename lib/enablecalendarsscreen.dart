import 'package:flutter/material.dart';
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
    ///load calendars on init
    _loadCalendars().then((_) {
    });
  }



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
                          value: _calendars[index].registered,
                          onChanged: (bool newValue) {
                              _sendNewRegisteredState(newValue,_calendars[index]);
                          },
                          activeColor: Colors.green,
                          inactiveTrackColor: Colors.brown[100],
                          inactiveThumbColor: Colors.brown[400],
                          //TODO: grauen ränder der inaktiven auf brown[100] setzen, sind gerade grau
                        ),

                        //TITEL/TEXT DES EINTRAGS
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

          //CONTINUE/SKIP BUTTONS
          Positioned( //sollen unabhängig von den anderen Inhalten immer unten rechts positioniert werden, deswegen dieser container
            bottom: 16,
            right: 16,
            child: Row(
              children: [
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
    ///Load calendars from API and setState after
    List<CalendarModel> calendars = await ApiHelper.loadCalendars();
    setState(() {
      _calendars = calendars;
    });
  }
  Future<void> _sendNewRegisteredState(bool newValue, CalendarModel calendar) async {
    ///send new registered state from API and reload calendars after
    ///reload will trigger new setState
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