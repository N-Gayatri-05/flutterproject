import 'package:flutter/material.dart';
import 'screens/entry_list.dart';

void main() {
  runApp(DiaryApp());
}

class DiaryApp extends StatefulWidget {
  @override
  _DiaryAppState createState() => _DiaryAppState();
}

class _DiaryAppState extends State<DiaryApp> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    EntryList(),  // Diary entries list
    // Add other screens (e.g., Profile, Settings) later if needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Diary',
      theme: ThemeData(
        primaryColor: Color(0xFF1E88E5),
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Personal Diary'),
        ),
        body: _children[_currentIndex],  // Navigation for different screens
      ),
    );
  }
}
