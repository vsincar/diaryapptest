import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Burada seçili gün için olayları filtreleyebilirsiniz
    // Örneğin:
    return [];
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Takvim'),
      ),
      body: Column(
        children: [
          TableCalendar<Event>(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                  _selectedEvents.value = _getEventsForDay(selectedDay);
                });
              }
            },
            eventLoader: (day) => _getEventsForDay(day),
            calendarStyle: CalendarStyle(
              isTodayHighlighted: true,
              selectedDecoration: BoxDecoration(
                color: Color(0xFF2eccfb),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFF636363),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              outsideDaysVisible: false,
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              weekendDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10.0),
              ),
              selectedTextStyle: TextStyle(color: Colors.white),
              todayTextStyle: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${_selectedDay.toLocal().toString().split(' ')[0]} tarihine ait notlar ve günlükler:',

                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _selectedEvents.value.length,
                      itemBuilder: (context, index) {
                        final event = _selectedEvents.value[index];
                        return ListTile(
                          title: Text(event.title),
                          subtitle: Text(event.description),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Event {
  final String title;
  final String description;

  Event({required this.title, required this.description});
}
