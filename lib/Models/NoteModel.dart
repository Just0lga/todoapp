class NoteModel {
  int id;
  String title;
  String content;
  DateTime time;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
  });

  // Factory constructor to create a NoteModel from JSON
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      time: DateTime.parse(json['time']),
    );
  }
}
