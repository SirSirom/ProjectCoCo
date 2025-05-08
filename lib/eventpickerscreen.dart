import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EventPickerScreen extends StatefulWidget {
  @override
  _EventPickerScreenState createState() => _EventPickerScreenState();
}

class _EventPickerScreenState extends State<EventPickerScreen> {
  final TextEditingController _searchController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  List<String> _events = [
    "Event 1",
    "Event 2",
    "Event 3",
    "Event 4",
    "Event 5",
    "Event 6"
  ];
  List<bool> _eventVisible = [];
  List<Color> _eventColor = [];
  List<String> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filteredEvents = _events;
  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    _eventColor = List<Color>.filled(_events.length, Colors.black);
    _eventVisible= List<bool>.filled(_events.length, false);
  }

  void _filterEvents() {
    setState(() {
      _filteredEvents = _events.where((event) {
        // Implement date filtering logic here if necessary
        // You might need to compare event dates with _startDate and _endDate
        return event
            .toLowerCase()
            .contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate ?? DateTime.now() : _endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Event Picker", style: TextStyle(fontSize: 24, fontFamily: 'NewComputerModern')),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,

      ),
      body: Column(
        children: [

          //SEACH BAR
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search Events",
                labelStyle: TextStyle(fontSize: 18, fontFamily: 'NewComputerModern', ),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 2.0, color: Colors.brown),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(color: Colors.brown, width: 4.0),
                ),
              ),
              onChanged: (value) => _filterEvents(),
            ),
          ),

          //DATE BUTTONS
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [

                //START DATE BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _selectDate(context, true),
                  child: Text(
                    _startDate == null
                        ? "Start Date"
                        : "${_startDate!.day}.${_startDate!.month}.${_startDate!.year}",
                  ),
                ),

                //END DATE BUTTON
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => _selectDate(context, false),
                  child: Text(
                    _endDate == null
                        ? "End Date"
                        : "${_endDate!.day}.${_endDate!.month}.${_endDate!.year}",
                  ),
                ),
              ],
            ),
          ),

          //LIST OF EVENTS
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEvents.length,
              itemBuilder: (context, index) {
                final eventIndex = _events.indexOf(_filteredEvents[index]);
                return Column(
                  children: [
                    ListTile(
                      title: Text(_filteredEvents[index], style: TextStyle(fontSize: 18, fontFamily: 'NewComputerModern', )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          //EIN/AUSBLENDEN
                          IconButton(
                            icon: Icon(
                              _eventVisible[eventIndex]
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _eventVisible[eventIndex] = !_eventVisible[eventIndex];
                              });
                            },
                          ),

                          //FARBWEAHLER
                          IconButton(
                            icon: Icon(Icons.color_lens, color: _eventColor[eventIndex]),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Wähle eine Farbe", style: TextStyle(fontSize: 18, fontFamily: 'NewComputerModern', )),
                                    content: Text("Farb auswahl hier"),
                                    actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: Text("OK", style: TextStyle(fontSize: 18, fontFamily: 'NewComputerModern', )))],
                                  );
                                },
                              );
                            },
                          ),
                        ]
                      ),
                      onTap: () {

                        print('Tapped on ${_filteredEvents[index]}');
                      },
                    ),

                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

