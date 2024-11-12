import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/diary_entry.dart';

class ApiService {
  final String baseUrl = 'http://localhost:5000/api/diaryEntries';  // Replace with your backend URL

  // Fetch all diary entries from the backend
  Future<List<DiaryEntry>> getEntries() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/entries'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((entry) => DiaryEntry.fromJson(entry)).toList();
      } else {
        throw Exception('Failed to load entries');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load entries');
    }
  }

  // Add a new diary entry to the backend
  static Future<void> addEntry(DiaryEntry entry) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/api/diaryEntries/add'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(entry.toJson()),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add entry');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to add entry');
    }
  }

  // Update an existing diary entry
  static Future<void> updateEntry(String id, DiaryEntry entry) async {
    try {
      final response = await http.put(
        Uri.parse('http://localhost:5000/api/diaryEntries/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(entry.toJson()),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update entry');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to update entry');
    }
  }

  // Delete a diary entry from the backend
   Future<void> deleteEntry(String id) async {
    try {
      final response = await http.delete(Uri.parse('http://localhost:5000/api/diaryEntries/$id'));

      if (response.statusCode != 200) {
        throw Exception('Failed to delete entry');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to delete entry');
    }
  }
}
