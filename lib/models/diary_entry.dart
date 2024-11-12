class DiaryEntry {
  final String id;
  final String title;
  final String content;

  DiaryEntry({
    required this.id,
    required this.title,
    required this.content,
  });

  // Method to convert the object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
    };
  }

  // Method to create an object from JSON
  factory DiaryEntry.fromJson(Map<String, dynamic> json) {
    return DiaryEntry(
      id: json['_id'],  // Backend may return an "_id" field
      title: json['title'],
      content: json['content'],
    );
  }
}
