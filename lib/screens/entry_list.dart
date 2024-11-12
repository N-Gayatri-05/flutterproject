import 'package:flutter/material.dart';
import '../models/diary_entry.dart';
import '../services/api_service.dart';
import 'add_entry.dart';
import 'detail_entry.dart';

class EntryList extends StatefulWidget {
  @override
  _EntryListState createState() => _EntryListState();
}

class _EntryListState extends State<EntryList> {
  List<DiaryEntry> entries = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    final apiService = ApiService();
    final fetchedEntries = await apiService.getEntries();
    setState(() {
      entries = fetchedEntries;
    });
  }

  void navigateToAddEntry() async {
    // Navigate to AddEntry screen and await the result
    final shouldReload = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEntry()),
    );

    // If the result is true, reload the list of entries
    if (shouldReload != null && shouldReload) {
      _loadEntries();
    }
  }

  void deleteEntry() {
    final entry = entries[_currentIndex];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete Entry"),
          content: Text("Are you sure you want to delete this entry?"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await ApiService().deleteEntry(entry.id);
                setState(() {
                  entries.removeAt(_currentIndex);
                  if (_currentIndex > 0) {
                    _currentIndex--;
                  }
                });
              },
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }

  void navigateToDetailEntry(DiaryEntry entry) async {
    final updatedEntry = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailEntry(entry: entry),
      ),
    );

    if (updatedEntry != null) {
      setState(() {
        entries[_currentIndex] = updatedEntry;
      });
    }
  }

  void previousEntry() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
    }
  }

  void nextEntry() {
    if (_currentIndex < entries.length - 1) {
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diary Entries'),
      ),
      body: entries.isEmpty
          ? Center(child: CircularProgressIndicator())
          : SizedBox(
        height: 550,
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(150.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  entries[_currentIndex].title,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    size: 40,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => navigateToDetailEntry(entries[_currentIndex]),
                ),
                SizedBox(height: 20),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    size: 40,
                    color: Colors.red,
                  ),
                  onPressed: deleteEntry,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                onPressed: previousEntry,
                child: Icon(Icons.arrow_back),
                heroTag: "prev_button",
                backgroundColor: Theme.of(context).primaryColor,
              ),
              FloatingActionButton(
                onPressed: nextEntry,
                child: Icon(Icons.arrow_forward),
                heroTag: "next_button",
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ],
          ),
          SizedBox(height: 20),
          FloatingActionButton(
            onPressed: navigateToAddEntry,
            child: Icon(Icons.add),
            heroTag: "add_button",
            backgroundColor: Theme.of(context).colorScheme.secondary,
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Entry ${_currentIndex + 1} of ${entries.length}",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
