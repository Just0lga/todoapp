class NoteModel22 {
  String? title;
  String? content;
  String? time;
  int? id;

  NoteModel22({this.title, this.content, this.time, this.id});

  NoteModel22.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    time = json['time'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    data['time'] = this.time;
    data['id'] = this.id;
    return data;
  }
}
