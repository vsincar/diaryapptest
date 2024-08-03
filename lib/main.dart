import 'package:flutter/material.dart';
import 'screens/login_page.dart';
import 'screens/main_page.dart';
import 'theme/main_theme.dart';
import 'screens/create_page.dart';
import 'screens/calendar_page.dart';
import 'screens/notes_page.dart';
import 'screens/settings_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _isDarkMode ? darkTheme : lightTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/main': (context) => MainPage(toggleDarkMode: _toggleDarkMode),
        '/create': (context) => const CreatePage(),
        '/calendar': (context) => const CalendarPage(),
        '/notes': (context) => NotesPage(),
        '/settings': (context) => SettingsPage(toggleDarkMode: _toggleDarkMode),
      },
    );
  }
}
