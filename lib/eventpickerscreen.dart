
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:project_coco/api/models/CalendarModel.dart';
import 'package:project_coco/api/models/EventModel.dart';
import 'package:project_coco/api/models/PropertyModel.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:project_coco/api/util/ApiHelper.dart';

class EventPickerScreen extends StatefulWidget {
  const EventPickerScreen({super.key});

@override
  _EventPickerScreenState createState() => _EventPickerScreenState();
}

class _EventPickerScreenState extends State<EventPickerScreen> {
  //variblen initalisieren
  final TextEditingController _searchController = TextEditingController();
  Map<String,PropertyModel> _properties = {};
  List<CalendarModel> _calendars = [];
  List<EventModel> _events = [];
  DateTime _startDate = DateTime(2024); //das default ausgewählte startdatum
  DateTime _endDate = DateTime(2026); //das default ausgewählte enddatum
  late List<EventModel> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
  _loadProperties().then((_) {
  });
  _loadEnabledCalendars().then((_) {
    _loadEvents(_calendars).then((_) {
      _filterEvents();
    });
  });


  }
  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
  }

  //filtert die events nach dem suchfeld mit contains
  void _filterEvents() {
    setState(() {
      List<EventModel> noDubs = groupBy(_events, (EventModel event) => event.title).values.map((group) => group.first).toList();
      _filteredEvents = noDubs.where((event) {
        return event.title.toLowerCase().contains(_searchController.text.toLowerCase());
      }).toList();
    });
  }

  //date-picker dialogfenster
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
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
      _loadEvents(_calendars).then((_) {
        _filterEvents();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],

      //app bar oben
      appBar: AppBar(
        title: Text("Event Picker", style: TextStyle(fontSize: 24, fontFamily: 'NewComputerModern')),
        backgroundColor: Colors.brown,
        foregroundColor: Colors.white,
        actions: [

          //drei-Punkt-Optionen Fenster
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'switch_account') {
                print('Switch Account selected'); //TODO switch-account implementieren
              } else
              if (value == 'logout') {
                print('Log Out selected'); //TODO: logout implementieren
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'switch_account',
                  child: Text('Switch Account'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Log Out'),
                ),
              ];
            },
          ),

        ],
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
                //rand
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide(width: 2.0, color: Colors.brown),
                ),
                //ändert den rand wenn fokussiert
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
                    // ignore: unnecessary_null_comparison
                    _startDate == null
                        ? "Start Date"
                        : "${_startDate.day}.${_startDate.month}.${_startDate.year}",
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
                    // ignore: unnecessary_null_comparison
                    _endDate == null
                        ? "End Date"
                        : "${_endDate.day}.${_endDate.month}.${_endDate.year}",
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
                final event = _filteredEvents[index];
                final eventTitle = "\"${event.title.replaceAll("\\", "\\\\").replaceAll("\"", "\\\"")}\"";
                final eventProperty = _properties.containsKey(eventTitle) ? _properties[eventTitle] : _properties.putIfAbsent(eventTitle, () => PropertyModel(color: EventColor.NONE, hidden: false));
                return Column(
                  children: [
                    ListTile(
                      title: Text(event.title, style: TextStyle(fontSize: 18, fontFamily: 'NewComputerModern', )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          //EIN/AUSBLENDEN
                          IconButton(
                            icon: Icon(
                              eventProperty!.hidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                eventProperty.hidden = !eventProperty.hidden;
                              });
                            },
                          ),

                          //FARBWEAHLER
                          IconButton(
                            icon: Icon(Icons.color_lens, color: eventProperty.color.color),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Wähle eine Farbe", style: TextStyle(fontSize: 18, fontFamily: 'NewComputerModern', )),
                                    content: SingleChildScrollView(
                                      child: BlockPicker(
                                        pickerColor: eventProperty.color.color,
                                        availableColors: List<Color>.from(EventColor.values.map((eventColor) => eventColor.color)),
                                        onColorChanged: (Color color) {
                                          setState(() {
                                            eventProperty.color = EventColor.fromColor(color);
                                          });
                                          _saveProperties();
                                        },
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(fontSize: 18, fontFamily: 'NewComputerModern', ),
                                        ),
                                      ),
                                    ],

                                  );
                                },
                              );
                            },
                          )
                        ]
                      ),
                      onTap: () {
                        print('Tapped on ${_filteredEvents[index]}'); //TODO: Event öffnen?
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

  Future<void> _loadProperties() async{
  Map<String,PropertyModel> properties = await ApiHelper.loadProperties();
    setState(() {
      _properties = properties;
    });
  }
  Future<void> _loadEnabledCalendars() async{
    List<CalendarModel> calendars = await ApiHelper.loadEnabledCalendars();
    setState(() {
      _calendars = calendars;
    });
  }
  Future<void> _loadEvents(List<CalendarModel> calendars) async{
    List<EventModel> events = [];
    for (CalendarModel calendar in calendars) {
      events.addAll(await ApiHelper.loadEvents(calendar.id, startTime: _startDate, endTime: _endDate));
    }
    setState(() {
      _events = events;
    });
  }
  Future<void> _saveProperties() async{
    await ApiHelper.saveProperties(_properties);
    _loadProperties();
  }
}

