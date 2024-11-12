import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import 'add_entry.dart';

class DetailEntry extends StatelessWidget {
  final DiaryEntry entry;

  DetailEntry({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final updatedEntry = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEntry(existingEntry: entry),
                ),
              );
              if (updatedEntry != null) {
                Navigator.pop(context, updatedEntry);  // Return updated entry
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          entry.content,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
