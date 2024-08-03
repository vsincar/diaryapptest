import 'package:flutter/material.dart';
import 'package:diaryapptest/screens/create_page.dart';
import 'package:diaryapptest/screens/calendar_page.dart';
import 'package:diaryapptest/screens/notes_page.dart';
import 'package:diaryapptest/screens/settings_page.dart';

class MainPage extends StatefulWidget {
  final Function(bool) toggleDarkMode;

  MainPage({Key? key, required this.toggleDarkMode}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Oluştur',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Takvim',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Notlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
          ),
        ],
        backgroundColor: Colors.white,
        unselectedItemColor: Color(0xFF636363),
        currentIndex: currentIndex,
        selectedItemColor: const Color(0xFF2eccfb),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
      ),
    );
  }

  List<Widget> get pages => [
    const CreatePage(),
    const CalendarPage(),
    NotesPage(),
    SettingsPage(toggleDarkMode: widget.toggleDarkMode),
  ];
}
