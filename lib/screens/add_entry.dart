import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../services/api_service.dart';

class AddEntry extends StatefulWidget {
  final DiaryEntry? existingEntry;

  AddEntry({this.existingEntry});

  @override
  _AddEntryState createState() => _AddEntryState();
}

class _AddEntryState extends State<AddEntry> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingEntry != null) {
      titleController.text = widget.existingEntry!.title;
      contentController.text = widget.existingEntry!.content;
    }
  }

  _saveEntry() async {
    try {
      final title = titleController.text;
      final content = contentController.text;

      if (title.isEmpty || content.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Please fill in both title and content.'),
        ));
        return;
      }

      final newEntry = DiaryEntry(
        id: '',
        title: title,
        content: content,
      );

      if (widget.existingEntry == null) {
        // Creating new entry
        await ApiService.addEntry(newEntry);
      } else {
        // Updating existing entry
        final updatedEntry = DiaryEntry(
          id: widget.existingEntry!.id,
          title: title,
          content: content,
        );
        await ApiService.updateEntry(widget.existingEntry!.id, updatedEntry);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Entry saved successfully!'),
      ));

      Navigator.pop(context);  // Navigate back after saving/updating
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingEntry == null ? 'Add Entry' : 'Edit Entry'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: contentController,
              decoration: InputDecoration(labelText: 'Content'),
              maxLines: 5,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveEntry,
              child: Text(widget.existingEntry == null ? 'Save' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}
