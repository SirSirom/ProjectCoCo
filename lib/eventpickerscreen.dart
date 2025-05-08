import 'package:flutter/material.dart';

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
  ]; // Replace with your actual event data
  List<String> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filteredEvents = _events;
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
      appBar: AppBar(
        title: Text("Event Picker"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: "Search Events",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _filterEvents(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () => _selectDate(context, true),
                  child: Text(
                    _startDate == null
                        ? "Start Date"
                        : "${_startDate!.day}.${_startDate!.month}.${_startDate!.year}",
                  ),
                ),
                ElevatedButton(
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
          Expanded(
            child: ListView.builder(
              itemCount: _filteredEvents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_filteredEvents[index]),
                  // Add onTap to navigate or do something with the selected event
                  onTap: () {
                    // Handle event tap
                    print('Tapped on ${_filteredEvents[index]}');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

